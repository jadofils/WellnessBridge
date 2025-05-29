import 'package:flutter/material.dart';
import 'package:wellnessbridge/theme/theme.dart';
import 'package:wellnessbridge/theme/snack_bar.dart';
import 'package:wellnessbridge/backend_api/birth_property/edit_birth_property_api.dart';

class EditBirthProperty extends StatefulWidget {
  final int birthPropertyId;
  final int? childId; // Optional child ID for by-child updates

  const EditBirthProperty({
    super.key,
    required this.birthPropertyId,
    this.childId,
  });

  @override
  State<EditBirthProperty> createState() => _EditBirthPropertyState();
}

class _EditBirthPropertyState extends State<EditBirthProperty> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isDarkMode = false;
  bool _isByChild = false;

  // Form controllers
  final _motherAgeController = TextEditingController();
  final _fatherAgeController = TextEditingController();
  final _numberOfChildrenController = TextEditingController();
  final _birthTypeController = TextEditingController();
  final _birthWeightController = TextEditingController();
  final _childConditionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize _isByChild based on whether childId is provided
    _isByChild = widget.childId != null;
    _loadPropertyData();
  }

  @override
  void dispose() {
    _motherAgeController.dispose();
    _fatherAgeController.dispose();
    _numberOfChildrenController.dispose();
    _birthTypeController.dispose();
    _birthWeightController.dispose();
    _childConditionController.dispose();
    super.dispose();
  }

  Future<void> _loadPropertyData() async {
    setState(() => _isLoading = true);

    try {
      // TODO: Implement loading existing data using the same API pattern
      // You can create a getBirthProperty method in EditBirthPropertyApi
      // that follows the same pattern as editBirthProperty

      // final idToUse = _isByChild && widget.childId != null
      //     ? widget.childId!
      //     : widget.birthPropertyId;

      // final response = await EditBirthPropertyApi.getBirthProperty(
      //   id: idToUse,
      //   isByChild: _isByChild,
      // );

      // if (response['success']) {
      //   final propertyData = response['data'];
      //   _motherAgeController.text = propertyData['motherAge'].toString();
      //   _fatherAgeController.text = propertyData['fatherAge'].toString();
      //   _numberOfChildrenController.text = propertyData['numberOfChildren'].toString();
      //   _birthTypeController.text = propertyData['birthType'] ?? '';
      //   _birthWeightController.text = propertyData['birthWeight'].toString();
      //   _childConditionController.text = propertyData['childCondition'] ?? '';
      // }

      // For now, just simulate loading
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      if (mounted) {
        CustomSnackBar.showError(
          context,
          'Failed to load birth property data: $e',
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    // TODO: Implement actual theme persistence
  }

  @override
  Widget build(BuildContext context) {
    _isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          _isDarkMode
              ? AppTheme.nightBackgroundColor
              : AppTheme.sunBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Edit Birth Property',
          style: TextStyle(
            color: Colors.white,
            fontSize: AppTheme.titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: _isDarkMode ? AppTheme.navy : AppTheme.rustOrange,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white,
            ),
            onPressed: _toggleTheme,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body:
          _isLoading
              ? Center(
                child: CircularProgressIndicator(
                  color: _isDarkMode ? AppTheme.amber : AppTheme.rustOrange,
                ),
              )
              : Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  constraints: const BoxConstraints(maxWidth: 650),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle('Update Method'),
                          const SizedBox(height: 16),
                          _buildUpdateMethodButtons(),
                          const SizedBox(height: 32),
                          _buildSectionTitle('Parent Information'),
                          _buildTextField(
                            controller: _motherAgeController,
                            label: 'Mother Age',
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter mother\'s age';
                              }
                              final age = int.tryParse(value);
                              if (age == null || age < 10 || age > 100) {
                                return 'Please enter a valid age (10-100)';
                              }
                              return null;
                            },
                          ),
                          _buildTextField(
                            controller: _fatherAgeController,
                            label: 'Father Age',
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter father\'s age';
                              }
                              final age = int.tryParse(value);
                              if (age == null || age < 10 || age > 100) {
                                return 'Please enter a valid age (10-100)';
                              }
                              return null;
                            },
                          ),
                          _buildTextField(
                            controller: _numberOfChildrenController,
                            label: 'Number of Children',
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter number of children';
                              }
                              final children = int.tryParse(value);
                              if (children == null || children < 0) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          _buildSectionTitle('Birth Information'),
                          _buildTextField(
                            controller: _birthTypeController,
                            label: 'Birth Type',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter birth type';
                              }
                              return null;
                            },
                          ),
                          _buildTextField(
                            controller: _birthWeightController,
                            label: 'Birth Weight (kg)',
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter birth weight';
                              }
                              final weight = double.tryParse(value);
                              if (weight == null ||
                                  weight < 0.5 ||
                                  weight > 10) {
                                return 'Please enter a valid weight (0.5-10 kg)';
                              }
                              return null;
                            },
                          ),
                          _buildTextField(
                            controller: _childConditionController,
                            label: 'Child Condition',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter child condition';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 32),
                          Center(
                            child: ElevatedButton.icon(
                              onPressed: _isLoading ? null : _submitForm,
                              icon:
                                  _isLoading
                                      ? SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                      : const Icon(
                                        Icons.save,
                                        color: Colors.white,
                                      ),
                              label: Text(
                                _isLoading ? 'Saving...' : 'Save Changes',
                                style: TextStyle(
                                  fontSize: AppTheme.buttonFontSize,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    _isDarkMode
                                        ? AppTheme.blue
                                        : AppTheme.rustOrange,
                                disabledBackgroundColor: Colors.grey,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
    );
  }

  Widget _buildUpdateMethodButtons() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // For mobile screens, stack buttons vertically
        if (constraints.maxWidth < 500) {
          return Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: _buildMethodButton(
                  isSelected: !_isByChild,
                  onPressed: () => setState(() => _isByChild = false),
                  icon: Icons.edit,
                  label: 'Update by Birth Property',
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: _buildMethodButton(
                  isSelected: _isByChild,
                  onPressed:
                      widget.childId != null
                          ? () => setState(() => _isByChild = true)
                          : null, // Disable if no childId provided
                  icon: Icons.child_care,
                  label: 'Update by Child',
                ),
              ),
            ],
          );
        }

        // For larger screens, keep horizontal layout
        return Row(
          children: [
            Expanded(
              child: _buildMethodButton(
                isSelected: !_isByChild,
                onPressed: () => setState(() => _isByChild = false),
                icon: Icons.edit,
                label: 'Update by Birth Property',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildMethodButton(
                isSelected: _isByChild,
                onPressed:
                    widget.childId != null
                        ? () => setState(() => _isByChild = true)
                        : null, // Disable if no childId provided
                icon: Icons.child_care,
                label: 'Update by Child',
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMethodButton({
    required bool isSelected,
    required VoidCallback? onPressed,
    required IconData icon,
    required String label,
  }) {
    final isDisabled = onPressed == null;

    return ElevatedButton.icon(
      onPressed: isDisabled ? null : onPressed,
      icon: Icon(
        icon,
        color:
            isDisabled
                ? Colors.grey.shade400
                : isSelected
                ? Colors.white
                : (_isDarkMode ? AppTheme.amber : AppTheme.blue),
      ),
      label: Text(
        label,
        style: TextStyle(
          color:
              isDisabled
                  ? Colors.grey.shade400
                  : isSelected
                  ? Colors.white
                  : (_isDarkMode ? AppTheme.amber : AppTheme.blue),
          fontSize: AppTheme.buttonFontSize,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isDisabled
                ? Colors.grey.shade200
                : isSelected
                ? (_isDarkMode ? AppTheme.blue : AppTheme.rustOrange)
                : (_isDarkMode ? AppTheme.navy : Colors.white),
        disabledBackgroundColor: Colors.grey.shade200,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color:
                isDisabled
                    ? Colors.grey.shade300
                    : isSelected
                    ? Colors.transparent
                    : (_isDarkMode ? AppTheme.amber : AppTheme.blue),
            width: isSelected ? 0 : 1.5,
          ),
        ),
        elevation: isSelected ? 2 : 0,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: AppTheme.subtitleFontSize,
          fontWeight: FontWeight.bold,
          color: _isDarkMode ? AppTheme.amber : AppTheme.navy,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        style: TextStyle(
          color: _isDarkMode ? Colors.white : AppTheme.navy,
          fontSize: AppTheme.bodyFontSize,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: _isDarkMode ? AppTheme.amber : AppTheme.navy,
            fontSize: AppTheme.bodyFontSize,
          ),
          filled: true,
          fillColor: _isDarkMode ? AppTheme.navy : AppTheme.lightInputFillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: _isDarkMode ? AppTheme.amber : AppTheme.navy,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color:
                  _isDarkMode
                      ? AppTheme.amber.withOpacity(0.5)
                      : AppTheme.navy.withOpacity(0.5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: _isDarkMode ? AppTheme.amber : AppTheme.navy,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppTheme.rustOrange, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppTheme.rustOrange, width: 2),
          ),
          errorStyle: TextStyle(
            color: AppTheme.rustOrange,
            fontSize: AppTheme.smallFontSize,
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final data = {
        'motherAge': int.parse(_motherAgeController.text),
        'fatherAge': int.parse(_fatherAgeController.text),
        'numberOfChildren': int.parse(_numberOfChildrenController.text),
        'birthType': _birthTypeController.text,
        'birthWeight': double.parse(_birthWeightController.text),
        'childCondition': _childConditionController.text,
      };

      // Determine the API endpoint based on update method
      final idToUse =
          _isByChild && widget.childId != null
              ? widget.childId!
              : widget.birthPropertyId;

      await EditBirthPropertyApi.editBirthProperty(
        id: idToUse,
        data: data,
        isByChild: _isByChild,
      );

      if (mounted) {
        CustomSnackBar.showSuccess(
          context,
          'Birth property updated successfully',
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.showError(
          context,
          'Failed to update birth property: $e',
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
