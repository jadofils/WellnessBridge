import 'package:flutter/material.dart';
import 'package:wellnessbridge/theme/theme.dart';
import 'package:wellnessbridge/theme/snack_bar.dart';
import 'package:wellnessbridge/backend_api/cadres/cadres_api.dart';

class AddCadre extends StatefulWidget {
  final bool isDarkMode;
  const AddCadre({super.key, required this.isDarkMode});

  @override
  _AddCadreState createState() => _AddCadreState();
}

class _AddCadreState extends State<AddCadre> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _qualificationController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _qualificationController.dispose();
    super.dispose();
  }

  Future<void> _saveCadre() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await CadresApi.createCadre({
        'name': _nameController.text,
        'description': _descriptionController.text,
        'qualification': _qualificationController.text,
      });

      if (mounted) {
        CustomSnackBar.showSuccess(context, 'Cadre added successfully');
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
    return Scaffold(
      backgroundColor:
          widget.isDarkMode
              ? AppTheme.nightBackgroundColor
              : AppTheme.sunBackgroundColor,
      appBar: AppBar(
        title: const Text('Add Cadre'),
        backgroundColor:
            widget.isDarkMode ? AppTheme.navy : AppTheme.rustOrange,
        foregroundColor: widget.isDarkMode ? AppTheme.amber : Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                controller: _nameController,
                label: 'Name',
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _qualificationController,
                label: 'Qualification',
                icon: Icons.school,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Qualification is required';
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
                  if (value == null || value.isEmpty) {
                    return 'Description is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveCadre,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        widget.isDarkMode ? AppTheme.blue : AppTheme.rustOrange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child:
                      _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Save Cadre'),
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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
        filled: true,
        fillColor:
            widget.isDarkMode
                ? AppTheme.navy.withOpacity(0.5)
                : Colors.grey.withOpacity(0.1),
      ),
      validator: validator,
    );
  }
}
