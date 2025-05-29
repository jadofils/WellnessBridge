import 'package:flutter/material.dart';
import 'package:wellnessbridge/theme/theme.dart';
import 'package:wellnessbridge/theme/snack_bar.dart';
import 'package:wellnessbridge/backend_api/health_workers/health_workers_api.dart';
import 'package:intl/intl.dart';

class HealthWorkerProfileScreen extends StatefulWidget {
  final String workerId;
  final bool isDarkMode;
  final Function? onProfileUpdated;

  const HealthWorkerProfileScreen({
    super.key,
    required this.workerId,
    required this.isDarkMode,
    this.onProfileUpdated,
  });

  @override
  _HealthWorkerProfileScreenState createState() =>
      _HealthWorkerProfileScreenState();
}

class _HealthWorkerProfileScreenState extends State<HealthWorkerProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isSaving = false;
  String? _errorMessage;

  // Form controllers
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _roleController;
  late TextEditingController _dobController;
  late TextEditingController _imageController;
  late TextEditingController _passwordController;
  String _selectedGender = 'Male';

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadWorkerDetails();
  }

  void _initializeControllers() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _roleController = TextEditingController();
    _dobController = TextEditingController();
    _imageController = TextEditingController();
    _passwordController = TextEditingController();
  }

  Future<void> _loadWorkerDetails() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await HealthWorkersApi.getHealthWorker(
        int.parse(widget.workerId),
      );
      final workerData = response['data'];

      setState(() {
        _nameController.text = workerData['name'] ?? '';
        _emailController.text = workerData['email'] ?? '';
        _phoneController.text = workerData['telephone'] ?? '';
        _addressController.text = workerData['address'] ?? '';
        _roleController.text = workerData['role'] ?? '';
        _selectedGender = workerData['gender'] ?? 'Male';
        _imageController.text = workerData['image'] ?? '';
        _passwordController.text = '';

        if (workerData['dob'] != null) {
          try {
            final date = DateTime.parse(workerData['dob']);
            _dobController.text = DateFormat('yyyy-MM-dd').format(date);
          } catch (e) {
            _dobController.text = workerData['dob'] ?? '';
          }
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading worker details: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      final updateData = {
        'name': _nameController.text,
        'email': _emailController.text,
        'telephone': _phoneController.text,
        'address': _addressController.text,
        'role': _roleController.text,
        'dob': _dobController.text,
        'gender': _selectedGender,
        'image': _imageController.text,
      };
      if (_passwordController.text.isNotEmpty) {
        updateData['password'] = _passwordController.text;
      }

      await HealthWorkersApi.updateHealthWorker(
        int.parse(widget.workerId),
        updateData,
      );

      CustomSnackBar.showSuccess(context, 'Profile updated successfully');

      if (widget.onProfileUpdated != null) {
        widget.onProfileUpdated!();
      }

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
      CustomSnackBar.showError(context, 'Failed to update profile: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _roleController.dispose();
    _dobController.dispose();
    _imageController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          widget.isDarkMode
              ? AppTheme.nightBackgroundColor
              : AppTheme.sunBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Edit Health Worker Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor:
            widget.isDarkMode ? AppTheme.blue : AppTheme.rustOrange,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.white),
            tooltip: 'Save changes',
            onPressed: _isSaving ? null : _saveChanges,
          ),
        ],
      ),
      body:
          _isLoading
              ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    widget.isDarkMode ? AppTheme.blue : AppTheme.rustOrange,
                  ),
                ),
              )
              : _errorMessage != null &&
                  _errorMessage!.contains('Error loading')
              ? _buildErrorView()
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 4,
                    color:
                        widget.isDarkMode
                            ? AppTheme.navy.withOpacity(0.7)
                            : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Personal Information',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color:
                                    widget.isDarkMode
                                        ? AppTheme.amber
                                        : AppTheme.rustOrange,
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _buildTextField(
                                    controller: _nameController,
                                    label: 'Full Name',
                                    icon: Icons.person,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Name is required';
                                      }
                                      if (value.length > 255) {
                                        return 'Name must be at most 255 characters';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: _buildDropdownField(
                                    label: 'Gender',
                                    icon: Icons.people,
                                    value: _selectedGender,
                                    items:
                                        ['Male', 'Female', 'Other'].map((
                                          gender,
                                        ) {
                                          return DropdownMenuItem<String>(
                                            value: gender,
                                            child: Text(gender),
                                          );
                                        }).toList(),
                                    onChanged: (value) {
                                      if (value != null) {
                                        setState(() {
                                          _selectedGender = value;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _buildTextField(
                                    controller: _dobController,
                                    label: 'Date of Birth',
                                    icon: Icons.calendar_today,
                                    readOnly: true,
                                    onTap: () async {
                                      final DateTime?
                                      picked = await showDatePicker(
                                        context: context,
                                        initialDate:
                                            _dobController.text.isNotEmpty
                                                ? DateTime.tryParse(
                                                      _dobController.text,
                                                    ) ??
                                                    DateTime.now().subtract(
                                                      Duration(days: 365 * 25),
                                                    )
                                                : DateTime.now().subtract(
                                                  Duration(days: 365 * 25),
                                                ),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now(),
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary:
                                                    widget.isDarkMode
                                                        ? AppTheme.blue
                                                        : AppTheme.rustOrange,
                                              ),
                                            ),
                                            child: child!,
                                          );
                                        },
                                      );

                                      if (picked != null) {
                                        setState(() {
                                          _dobController.text = DateFormat(
                                            'yyyy-MM-dd',
                                          ).format(picked);
                                        });
                                      }
                                    },
                                    validator: (value) {
                                      if (value != null && value.isNotEmpty) {
                                        try {
                                          DateTime.parse(value);
                                        } catch (_) {
                                          return 'Invalid date format';
                                        }
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: _buildTextField(
                                    controller: _roleController,
                                    label: 'Role',
                                    icon: Icons.work,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Role is required';
                                      }
                                      if (value.length > 255) {
                                        return 'Role must be at most 255 characters';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _buildTextField(
                                    controller: _phoneController,
                                    label: 'Phone Number',
                                    icon: Icons.phone,
                                    keyboardType: TextInputType.phone,
                                    validator: (value) {
                                      if (value != null && value.length > 255) {
                                        return 'Phone must be at most 255 characters';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: _buildTextField(
                                    controller: _emailController,
                                    label: 'Email Address',
                                    icon: Icons.email,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Email is required';
                                      }
                                      if (!RegExp(
                                        r'^[^@]+@[^@]+\.[^@]+',
                                      ).hasMatch(value)) {
                                        return 'Invalid email';
                                      }
                                      if (value.length > 255) {
                                        return 'Email must be at most 255 characters';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            _buildTextField(
                              controller: _imageController,
                              label: 'Image (URL or Path)',
                              icon: Icons.image,
                              validator: (value) {
                                if (value != null &&
                                    value.isNotEmpty &&
                                    value.length > 255) {
                                  return 'Image path must be at most 255 characters';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            _buildTextField(
                              controller: _addressController,
                              label: 'Address',
                              icon: Icons.location_on,
                              maxLines: 2,
                              validator: (value) {
                                if (value != null &&
                                    value.isNotEmpty &&
                                    value.length > 255) {
                                  return 'Address must be at most 255 characters';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            _buildTextField(
                              controller: _passwordController,
                              label: 'Password (leave blank to keep unchanged)',
                              icon: Icons.lock,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value != null &&
                                    value.isNotEmpty &&
                                    value.length < 8) {
                                  return 'Password must be at least 8 characters';
                                }
                                return null;
                              },
                              // Optionally, obscureText: true,
                            ),
                            SizedBox(height: 24),
                            if (_errorMessage != null &&
                                !_errorMessage!.contains('Error loading')) ...[
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.red.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  _errorMessage!,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                              SizedBox(height: 24),
                            ],
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _isSaving ? null : _saveChanges,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      widget.isDarkMode
                                          ? AppTheme.blue
                                          : AppTheme.rustOrange,
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  disabledBackgroundColor: (widget.isDarkMode
                                          ? AppTheme.blue
                                          : AppTheme.rustOrange)
                                      .withOpacity(0.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child:
                                    _isSaving
                                        ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                      Color
                                                    >(Colors.white),
                                              ),
                                            ),
                                            SizedBox(width: 12),
                                            Text(
                                              'Saving...',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        )
                                        : Text(
                                          'Save Changes',
                                          style: TextStyle(color: Colors.white),
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

  Widget _buildErrorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 60, color: AppTheme.rustOrange),
          SizedBox(height: 16),
          Text(
            'Error Loading Data',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: widget.isDarkMode ? Colors.white : AppTheme.navy,
            ),
          ),
          SizedBox(height: 8),
          Text(
            _errorMessage ?? 'Unknown error occurred',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: widget.isDarkMode ? Colors.white70 : Colors.black87,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _loadWorkerDetails,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  widget.isDarkMode ? AppTheme.blue : AppTheme.rustOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Retry', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    VoidCallback? onTap,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      style: TextStyle(
        color: widget.isDarkMode ? Colors.white : Colors.black87,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: (widget.isDarkMode ? Colors.white : Colors.black87)
              .withOpacity(0.7),
        ),
        prefixIcon: Icon(
          icon,
          color: widget.isDarkMode ? AppTheme.blue : AppTheme.rustOrange,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: (widget.isDarkMode ? AppTheme.blue : AppTheme.rustOrange)
                .withOpacity(0.5),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: (widget.isDarkMode ? AppTheme.blue : AppTheme.rustOrange)
                .withOpacity(0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: widget.isDarkMode ? AppTheme.blue : AppTheme.rustOrange,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red),
        ),
        filled: true,
        fillColor:
            widget.isDarkMode
                ? AppTheme.navy.withOpacity(0.5)
                : Colors.grey.withOpacity(0.1),
      ),
      keyboardType: keyboardType,
      readOnly: readOnly,
      onTap: onTap,
      maxLines: maxLines,
      validator: validator,
    );
  }

  Widget _buildDropdownField({
    required String label,
    required IconData icon,
    required String value,
    required List<DropdownMenuItem<String>> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color:
            widget.isDarkMode
                ? AppTheme.navy.withOpacity(0.5)
                : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: (widget.isDarkMode ? AppTheme.blue : AppTheme.rustOrange)
              .withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: widget.isDarkMode ? AppTheme.blue : AppTheme.rustOrange,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: (widget.isDarkMode ? Colors.white : Colors.black87)
                        .withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: value,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color:
                          widget.isDarkMode
                              ? AppTheme.blue
                              : AppTheme.rustOrange,
                    ),
                    isExpanded: true,
                    dropdownColor:
                        widget.isDarkMode ? AppTheme.navy : Colors.white,
                    style: TextStyle(
                      color: widget.isDarkMode ? Colors.white : Colors.black87,
                    ),
                    items: items,
                    onChanged: onChanged,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
