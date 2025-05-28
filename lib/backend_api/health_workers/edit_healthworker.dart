import 'package:flutter/material.dart';
import 'package:wellnessbridge/theme/snack_bar.dart';
import 'package:wellnessbridge/theme/theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:wellnessbridge/backend_api/health_workers/health_workers_api.dart';

class EditHealthWorkerScreen extends StatefulWidget {
  final Map<String, dynamic> worker;
  final bool isDarkMode;
  final Function? onSuccess; // Optional callback for when edit is successful

  const EditHealthWorkerScreen({
    super.key,
    required this.worker,
    required this.isDarkMode,
    this.onSuccess,
  });

  @override
  _EditHealthWorkerScreenState createState() => _EditHealthWorkerScreenState();
}

class _EditHealthWorkerScreenState extends State<EditHealthWorkerScreen> {
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
  String _selectedGender = 'Male'; // Default

  // Original values for checking if changes were made
  late Map<String, dynamic> _originalValues;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadWorkerDetails();
  }

  void _initializeControllers() {
    // Initialize with current values from the worker object
    _nameController = TextEditingController(text: widget.worker['name'] ?? '');
    _emailController = TextEditingController(
      text: widget.worker['email'] ?? '',
    );
    _phoneController = TextEditingController(
      text: widget.worker['telephone'] ?? '',
    );
    _addressController = TextEditingController(
      text: widget.worker['address'] ?? '',
    );
    _roleController = TextEditingController(text: widget.worker['role'] ?? '');

    // Format date if available
    String formattedDate = '';
    if (widget.worker['dob'] != null) {
      try {
        final date = DateTime.parse(widget.worker['dob']);
        formattedDate = DateFormat('yyyy-MM-dd').format(date);
      } catch (e) {
        formattedDate = widget.worker['dob'] ?? '';
      }
    }
    _dobController = TextEditingController(text: formattedDate);

    // Set gender
    _selectedGender = widget.worker['gender'] ?? 'Male';

    // Store original values for comparison
    _originalValues = {
      'name': _nameController.text,
      'email': _emailController.text,
      'telephone': _phoneController.text,
      'address': _addressController.text,
      'role': _roleController.text,
      'dob': _dobController.text,
      'gender': _selectedGender,
    };
  }

  // Load full worker details from API
  Future<void> _loadWorkerDetails() async {
    if (widget.worker['hwID'] == null) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http
          .get(
            Uri.parse(
              'http://127.0.0.1:8000/api/v1/healthworkers/${widget.worker['hwID']}',
            ),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final workerData = data['data'];

        // Update controllers with full data
        setState(() {
          _nameController.text = workerData['name'] ?? _nameController.text;
          _emailController.text = workerData['email'] ?? _emailController.text;
          _phoneController.text =
              workerData['telephone'] ?? _phoneController.text;
          _addressController.text =
              workerData['address'] ?? _addressController.text;
          _roleController.text = workerData['role'] ?? _roleController.text;

          // Format date if available
          if (workerData['dob'] != null) {
            try {
              final date = DateTime.parse(workerData['dob']);
              _dobController.text = DateFormat('yyyy-MM-dd').format(date);
            } catch (e) {
              _dobController.text = workerData['dob'] ?? _dobController.text;
            }
          }

          _selectedGender = workerData['gender'] ?? _selectedGender;

          // Update original values
          _originalValues = {
            'name': _nameController.text,
            'email': _emailController.text,
            'telephone': _phoneController.text,
            'address': _addressController.text,
            'role': _roleController.text,
            'dob': _dobController.text,
            'gender': _selectedGender,
          };
        });
      } else {
        throw Exception(
          'Failed to load worker details: ${response.statusCode}',
        );
      }
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

  // Check if form has changes
  bool _hasChanges() {
    return _nameController.text != _originalValues['name'] ||
        _emailController.text != _originalValues['email'] ||
        _phoneController.text != _originalValues['telephone'] ||
        _addressController.text != _originalValues['address'] ||
        _roleController.text != _originalValues['role'] ||
        _dobController.text != _originalValues['dob'] ||
        _selectedGender != _originalValues['gender'];
  }

  // Save changes
  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    // If no changes were made, show message and return
    if (!_hasChanges()) {
      CustomSnackBar.showError(context, 'No changes were made');
      return;
    }

    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      // Prepare data for API
      final Map<String, dynamic> updateData = {
        'name': _nameController.text,
        'email': _emailController.text,
        'telephone': _phoneController.text,
        'address': _addressController.text,
        'role': _roleController.text,
        'dob': _dobController.text,
        'gender': _selectedGender,
      };

      // Call the API to update the health worker
      final response = await HealthWorkersApi.updateHealthWorker(
        widget.worker['hwID'],
        updateData,
      );

      // Show success message
      CustomSnackBar.showSuccess(context, 'Health worker updated successfully');

      // Call success callback if provided
      if (widget.onSuccess != null) {
        widget.onSuccess!();
      }

      // Navigate back
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
      CustomSnackBar.showError(context, 'Failed to update health worker: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  // Show confirmation dialog before discarding changes
  Future<bool> _onWillPop() async {
    if (!_hasChanges()) return true;

    final result = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Discard changes?'),
            content: Text(
              'You have unsaved changes. Are you sure you want to discard them?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: Text('Discard'),
              ),
            ],
          ),
    );

    return result ?? false;
  }

  @override
  void dispose() {
    // Dispose controllers
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _roleController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.isDarkMode ? AppTheme.navy : Colors.white;
    final textColor = widget.isDarkMode ? Colors.white : Colors.black87;
    final accentColor =
        widget.isDarkMode ? AppTheme.amber : AppTheme.rustOrange;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Health Worker'),
          backgroundColor:
              widget.isDarkMode ? AppTheme.navy : AppTheme.rustOrange,
          actions: [
            // Save button
            IconButton(
              icon: Icon(Icons.save),
              tooltip: 'Save changes',
              onPressed: _isSaving ? null : _saveChanges,
            ),
          ],
        ),
        body: Container(
          color: backgroundColor,
          alignment: Alignment.topCenter, // Center content horizontally
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 600, // Set the maximum width of the form container
            ),
            child:
                _isLoading
                    ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                      ),
                    )
                    : _errorMessage != null &&
                        _errorMessage!.contains('Error loading')
                    ? _buildErrorView(accentColor, textColor)
                    : _buildForm(accentColor, textColor, backgroundColor),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorView(Color accentColor, Color textColor) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 60, color: accentColor),
            SizedBox(height: 16),
            Text(
              'Error Loading Data',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              _errorMessage ?? 'Unknown error occurred',
              textAlign: TextAlign.center,
              style: TextStyle(color: textColor.withOpacity(0.7)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loadWorkerDetails,
              style: ElevatedButton.styleFrom(backgroundColor: accentColor),
              child: Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(Color accentColor, Color textColor, Color backgroundColor) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Worker ID display
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color:
                  widget.isDarkMode
                      ? Colors.blue.withOpacity(0.1)
                      : Colors.blue.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.withOpacity(0.3), width: 1),
            ),
            child: Row(
              children: [
                Icon(Icons.badge, color: Colors.blue),
                SizedBox(width: 12),
                Text(
                  'Worker ID: ${widget.worker['hwID']}',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // Name field
          _buildTextField(
            controller: _nameController,
            label: 'Full Name',
            icon: Icons.person,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Name is required';
              }
              return null;
            },
          ),
          SizedBox(height: 16),

          // Gender selection
          _buildDropdownField(
            label: 'Gender',
            icon: Icons.people,
            value: _selectedGender,
            items:
                ['Male', 'Female', 'Other'].map((gender) {
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
          SizedBox(height: 16),

          // Date of Birth field
          _buildTextField(
            controller: _dobController,
            label: 'Date of Birth',
            icon: Icons.calendar_today,
            readOnly: true,
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate:
                    _dobController.text.isNotEmpty
                        ? DateTime.parse(_dobController.text)
                        : DateTime.now().subtract(Duration(days: 365 * 25)),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(primary: accentColor),
                    ),
                    child: child!,
                  );
                },
              );

              if (picked != null) {
                setState(() {
                  _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
                });
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Date of birth is required';
              }
              return null;
            },
          ),
          SizedBox(height: 16),

          // Role field
          _buildTextField(
            controller: _roleController,
            label: 'Role',
            icon: Icons.work,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Role is required';
              }
              return null;
            },
          ),
          SizedBox(height: 16),

          // Phone field
          _buildTextField(
            controller: _phoneController,
            label: 'Phone Number',
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Phone number is required';
              }
              return null;
            },
          ),
          SizedBox(height: 16),

          // Email field
          _buildTextField(
            controller: _emailController,
            label: 'Email Address',
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              }
              if (!RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              ).hasMatch(value)) {
                return 'Enter a valid email address';
              }
              return null;
            },
          ),
          SizedBox(height: 16),

          // Address field
          _buildTextField(
            controller: _addressController,
            label: 'Address',
            icon: Icons.location_on,
            maxLines: 3,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Address is required';
              }
              return null;
            },
          ),
          SizedBox(height: 24),

          // Error message
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
              child: Text(_errorMessage!, style: TextStyle(color: Colors.red)),
            ),
            SizedBox(height: 24),
          ],

          // Save button
          ElevatedButton(
            onPressed: _isSaving ? null : _saveChanges,
            style: ElevatedButton.styleFrom(
              backgroundColor: accentColor,
              padding: EdgeInsets.symmetric(vertical: 12),
              disabledBackgroundColor: accentColor.withOpacity(0.5),
            ),
            child:
                _isSaving
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Text('Saving...'),
                      ],
                    )
                    : Text('Save Changes'),
          ),
          SizedBox(height: 16),

          // Cancel button
          OutlinedButton(
            onPressed: () {
              if (_hasChanges()) {
                _onWillPop().then((discard) {
                  if (discard) Navigator.pop(context);
                });
              } else {
                Navigator.pop(context);
              }
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: textColor,
              side: BorderSide(color: textColor.withOpacity(0.5)),
              padding: EdgeInsets.symmetric(vertical: 12),
            ),
            child: Text('Cancel'),
          ),
          SizedBox(height: 40),
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
    final textColor = widget.isDarkMode ? Colors.white : Colors.black87;
    final accentColor =
        widget.isDarkMode ? AppTheme.amber : AppTheme.rustOrange;

    return TextFormField(
      controller: controller,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: textColor.withOpacity(0.7)),
        prefixIcon: Icon(icon, color: accentColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: accentColor.withOpacity(0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: accentColor.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: accentColor),
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
    final textColor = widget.isDarkMode ? Colors.white : Colors.black87;
    final accentColor =
        widget.isDarkMode ? AppTheme.amber : AppTheme.rustOrange;
    final backgroundColor =
        widget.isDarkMode
            ? AppTheme.navy.withOpacity(0.5)
            : Colors.grey.withOpacity(0.1);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accentColor.withOpacity(0.5), width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: accentColor),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: textColor.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: value,
                    icon: Icon(Icons.arrow_drop_down, color: accentColor),
                    isExpanded: true,
                    dropdownColor:
                        widget.isDarkMode ? AppTheme.navy : Colors.white,
                    style: TextStyle(color: textColor),
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
