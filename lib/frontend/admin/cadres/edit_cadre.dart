import 'package:flutter/material.dart';
import 'package:wellnessbridge/backend_api/cadres/cadres_api.dart';
import 'package:wellnessbridge/theme/theme.dart';
import 'package:wellnessbridge/theme/snack_bar.dart';

class EditCadre extends StatefulWidget {
  final Map<String, dynamic>? cadre; // Made nullable for 'Add' functionality
  final bool isDarkMode;

  const EditCadre({
    Key? key,
    this.cadre, // No longer required, can be null for new cadres
    required this.isDarkMode,
  }) : super(key: key);

  @override
  State<EditCadre> createState() => _EditCadreState();
}

class _EditCadreState extends State<EditCadre> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _qualificationController;
  bool _isLoading = false;
  bool _isNewCadre = false;

  @override
  void initState() {
    super.initState();
    _isNewCadre = widget.cadre == null; // Determine if it's a new cadre
    _nameController = TextEditingController(text: widget.cadre?['name'] ?? '');
    _descriptionController = TextEditingController(
      text: widget.cadre?['description'] ?? '',
    );
    _qualificationController = TextEditingController(
      text: widget.cadre?['qualification'] ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _qualificationController.dispose();
    super.dispose();
  }

  Future<void> _saveCadre() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final cadreData = {
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'qualification': _qualificationController.text.trim(),
      };

      if (_isNewCadre) {
        // Create new cadre
        await CadresApi.createCadre(cadreData);
        if (mounted) {
          CustomSnackBar.showSuccess(context, 'Cadre created successfully!');
          Navigator.pop(context, true); // Indicate success
        }
      } else {
        // Update existing cadre
        final int cadID = widget.cadre!['cadID'];
        await CadresApi.updateCadre(cadID, cadreData);
        if (mounted) {
          CustomSnackBar.showSuccess(context, 'Cadre updated successfully!');
          Navigator.pop(context, true); // Indicate success
        }
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.showError(context, 'Error: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isNewCadre ? 'Add Cadre' : 'Edit Cadre'),
        backgroundColor:
            widget.isDarkMode ? AppTheme.navy : AppTheme.rustOrange,
        foregroundColor: widget.isDarkMode ? AppTheme.amber : Colors.white,
      ),
      backgroundColor:
          widget.isDarkMode
              ? AppTheme.nightBackgroundColor
              : AppTheme.sunBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                controller: _nameController,
                label: 'Cadre Name',
                icon: Icons.assignment_ind,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Cadre Name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _descriptionController,
                label: 'Description',
                icon: Icons.description,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Description is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _qualificationController,
                label: 'Qualification',
                icon: Icons.military_tech,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Qualification is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isLoading ? null : _saveCadre,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      widget.isDarkMode ? AppTheme.blue : AppTheme.rustOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child:
                    _isLoading
                        ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                        : Text(
                          _isNewCadre ? 'Add Cadre' : 'Update Cadre',
                          style: const TextStyle(
                            fontSize: AppTheme.buttonFontSize,
                          ),
                        ),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: _isLoading ? null : () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(
                    color:
                        widget.isDarkMode
                            ? AppTheme.amber
                            : AppTheme.rustOrange,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: AppTheme.buttonFontSize,
                    color:
                        widget.isDarkMode
                            ? AppTheme.amber
                            : AppTheme.rustOrange,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      style: TextStyle(
        color: widget.isDarkMode ? Colors.white : Colors.black87,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: widget.isDarkMode ? AppTheme.amber : AppTheme.rustOrange,
        ),
        prefixIcon: Icon(
          icon,
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
                ? AppTheme.darkInputFillColor
                : AppTheme.lightInputFillColor,
      ),
    );
  }
}
