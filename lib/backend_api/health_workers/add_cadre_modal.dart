import 'package:flutter/material.dart';
import 'package:wellnessbridge/theme/theme.dart';
import 'package:wellnessbridge/theme/snack_bar.dart';
import 'package:wellnessbridge/backend_api/cadres/cadres_api.dart';
import '../../models/cadre.dart';

class AddCadreModal extends StatefulWidget {
  final bool isDarkMode;
  final Function() onCadreAdded;

  const AddCadreModal({
    super.key,
    required this.isDarkMode,
    required this.onCadreAdded,
  });

  @override
  _AddCadreModalState createState() => _AddCadreModalState();
}

class _AddCadreModalState extends State<AddCadreModal> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _qualificationController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _qualificationController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    // Dismiss keyboard before showing loading to avoid layout shifts
    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final newCadre = Cadre(
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        qualification: _qualificationController.text.trim(),
      );

      await CadresApi.createCadre(newCadre.toJson());

      if (mounted) {
        Navigator.pop(context); // Close the modal
        widget.onCadreAdded(); // Notify parent of success
        CustomSnackBar.showSuccess(context, 'Cadre added successfully');
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        // Log the error for debugging, but show user-friendly message
        print('Error adding cadre: $e');
      });
      // Optionally show a generic error snackbar if _errorMessage is too technical
      if (mounted) {
         CustomSnackBar.showError(context, 'Failed to add cadre. Please try again.');
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
    final theme = Theme.of(context);
    final isDarkMode = widget.isDarkMode;
    final backgroundColor = isDarkMode ? AppTheme.navy : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final accentColor = isDarkMode ? AppTheme.amber : AppTheme.rustOrange;

    return SingleChildScrollView( // Allows content to scroll if keyboard appears
      child: Padding( // Use Padding here instead of directly on Container
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // Adjusts for keyboard
        ),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          // Wrap content in a ConstrainedBox or FractionallySizedBox to limit height,
          // but for BottomSheet, mainAxisSize: MainAxisSize.min in Column usually suffices,
          // combined with SingleChildScrollView for overflow.
          // If you want a fixed max height regardless of content:
          // constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min, // Make column only take up needed space
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header (moved padding to be inside the container for better control)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 8, 0), // Top and horizontal padding
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add New Cadre',
                        style: theme.textTheme.titleLarge?.copyWith( // Use theme for text style
                          color: accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: accentColor),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16), // Smaller spacing

                // Form Fields wrapped in padding
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(color: textColor),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: accentColor),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0), // Smaller padding
                        ),
                        style: TextStyle(color: textColor),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12), // Smaller spacing

                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: TextStyle(color: textColor),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: accentColor),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                        ),
                        style: TextStyle(color: textColor),
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12), // Smaller spacing

                      TextFormField(
                        controller: _qualificationController,
                        decoration: InputDecoration(
                          labelText: 'Qualification',
                          labelStyle: TextStyle(color: textColor),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: accentColor),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                        ),
                        style: TextStyle(color: textColor),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a qualification';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20), // Spacing before error/button

                // Error message
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16), // Padding around error message
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(color: theme.colorScheme.error), // Use theme error color
                      textAlign: TextAlign.center,
                    ),
                  ),

                // Submit button
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16), // Padding around the button
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      padding: const EdgeInsets.symmetric(vertical: 14), // Slightly smaller button padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Optional: slight rounded corners
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            'Add Cadre',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}