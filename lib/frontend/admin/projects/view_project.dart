import 'package:flutter/material.dart';
import 'package:wellnessbridge/theme/theme.dart';

class ViewProject extends StatelessWidget {
  final Map<String, dynamic> project;
  final bool isDarkMode;

  const ViewProject({super.key, required this.project, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    // Determine text color based on dark mode
    final textColor = isDarkMode ? Colors.white70 : Colors.black87;
    final titleColor = isDarkMode ? AppTheme.amber : AppTheme.navy;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Details'),
        backgroundColor: isDarkMode ? AppTheme.navy : AppTheme.rustOrange,
        foregroundColor: isDarkMode ? AppTheme.amber : Colors.white,
      ),
      backgroundColor:
          isDarkMode
              ? AppTheme.nightBackgroundColor
              : AppTheme.sunBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundColor: isDarkMode ? AppTheme.amber : AppTheme.blue,
                foregroundColor: Colors.white,
                radius: 40,
                child: Text(
                  project['name'][0].toUpperCase(),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildDetailRow(
              label: 'Name',
              value: project['name'] ?? 'N/A',
              icon: Icons.title,
              textColor: textColor,
              iconColor: titleColor,
              isDarkMode: isDarkMode,
            ),
            const SizedBox(height: 16),
            _buildDetailRow(
              label: 'Status',
              value: project['status'] ?? 'N/A',
              icon: Icons.info,
              textColor: textColor,
              iconColor: titleColor,
              isDarkMode: isDarkMode,
            ),
            const SizedBox(height: 16),
            _buildDetailRow(
              label: 'Description',
              value: project['description'] ?? 'No description provided.',
              icon: Icons.description,
              textColor: textColor,
              iconColor: titleColor,
              isDarkMode: isDarkMode,
            ),
            const SizedBox(height: 16),
            _buildDetailRow(
              label: 'Created At',
              value: _formatDate(project['created_at']),
              icon: Icons.calendar_today,
              textColor: textColor,
              iconColor: titleColor,
              isDarkMode: isDarkMode,
            ),
            const SizedBox(height: 16),
            _buildDetailRow(
              label: 'Last Updated',
              value: _formatDate(project['updated_at']),
              icon: Icons.update,
              textColor: textColor,
              iconColor: titleColor,
              isDarkMode: isDarkMode,
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context); // Go back to the list
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back to List'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isDarkMode ? AppTheme.blue : AppTheme.rustOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to build consistent detail rows
  Widget _buildDetailRow({
    required String label,
    required String value,
    required IconData icon,
    required Color textColor,
    required Color iconColor,
    required bool isDarkMode, // Pass dark mode flag
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color:
            isDarkMode
                ? AppTheme.navy.withOpacity(0.5)
                : Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color:
              isDarkMode
                  ? AppTheme.blue.withOpacity(0.5)
                  : AppTheme.rustOrange.withOpacity(0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppTheme.bodyFontSize,
                    color:AppTheme.lightInputFillColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: AppTheme.bodyFontSize,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to format dates
  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return 'N/A';
    }
    try {
      final dateTime = DateTime.parse(dateString);
      return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString; // Return original if parsing fails
    }
  }
}
