import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
// ignore: depend_on_referenced_packages
import 'package:async/async.dart';
import 'package:wellnessbridge/theme/theme.dart';
import 'package:permission_handler/permission_handler.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> worker;
  final bool isDarkMode;
  final VoidCallback onProfileUpdated;

  const EditProfileScreen({
    super.key,
    required this.worker,
    required this.isDarkMode,
    required this.onProfileUpdated,
  });

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Image handling variables
  File? _imageFile;
  Uint8List? _webImage;
  String? _networkImageUrl;
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.worker['name'] ?? '';
    _emailController.text = widget.worker['email'] ?? '';
    _phoneController.text = widget.worker['telephone'] ?? '';

    // Handle image URL - ensure it's a full URL
    final imageUrl = widget.worker['image'];
    if (imageUrl != null && imageUrl.toString().isNotEmpty) {
      if (imageUrl.toString().startsWith('http')) {
        _networkImageUrl = imageUrl.toString();
      } else {
        // If it's just a filename, construct the full URL
        _networkImageUrl = 'http://127.0.0.1:8000/storage/images/$imageUrl';
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Request permissions for camera and gallery
  Future<bool> _requestPermission(Permission permission) async {
    if (kIsWeb) return true;

    var status = await permission.status;
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      status = await permission.request();
      return status.isGranted;
    } else if (status.isPermanentlyDenied) {
      _showPermissionSettingsDialog(permission);
      return false;
    }
    return false;
  }

  void _showPermissionSettingsDialog(Permission permission) {
    final permissionName =
        permission == Permission.camera ? 'Camera' : 'Photos';

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('$permissionName Permission Required'),
            content: Text(
              '$permissionName access is required to update your profile picture. Please enable it in app settings.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings();
                },
                child: Text('Open Settings'),
              ),
            ],
          ),
    );
  }

  Future<void> _showImageSourceDialog() async {
    final Color textColor = widget.isDarkMode ? Colors.white : Colors.black87;
    final Color backgroundColor =
        widget.isDarkMode ? AppTheme.navy : Colors.white;
    final Color accentColor =
        widget.isDarkMode ? AppTheme.amber : AppTheme.rustOrange;

    showModalBottomSheet(
      context: context,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select Image Source',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildImageSourceOption(
                      icon: Icons.camera_alt,
                      label: 'Camera',
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.camera);
                      },
                      accentColor: accentColor,
                      textColor: textColor,
                    ),
                    _buildImageSourceOption(
                      icon: Icons.photo_library,
                      label: 'Gallery',
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.gallery);
                      },
                      accentColor: accentColor,
                      textColor: textColor,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.red : Colors.green,
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'DISMISS',
            textColor: Colors.white,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
    }
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      if (!mounted) return;
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      final workerId = widget.worker['id'] ?? widget.worker['hwID'];
      if (workerId == null) {
        _showSnackBar('Worker ID not found.', isError: true);
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
        return;
      }

      var url = Uri.parse(
        'http://127.0.0.1:8000/api/v1/healthworkers/$workerId/update-profile',
      );

      try {
        var request = http.MultipartRequest('POST', url);

        // Add text fields
        request.fields['name'] = _nameController.text;
        request.fields['email'] = _emailController.text;
        request.fields['telephone'] = _phoneController.text;
        request.fields['_method'] = 'PUT';

        // Add image if available
        if (_imageFile != null) {
          var stream = http.ByteStream(
            // ignore: deprecated_member_use
            DelegatingStream.typed(_imageFile!.openRead()),
          );
          var length = await _imageFile!.length();

          var multipartFile = http.MultipartFile(
            'image',
            stream,
            length,
            filename: path.basename(_imageFile!.path),
          );
          request.files.add(multipartFile);
        } else if (_webImage != null) {
          request.files.add(
            http.MultipartFile.fromBytes(
              'image',
              _webImage!,
              filename: 'profile_image.jpg',
            ),
          );
        }

        var streamedResponse = await request.send().timeout(
          const Duration(seconds: 60),
        );
        var response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          Map<String, dynamic> responseData = json.decode(response.body);
          _showSnackBar(
            responseData['message'] ?? 'Profile updated successfully!',
            isError: false,
          );

          if (mounted) {
            // Call the callback to refresh the parent screen
            widget.onProfileUpdated();

            // Wait a bit for the callback to process, then pop with updated data
            await Future.delayed(Duration(milliseconds: 500));

            // Pop with the updated worker data from the backend
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop(responseData['data']);
          }
        } else if (response.statusCode == 422) {
          Map<String, dynamic> responseData = json.decode(response.body);
          String validationErrors = 'Validation failed:';
          if (responseData.containsKey('errors') &&
              responseData['errors'] is Map) {
            (responseData['errors'] as Map).forEach((key, value) {
              validationErrors += '\n- ${value[0]}';
            });
          } else {
            validationErrors =
                responseData['message'] ?? 'Validation error occurred.';
          }
          _showSnackBar(validationErrors, isError: true);
        } else {
          Map<String, dynamic> responseData = {};
          String errorMessage;
          try {
            responseData = json.decode(response.body);
            errorMessage =
                responseData['message'] ??
                'Failed to update profile. Status: ${response.statusCode}';
          } catch (e) {
            errorMessage =
                'Server error. Status: ${response.statusCode}. Could not parse response.';
          }
          _showSnackBar(errorMessage, isError: true);
        }
      } on http.ClientException catch (e) {
        _showSnackBar('Network error: ${e.message}', isError: true);
      } on SocketException {
        _showSnackBar(
          'No internet connection. Please check your network.',
          isError: true,
        );
      } on TimeoutException {
        _showSnackBar('Request timed out. Please try again.', isError: true);
      } catch (e) {
        _showSnackBar('An unexpected error occurred: $e', isError: true);
        debugPrint('Unexpected error in _updateProfile: $e');
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else {
      _showSnackBar(
        'Please fill in all required fields correctly.',
        isError: true,
      );
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    if (!kIsWeb) {
      final permission =
          source == ImageSource.camera ? Permission.camera : Permission.photos;
      final granted = await _requestPermission(permission);
      if (!granted) return;
    }

    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        if (kIsWeb) {
          final bytes = await pickedFile.readAsBytes();
          setState(() {
            _webImage = bytes;
            _imageFile = null;
            _networkImageUrl =
                null; // Clear network image when new image is picked
          });
        } else {
          setState(() {
            _imageFile = File(pickedFile.path);
            _webImage = null;
            _networkImageUrl =
                null; // Clear network image when new image is picked
          });
        }
      }
    } catch (e) {
      _showSnackBar('Failed to pick image: $e', isError: true);
    }
  }

  Widget _buildImageSourceOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color accentColor,
    required Color textColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            // ignore: deprecated_member_use
            backgroundColor: accentColor.withOpacity(0.15),
            // ignore: sort_child_properties_last
            child: Icon(icon, color: accentColor, size: 28),
            radius: 28,
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  ImageProvider? _getProfileImage() {
    if (_imageFile != null) {
      return FileImage(_imageFile!);
    } else if (_webImage != null) {
      return MemoryImage(_webImage!);
    } else if (_networkImageUrl != null && _networkImageUrl!.isNotEmpty) {
      return NetworkImage(_networkImageUrl!);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: widget.isDarkMode ? Colors.white : AppTheme.navy,
          ),
        ),
        backgroundColor: widget.isDarkMode ? AppTheme.navy : Colors.white,
        iconTheme: IconThemeData(
          color: widget.isDarkMode ? Colors.white : AppTheme.navy,
        ),
      ),
      backgroundColor: widget.isDarkMode ? AppTheme.navy : Colors.white,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 450),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Profile Image
                    GestureDetector(
                      onTap: _showImageSourceDialog,
                      child: Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 80,
                              backgroundColor:
                                  widget.isDarkMode
                                      // ignore: deprecated_member_use
                                      ? AppTheme.amber.withOpacity(0.2)
                                      // ignore: deprecated_member_use
                                      : AppTheme.amber.withOpacity(0.3),
                              backgroundImage: _getProfileImage(),
                              child:
                                  (_imageFile == null &&
                                          _webImage == null &&
                                          _networkImageUrl == null)
                                      ? Icon(
                                        Icons.person,
                                        size: 80,
                                        color:
                                            widget.isDarkMode
                                                ? AppTheme.amber
                                                : AppTheme.navy,
                                      )
                                      : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color:
                                      widget.isDarkMode
                                          ? AppTheme.blue
                                          : AppTheme.rustOrange,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),

                    Center(
                      child: Text(
                        'Tap to change profile picture',
                        style: TextStyle(
                          color:
                              widget.isDarkMode
                                  ? Colors.white70
                                  : Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Name Field
                    TextFormField(
                      controller: _nameController,
                      style: TextStyle(
                        color:
                            widget.isDarkMode ? Colors.white : Colors.black87,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          color:
                              widget.isDarkMode
                                  ? AppTheme.amber
                                  : AppTheme.navy,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                widget.isDarkMode
                                    ? Colors.white70
                                    : Colors.black54,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                widget.isDarkMode
                                    ? AppTheme.amber
                                    : AppTheme.blue,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        hintText: 'Enter your name',
                        hintStyle: TextStyle(
                          color:
                              widget.isDarkMode
                                  ? Colors.white70
                                  : Colors.black54,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12),

                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        color:
                            widget.isDarkMode ? Colors.white : Colors.black87,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color:
                              widget.isDarkMode
                                  ? AppTheme.amber
                                  : AppTheme.navy,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                widget.isDarkMode
                                    ? Colors.white70
                                    : Colors.black54,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                widget.isDarkMode
                                    ? AppTheme.amber
                                    : AppTheme.blue,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(
                          color:
                              widget.isDarkMode
                                  ? Colors.white70
                                  : Colors.black54,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(
                          r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ).hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12),

                    // Phone Number Field
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                        color:
                            widget.isDarkMode ? Colors.white : Colors.black87,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(
                          color:
                              widget.isDarkMode
                                  ? AppTheme.amber
                                  : AppTheme.navy,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                widget.isDarkMode
                                    ? Colors.white70
                                    : Colors.black54,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                widget.isDarkMode
                                    ? AppTheme.amber
                                    : AppTheme.blue,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        hintText: 'Enter your phone number',
                        hintStyle: TextStyle(
                          color:
                              widget.isDarkMode
                                  ? Colors.white70
                                  : Colors.black54,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // Error message
                    if (_errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          _errorMessage,
                          style: TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ),

                    // Update Button
                    ElevatedButton(
                      onPressed: _isLoading ? null : _updateProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            widget.isDarkMode
                                ? AppTheme.blue
                                : AppTheme.rustOrange,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child:
                          _isLoading
                              ? SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                  strokeWidth: 2.0,
                                ),
                              )
                              : Text(
                                'Update Profile',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
