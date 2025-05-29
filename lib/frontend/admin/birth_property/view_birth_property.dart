import 'package:flutter/material.dart';
import 'package:wellnessbridge/theme/theme.dart';
import 'package:wellnessbridge/theme/snack_bar.dart';
import 'package:wellnessbridge/backend_api/birth_property/get_birth_property_api.dart';
import 'package:wellnessbridge/frontend/admin/birth_property/edit_birth_property.dart'; // Make sure this import is correct

class ViewBirthProperty extends StatefulWidget {
  final int birthPropertyId;

  const ViewBirthProperty({super.key, required this.birthPropertyId});

  @override
  State<ViewBirthProperty> createState() => _ViewBirthPropertyState();
}

class _ViewBirthPropertyState extends State<ViewBirthProperty> {
  bool _isLoading = true;
  Map<String, dynamic>? _propertyData;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadPropertyData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isDarkMode = Theme.of(context).brightness == Brightness.dark;
  }

  Future<void> _loadPropertyData() async {
    try {
      setState(() => _isLoading = true);
      final data = await GetBirthPropertyApi.getBirthPropertyById(
        widget.birthPropertyId,
      );
      setState(() {
        _propertyData = data['data'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      CustomSnackBar.showError(context, 'Failed to load property details: $e');
    }
  }

  // --- Helper Widgets for Display ---

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

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: AppTheme.bodyFontSize,
              fontWeight: FontWeight.bold,
              color: _isDarkMode ? AppTheme.amber : AppTheme.navy,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: AppTheme.bodyFontSize,
              color: _isDarkMode ? Colors.white70 : AppTheme.blue,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _isDarkMode = Theme.of(context).brightness == Brightness.dark; // Ensure theme is updated

    return Scaffold(
      backgroundColor:
          _isDarkMode ? AppTheme.nightBackgroundColor : AppTheme.sunBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Birth Property Details',
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
            onPressed: () {
              // TODO: Implement theme toggle logic if it's not handled by a global provider
              // For demonstration, you would typically use a ThemeProvider or similar.
              // setState(() {
              //   _isDarkMode = !_isDarkMode; // This only changes local state, not app theme
              // });
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(color: AppTheme.rustOrange),
            )
          : _propertyData == null
              ? Center(
                  child: Text(
                    'No data available',
                    style: TextStyle(
                      color: _isDarkMode ? Colors.white70 : AppTheme.blue,
                      fontSize: AppTheme.bodyFontSize,
                    ),
                  ),
                )
              : Center(
                  // Use a ConstrainedBox for width limiting, then wrap content in SingleChildScrollView
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800), // Increased max width for better two-column display
                    child: SingleChildScrollView( // <--- THIS IS THE KEY CHANGE
                      padding: const EdgeInsets.all(16),
                      child: Card(
                        elevation: 4,
                        color: _isDarkMode ? AppTheme.navy : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionTitle('Basic Property Information'),
                              const SizedBox(height: 8),
                              // Display basic property info that isn't split into columns
                              _buildInfoItem(
                                'Birth Property ID',
                                '#${_propertyData!['bID']}',
                              ),
                              _buildInfoItem(
                                'Child ID (Associated)',
                                '#${_propertyData!['childID']}',
                              ),
                              _buildInfoItem(
                                'Birth Type',
                                _propertyData!['birthType'] ?? 'N/A',
                              ),
                              _buildInfoItem(
                                'Birth Weight',
                                '${_propertyData!['birthWeight']} kg',
                              ),
                              _buildInfoItem(
                                'Child Condition',
                                _propertyData!['childCondition'] ?? 'N/A',
                              ),
                              _buildInfoItem(
                                'Created At',
                                _propertyData!['created_at'] ?? 'N/A',
                              ),
                              _buildInfoItem(
                                'Updated At',
                                _propertyData!['updated_at'] ?? 'N/A',
                              ),

                              const SizedBox(height: 24),
                              _buildSectionTitle('Detailed Child & Parent Information'),
                              const SizedBox(height: 8),

                              // Two-column layout for detailed child and parent info
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Left Column - Child Data
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Child Details',
                                          style: TextStyle(
                                            fontSize: AppTheme.bodyFontSize + 2, // Slightly larger for sub-section title
                                            fontWeight: FontWeight.w600,
                                            color: _isDarkMode ? AppTheme.amber : AppTheme.navy,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        if (_propertyData!['child'] != null) ...[
                                          // Display child image if available
                                          if (_propertyData!['child']['image'] != null && _propertyData!['child']['image'].isNotEmpty)
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: Image.network(
                                                _propertyData!['child']['image'],
                                                height: 120, // Smaller image in column
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) {
                                                  return Container(
                                                    height: 120,
                                                    color: AppTheme.blue.withOpacity(0.1),
                                                    child: Icon(
                                                      Icons.child_care,
                                                      size: 48,
                                                      color: AppTheme.blue,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          const SizedBox(height: 8),
                                          _buildInfoItem(
                                            'Name',
                                            _propertyData!['child']['name'] ?? 'N/A',
                                          ),
                                          _buildInfoItem(
                                            'Gender',
                                            _propertyData!['child']['gender'] ?? 'N/A',
                                          ),
                                          _buildInfoItem(
                                            'Date of Birth',
                                            _propertyData!['child']['dob'] ?? 'N/A',
                                          ),
                                          _buildInfoItem(
                                            'Parent Name',
                                            _propertyData!['child']['parentName'] ?? 'N/A',
                                          ),
                                          _buildInfoItem(
                                            'Parent Contact',
                                            _propertyData!['child']['parentContact'] ?? 'N/A',
                                          ),
                                          _buildInfoItem(
                                            'Address',
                                            _propertyData!['child']['address'] ?? 'N/A',
                                          ),
                                        ] else ...[
                                          Text(
                                            'Child details not available.',
                                            style: TextStyle(
                                              fontSize: AppTheme.bodyFontSize,
                                              color: _isDarkMode ? Colors.white54 : AppTheme.blue.withOpacity(0.7),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 32), // Increased space between columns
                                  // Right Column - Parent Data
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Parent Details',
                                          style: TextStyle(
                                            fontSize: AppTheme.bodyFontSize + 2, // Slightly larger for sub-section title
                                            fontWeight: FontWeight.w600,
                                            color: _isDarkMode ? AppTheme.amber : AppTheme.navy,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        _buildInfoItem(
                                          'Mother Age',
                                          '${_propertyData!['motherAge']} years',
                                        ),
                                        _buildInfoItem(
                                          'Father Age',
                                          '${_propertyData!['fatherAge']} years',
                                        ),
                                        _buildInfoItem(
                                          'Number of Children',
                                          '${_propertyData!['numberOfChildren']}',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                              Center(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    final int? birthPropertyIdToEdit = _propertyData!['bID'];
                                    // Make sure birthPropertyIdToEdit is not null before navigating
                                    if (birthPropertyIdToEdit != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditBirthProperty(
                                            birthPropertyId: birthPropertyIdToEdit,
                                          ),
                                        ),
                                      );
                                    } else {
                                      CustomSnackBar.showError(context, 'Cannot edit: Birth Property ID is missing.');
                                    }
                                  },
                                  icon: const Icon(Icons.edit, color: Colors.white),
                                  label: Text(
                                    'Edit Birth Property',
                                    style: TextStyle(fontSize: AppTheme.buttonFontSize, color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _isDarkMode ? AppTheme.blue : AppTheme.rustOrange,
                                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 5,
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