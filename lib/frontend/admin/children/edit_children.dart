import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Required for date formatting
import 'package:wellnessbridge/theme/theme.dart';
import 'package:wellnessbridge/theme/snack_bar.dart';
import 'package:wellnessbridge/backend_api/children/edit_children_api.dart';

class EditChildren extends StatefulWidget {
  final Map<String, dynamic> childData;

  const EditChildren({Key? key, required this.childData}) : super(key: key);

  @override
  State<EditChildren> createState() => _EditChildrenState();
}

class _EditChildrenState extends State<EditChildren> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isDarkMode = false;

  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  String? _selectedGender; // Changed to String? for DropdownButton
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _parentNameController = TextEditingController();
  final TextEditingController _parentContactController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  // List of genders for the dropdown
  final List<String> _genders = ['Male', 'Female', 'Other'];

  @override
  void initState() {
    super.initState();
    _initializeFormData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isDarkMode = Theme.of(context).brightness == Brightness.dark;
  }

  void _initializeFormData() {
    _nameController.text = widget.childData['name'] ?? '';
    // Set selected gender if it matches one of the options
    if (_genders.contains(widget.childData['gender'])) {
      _selectedGender = widget.childData['gender'];
    } else {
      _selectedGender = null; // Or a default like _genders.first
    }
    _dobController.text = widget.childData['dob'] ?? '';
    _parentNameController.text = widget.childData['parentName'] ?? '';
    _parentContactController.text = widget.childData['parentContact'] ?? '';
    _addressController.text = widget.childData['address'] ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _parentNameController.dispose();
    _parentContactController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  // Function to show date picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(_dobController.text) ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary:
                  AppTheme.rustOrange, // Color for header and selected date
              onPrimary: Colors.white, // Text color on primary
              surface:
                  _isDarkMode
                      ? AppTheme.navy
                      : Colors.white, // Background of the date picker itself
              onSurface:
                  _isDarkMode
                      ? Colors.white
                      : AppTheme.navy, // Text color on surface
            ),
            dialogBackgroundColor:
                _isDarkMode
                    ? AppTheme.navy
                    : Colors.white, // Background of the dialog
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.rustOrange,
              ), // Color for "CANCEL" and "OK" buttons
            ),
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
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final Map<String, dynamic> childDataToSubmit = {
        'name': _nameController.text.trim(),
        'gender': _selectedGender ?? '',
        'dob': _dobController.text.trim(),
        'parentName': _parentNameController.text.trim(),
        'parentContact': _parentContactController.text.trim(),
        'address': _addressController.text.trim(),
      };

      // Check if childID exists to determine create or update
      // Convert to string only if it's not null, otherwise keep it null.
      final String? existingChildId = widget.childData['childID']?.toString();

      if (existingChildId == null || existingChildId.isEmpty) {
        // ID is null or empty, so create a new child
        print('Submitting form to create new child...');
        await EditChildrenApi.createChild(childDataToSubmit);
        if (mounted) {
          CustomSnackBar.showSuccess(context, 'Child added successfully');
        }
      } else {
        // ID exists, so update the existing child
        print('Submitting form to update child with ID: $existingChildId...');
        await EditChildrenApi.updateChild(existingChildId, childDataToSubmit);
        if (mounted) {
          CustomSnackBar.showSuccess(
            context,
            'Child details updated successfully',
          );
        }
      }

      if (mounted) {
        // Pop with true to indicate a successful operation (create or update)
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.showError(context, e.toString());
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      child: Scaffold(
        backgroundColor:
            _isDarkMode
                ? AppTheme.nightBackgroundColor
                : AppTheme.sunBackgroundColor,
        appBar: AppBar(
          title: Text(
            widget.childData.isEmpty ? 'Add New Child' : 'Edit Child Details',
            style: TextStyle(
              color: Colors.white,
              fontSize: AppTheme.titleFontSize,
            ),
          ),
          backgroundColor: _isDarkMode ? AppTheme.blue : AppTheme.rustOrange,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: Icon(
                _isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              },
              tooltip:
                  _isDarkMode ? 'Switch to light mode' : 'Switch to dark mode',
            ),
          ],
        ),
        body:
            _isLoading
                ? Center(
                  child: CircularProgressIndicator(color: AppTheme.rustOrange),
                )
                : Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: SizedBox(
                      width: 600,
                      child: Card(
                        elevation: 8, // Increased elevation for a bolder look
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            16,
                          ), // More rounded corners
                        ),
                        color: _isDarkMode ? AppTheme.navy : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(
                            32.0,
                          ), // Increased padding
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSectionTitle('Basic Information'),
                                const SizedBox(height: 16),
                                _buildTextFormField(
                                  controller: _nameController,
                                  labelText: 'Child Name',
                                  validatorText: 'Please enter child name',
                                  icon: Icons.person,
                                ),
                                const SizedBox(height: 20), // Adjusted spacing
                                // Gender Dropdown
                                DropdownButtonFormField<String>(
                                  value: _selectedGender,
                                  decoration: _buildInputDecoration(
                                    labelText: 'Gender',
                                    icon: Icons.people_alt,
                                  ),
                                  style: TextStyle(
                                    color:
                                        _isDarkMode
                                            ? Colors.white70
                                            : AppTheme.blue,
                                    fontSize: AppTheme.bodyFontSize,
                                  ),
                                  dropdownColor:
                                      _isDarkMode
                                          ? AppTheme.navy
                                          : Colors.white,
                                  items:
                                      _genders.map((String gender) {
                                        return DropdownMenuItem<String>(
                                          value: gender,
                                          child: Text(
                                            gender,
                                            style: TextStyle(
                                              color:
                                                  _isDarkMode
                                                      ? Colors.white
                                                      : AppTheme.blue,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedGender = newValue;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a gender';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),

                                // Date of Birth - Calendar Picker
                                TextFormField(
                                  controller: _dobController,
                                  decoration: _buildInputDecoration(
                                    labelText: 'Date of Birth (YYYY-MM-DD)',
                                    icon: Icons.calendar_today,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.calendar_month,
                                        color:
                                            _isDarkMode
                                                ? AppTheme.amber
                                                : AppTheme.blue,
                                      ),
                                      onPressed: () => _selectDate(context),
                                    ),
                                  ),
                                  readOnly: true, // Prevent manual text input
                                  onTap:
                                      () => _selectDate(
                                        context,
                                      ), // Open picker on tap
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter date of birth';
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                    color:
                                        _isDarkMode
                                            ? Colors.white70
                                            : AppTheme.blue,
                                    fontSize: AppTheme.bodyFontSize,
                                  ),
                                ),
                                const SizedBox(height: 32),

                                _buildSectionTitle('Parent Information'),
                                const SizedBox(height: 16),
                                _buildTextFormField(
                                  controller: _parentNameController,
                                  labelText: 'Parent Name',
                                  validatorText: 'Please enter parent name',
                                  icon: Icons.person_outline,
                                ),
                                const SizedBox(height: 20),
                                _buildTextFormField(
                                  controller: _parentContactController,
                                  labelText: 'Parent Contact',
                                  validatorText: 'Please enter parent contact',
                                  icon: Icons.phone,
                                  keyboardType: TextInputType.phone,
                                ),
                                const SizedBox(height: 32),

                                _buildSectionTitle('Additional Information'),
                                const SizedBox(height: 16),
                                _buildTextFormField(
                                  controller: _addressController,
                                  labelText: 'Address',
                                  maxLines: 3,
                                  validatorText: 'Please enter address',
                                  icon: Icons.location_on,
                                ),
                                const SizedBox(
                                  height: 40,
                                ), // More space before buttons

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(Icons.cancel),
                                        label: const Text('Cancel'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.grey,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 14,
                                          ), // Larger padding
                                          textStyle: const TextStyle(
                                            fontSize: 18,
                                          ), // Larger text
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ), // More rounded
                                          ),
                                          minimumSize: Size(
                                            double.infinity,
                                            50,
                                          ), // Ensure buttons are a decent size
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ), // Space between buttons
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: _submitForm,
                                        icon: const Icon(Icons.save),
                                        label: const Text('Save Changes'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppTheme.rustOrange,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 14,
                                          ),
                                          textStyle: const TextStyle(
                                            fontSize: 18,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          minimumSize: Size(
                                            double.infinity,
                                            50,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
      ),
    );
  }

  // --- Helper Widgets for Enhanced Visualization ---

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: AppTheme.subtitleFontSize * 1.1, // Slightly larger
        fontWeight: FontWeight.bold,
        color: _isDarkMode ? AppTheme.amber : AppTheme.navy,
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String labelText,
    IconData? icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      prefixIcon:
          icon != null
              ? Icon(icon, color: _isDarkMode ? AppTheme.amber : AppTheme.blue)
              : null,
      suffixIcon: suffixIcon,
      labelStyle: TextStyle(
        color: _isDarkMode ? Colors.white70 : AppTheme.blue,
      ),
      filled: true,
      fillColor:
          _isDarkMode
              ? AppTheme.darkInputFillColor
              : AppTheme.lightInputFillColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), // More rounded borders
        borderSide: BorderSide.none, // No border line if filled
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color:
              _isDarkMode
                  ? AppTheme.amber.withOpacity(0.5)
                  : AppTheme.blue.withOpacity(0.5),
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: _isDarkMode ? AppTheme.amber : AppTheme.blue,
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required String validatorText,
    IconData? icon,
    int? maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: _buildInputDecoration(labelText: labelText, icon: icon),
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: TextStyle(
        color: _isDarkMode ? Colors.white : AppTheme.navy,
        fontSize: AppTheme.bodyFontSize,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorText;
        }
        return null;
      },
    );
  }
}

// You'll need to define these colors in your AppTheme class:
// In theme.dart:
// class AppTheme {
//   static const Color lightInputFillColor = Color(0xFFF0F4F8); // Light gray/blue for light mode inputs
//   static const Color darkInputFillColor = Color(0xFF2C3E50); // Darker blue/gray for dark mode inputs
//
//   // ... other theme properties
//
