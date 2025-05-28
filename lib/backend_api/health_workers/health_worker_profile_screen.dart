import 'package:flutter/material.dart';
import 'package:wellnessbridge/backend_api/health_workers/health_workers_api.dart';
import 'package:wellnessbridge/theme/theme.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> worker;
  final bool isDarkMode;
  final bool isNewWorker;
  final VoidCallback onProfileUpdated;

  const EditProfileScreen({
    Key? key,
    required this.worker,
    required this.isDarkMode,
    this.isNewWorker = false,
    required this.onProfileUpdated,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _telephoneController;
  late TextEditingController _roleController;
  late TextEditingController _addressController;
  late TextEditingController _passwordController;
  late TextEditingController _dobController;
  String _selectedGender = 'Male';
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.worker['name'] ?? '');
    _emailController = TextEditingController(
      text: widget.worker['email'] ?? '',
    );
    _telephoneController = TextEditingController(
      text: widget.worker['telephone'] ?? '',
    );
    _roleController = TextEditingController(text: widget.worker['role'] ?? '');
    _addressController = TextEditingController(
      text: widget.worker['address'] ?? '',
    );
    _passwordController = TextEditingController();
    _dobController = TextEditingController(text: widget.worker['dob'] ?? '');
    _selectedGender = widget.worker['gender'] ?? 'Male';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _telephoneController.dispose();
    _roleController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _saveWorker() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final workerData = {
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'telephone': _telephoneController.text.trim(),
        'role': _roleController.text.trim(),
        'gender': _selectedGender,
        'dob': _dobController.text.trim(),
        'address': _addressController.text.trim(),
      };

      // Only include password for new workers
      if (widget.isNewWorker) {
        workerData['password'] = _passwordController.text;
      }

      Map<String, dynamic> result;

      if (widget.isNewWorker) {
        result = await HealthWorkersApi.createHealthWorker(workerData);
        _showSuccessMessage('Health worker created successfully!');
      } else {
        final workerId = widget.worker['id'] as int;
        result = await HealthWorkersApi.updateProfile(workerId, workerData);
        _showSuccessMessage('Health worker updated successfully!');
      }

      widget.onProfileUpdated();
      Navigator.pop(context, result);
    } catch (e) {
      _showErrorMessage('Error: ${e.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isNewWorker ? 'Add Health Worker' : 'Edit Profile'),
        backgroundColor:
            widget.isDarkMode ? AppTheme.navy : AppTheme.rustOrange,
        iconTheme: IconThemeData(
          color: widget.isDarkMode ? Colors.white : AppTheme.navy,
        ),
        actions: [
          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
      backgroundColor:
          widget.isDarkMode ? AppTheme.navy : AppTheme.sunBackgroundColor,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: _nameController,
                        label: 'Full Name',
                        icon: Icons.person,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildGenderDropdown(),
                      const SizedBox(height: 16),
                      _buildDateOfBirthField(),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _emailController,
                        label: 'Email',
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email is required';
                          }
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _telephoneController,
                        label: 'Phone Number',
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Phone number is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _roleController,
                        label: 'Role',
                        icon: Icons.work,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Role is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _addressController,
                        label: 'Address',
                        icon: Icons.location_on,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Address is required';
                          }
                          return null;
                        },
                      ),
                      if (widget.isNewWorker) ...[
                        const SizedBox(height: 16),
                        _buildPasswordField(),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed:
                          _isLoading ? null : () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(
                          color:
                              widget.isDarkMode
                                  ? AppTheme.amber
                                  : AppTheme.rustOrange,
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color:
                              widget.isDarkMode
                                  ? AppTheme.amber
                                  : AppTheme.rustOrange,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _saveWorker,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            widget.isDarkMode
                                ? AppTheme.blue
                                : AppTheme.rustOrange,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        widget.isNewWorker ? 'Create Worker' : 'Update Profile',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      decoration: InputDecoration(
        labelText: 'Gender',
        prefixIcon: Icon(
          Icons.person_outline,
          color: widget.isDarkMode ? AppTheme.amber : AppTheme.rustOrange,
        ),
        labelStyle: TextStyle(
          color: widget.isDarkMode ? AppTheme.amber : AppTheme.rustOrange,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:
                widget.isDarkMode
                    ? AppTheme.amber.withOpacity(0.5)
                    : AppTheme.rustOrange.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isDarkMode ? AppTheme.amber : AppTheme.rustOrange,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor:
            widget.isDarkMode
                ? AppTheme.navy.withOpacity(0.3)
                : Colors.white.withOpacity(0.8),
      ),
      items:
          ['Male', 'Female', 'Other']
              .map(
                (gender) =>
                    DropdownMenuItem(value: gender, child: Text(gender)),
              )
              .toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _selectedGender = value;
          });
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a gender';
        }
        return null;
      },
    );
  }

  Widget _buildDateOfBirthField() {
    return TextFormField(
      controller: _dobController,
      readOnly: true,
      onTap: _selectDate,
      decoration: InputDecoration(
        labelText: 'Date of Birth',
        prefixIcon: Icon(
          Icons.calendar_today,
          color: widget.isDarkMode ? AppTheme.amber : AppTheme.rustOrange,
        ),
        labelStyle: TextStyle(
          color: widget.isDarkMode ? AppTheme.amber : AppTheme.rustOrange,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:
                widget.isDarkMode
                    ? AppTheme.amber.withOpacity(0.5)
                    : AppTheme.rustOrange.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isDarkMode ? AppTheme.amber : AppTheme.rustOrange,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor:
            widget.isDarkMode
                ? AppTheme.navy.withOpacity(0.3)
                : Colors.white.withOpacity(0.8),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Date of birth is required';
        }
        // Basic date format validation (YYYY-MM-DD)
        if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)) {
          return 'Please enter a valid date (YYYY-MM-DD)';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: Icon(
          Icons.lock,
          color: widget.isDarkMode ? AppTheme.amber : AppTheme.rustOrange,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: widget.isDarkMode ? AppTheme.amber : AppTheme.rustOrange,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        labelStyle: TextStyle(
          color: widget.isDarkMode ? AppTheme.amber : AppTheme.rustOrange,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:
                widget.isDarkMode
                    ? AppTheme.amber.withOpacity(0.5)
                    : AppTheme.rustOrange.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isDarkMode ? AppTheme.amber : AppTheme.rustOrange,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor:
            widget.isDarkMode
                ? AppTheme.navy.withOpacity(0.3)
                : Colors.white.withOpacity(0.8),
      ),
      validator: (value) {
        if (widget.isNewWorker && (value == null || value.isEmpty)) {
          return 'Password is required';
        }
        if (value != null && value.isNotEmpty && value.length < 8) {
          return 'Password must be at least 8 characters';
        }
        return null;
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(
        color: widget.isDarkMode ? Colors.white : Colors.black87,
      ),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: widget.isDarkMode ? AppTheme.amber : AppTheme.rustOrange,
        ),
        labelStyle: TextStyle(
          color: widget.isDarkMode ? AppTheme.amber : AppTheme.rustOrange,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:
                widget.isDarkMode
                    ? AppTheme.amber.withOpacity(0.5)
                    : AppTheme.rustOrange.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isDarkMode ? AppTheme.amber : AppTheme.rustOrange,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor:
            widget.isDarkMode
                ? AppTheme.navy.withOpacity(0.3)
                : Colors.white.withOpacity(0.8),
      ),
    );
  }
}
