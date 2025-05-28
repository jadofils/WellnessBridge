import 'package:flutter/material.dart';
import 'package:wellnessbridge/backend_api/projects/projects_api.dart';
import 'package:wellnessbridge/theme/theme.dart';
import 'package:wellnessbridge/theme/snack_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class EditProject extends StatefulWidget {
  final Map<String, dynamic>? project;
  final bool isDarkMode;

  const EditProject({super.key, this.project, required this.isDarkMode});

  @override
  _EditProjectState createState() => _EditProjectState();
}

class _EditProjectState extends State<EditProject> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _searchController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String _status = 'ongoing';
  int? _selectedCadreId;
  String? _selectedCadreName;
  List<Map<String, dynamic>> _cadres = [];
  List<Map<String, dynamic>> _filteredCadres = [];
  List<Map<String, dynamic>> _healthWorkers = [];
  Set<int> _selectedUserIds = {};
  bool _isLoading = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    if (widget.project != null) {
      _nameController.text = widget.project!['name'] ?? '';
      _descriptionController.text = widget.project!['description'] ?? '';
      _startDate = DateTime.tryParse(widget.project!['startDate'] ?? '');
      _endDate = DateTime.tryParse(widget.project!['endDate'] ?? '');
      _status = widget.project!['status'] ?? 'ongoing';
      _selectedCadreId = widget.project!['cadID'];
      _loadCadres();
      if (_selectedCadreId != null) {
        _loadHealthWorkers(_selectedCadreId!);
      }
    } else {
      _loadCadres();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _loadCadres() async {
    try {
      final response = await http
          .get(Uri.parse('http://127.0.0.1:8000/api/v1/cadres'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (mounted) {
          setState(() {
            _cadres = List<Map<String, dynamic>>.from(data['data'] ?? []);
            _filteredCadres = _cadres;
          });
        }
      } else {
        throw Exception('Failed to load cadres: ${response.statusCode}');
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.showError(context, 'Failed to load cadres: $e');
      }
    }
  }

  Future<void> _loadHealthWorkers(int cadreId) async {
    try {
      final response = await http
          .get(
            Uri.parse(
              'http://127.0.0.1:8000/api/v1/healthworkers/cadre/$cadreId',
            ),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (mounted) {
          setState(() {
            _healthWorkers = List<Map<String, dynamic>>.from(
              data['data'] ?? [],
            );
          });
        }
      } else {
        throw Exception(
          'Failed to load health workers: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.showError(context, 'Failed to load health workers: $e');
      }
    }
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _filteredCadres =
              _cadres.where((cadre) {
                final name = cadre['name']?.toString().toLowerCase() ?? '';
                final id = cadre['cadID']?.toString() ?? '';
                final searchLower = value.toLowerCase();
                return name.contains(searchLower) || id.contains(searchLower);
              }).toList();
        });
      }
    });
  }

  Future<void> _selectDate(bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          isStartDate
              ? _startDate ?? DateTime.now()
              : _endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && mounted) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _saveProject() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCadreId == null) {
      CustomSnackBar.showError(context, 'Please select a cadre');
      return;
    }
    if (_startDate == null || _endDate == null) {
      CustomSnackBar.showError(
        context,
        'Please select both start and end dates',
      );
      return;
    }
    if (_selectedUserIds.isEmpty) {
      CustomSnackBar.showError(
        context,
        'Please select at least one health worker',
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final projectData = {
        'cadID': _selectedCadreId,
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'startDate': _startDate!.toIso8601String().split('T')[0],
        'endDate': _endDate!.toIso8601String().split('T')[0],
        'status': _status,
        'assignedUsers': _selectedUserIds.toList(),
      };

      if (widget.project != null) {
        await ProjectsApi.updateProject(widget.project!['prjID'], projectData);
      } else {
        await ProjectsApi.createProject(projectData);
      }

      if (mounted) {
        CustomSnackBar.showSuccess(
          context,
          'Project ${widget.project != null ? 'updated' : 'created'} successfully',
        );
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
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.project != null ? 'Edit Project' : 'Add Project',
          style: textTheme.titleLarge?.copyWith(
            color: widget.isDarkMode ? AppTheme.amber : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor:
            widget.isDarkMode ? AppTheme.navy : AppTheme.rustOrange,
        elevation: 0,
      ),
      backgroundColor:
          widget.isDarkMode
              ? AppTheme.nightBackgroundColor
              : AppTheme.sunBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cadre Selection Section
                Text(
                  'Select Cadre',
                  style: textTheme.titleMedium?.copyWith(
                    color:
                        widget.isDarkMode
                            ? AppTheme.amber
                            : AppTheme.rustOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color:
                        widget.isDarkMode
                            ? AppTheme.navy.withOpacity(0.5)
                            : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          controller: _searchController,
                          style: TextStyle(
                            color:
                                widget.isDarkMode
                                    ? Colors.white
                                    : Colors.black87,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Search Cadre...',
                            hintStyle: TextStyle(
                              color:
                                  widget.isDarkMode
                                      ? Colors.white70
                                      : Colors.black54,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color:
                                  widget.isDarkMode
                                      ? AppTheme.amber
                                      : AppTheme.blue,
                            ),
                            border: InputBorder.none,
                          ),
                          onChanged: _onSearchChanged,
                        ),
                      ),
                      const Divider(height: 1),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: _selectedCadreId,
                            isExpanded: true,
                            hint: Text(
                              'Select Cadre',
                              style: TextStyle(
                                color:
                                    widget.isDarkMode
                                        ? Colors.white70
                                        : Colors.black54,
                              ),
                            ),
                            items:
                                _filteredCadres
                                    .map((cadre) {
                                      final cadId = cadre['cadID'];
                                      if (cadId == null) return null;
                                      return DropdownMenuItem<int>(
                                        value: cadId as int,
                                        child: Text(
                                          '${cadId}. ${cadre['name'] ?? 'Unnamed Cadre'}',
                                          style: TextStyle(
                                            color:
                                                widget.isDarkMode
                                                    ? Colors.white
                                                    : Colors.black87,
                                          ),
                                        ),
                                      );
                                    })
                                    .whereType<DropdownMenuItem<int>>()
                                    .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _selectedCadreId = value;
                                  _selectedUserIds.clear();
                                });

                                _loadHealthWorkers(value);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Health Workers Selection
                if (_selectedCadreId != null && _healthWorkers.isNotEmpty) ...[
                  Text(
                    'Assign Health Workers',
                    style: textTheme.titleMedium?.copyWith(
                      color:
                          widget.isDarkMode
                              ? AppTheme.amber
                              : AppTheme.rustOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color:
                          widget.isDarkMode
                              ? AppTheme.navy.withOpacity(0.5)
                              : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _healthWorkers.length,
                      itemBuilder: (context, index) {
                        final worker = _healthWorkers[index];
                        final workerId = worker['id'] as int;
                        return CheckboxListTile(
                          value: _selectedUserIds.contains(workerId),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                _selectedUserIds.add(workerId);
                              } else {
                                _selectedUserIds.remove(workerId);
                              }
                            });
                          },
                          title: Text(
                            worker['name'] ?? 'No Name',
                            style: TextStyle(
                              color:
                                  widget.isDarkMode
                                      ? Colors.white
                                      : Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            worker['role'] ?? 'No role specified',
                            style: TextStyle(
                              color:
                                  widget.isDarkMode
                                      ? Colors.white70
                                      : Colors.black54,
                            ),
                          ),
                          activeColor:
                              widget.isDarkMode
                                  ? AppTheme.amber
                                  : AppTheme.rustOrange,
                          checkColor: Colors.white,
                          tileColor:
                              widget.isDarkMode
                                  ? AppTheme.navy.withOpacity(0.3)
                                  : null,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // Project Details Section
                Text(
                  'Project Details',
                  style: textTheme.titleMedium?.copyWith(
                    color:
                        widget.isDarkMode
                            ? AppTheme.amber
                            : AppTheme.rustOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  style: TextStyle(
                    color: widget.isDarkMode ? Colors.white : Colors.black87,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Project Name',
                    labelStyle: TextStyle(
                      color:
                          widget.isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                    filled: true,
                    fillColor:
                        widget.isDarkMode
                            ? AppTheme.navy.withOpacity(0.5)
                            : Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color:
                            widget.isDarkMode
                                ? AppTheme.blue
                                : AppTheme.rustOrange,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color:
                            widget.isDarkMode
                                ? AppTheme.blue.withOpacity(0.5)
                                : AppTheme.rustOrange.withOpacity(0.5),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter project name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  style: TextStyle(
                    color: widget.isDarkMode ? Colors.white : Colors.black87,
                  ),
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      color:
                          widget.isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                    filled: true,
                    fillColor:
                        widget.isDarkMode
                            ? AppTheme.navy.withOpacity(0.5)
                            : Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color:
                            widget.isDarkMode
                                ? AppTheme.blue
                                : AppTheme.rustOrange,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color:
                            widget.isDarkMode
                                ? AppTheme.blue.withOpacity(0.5)
                                : AppTheme.rustOrange.withOpacity(0.5),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter project description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildDatePicker(
                        label: 'Start Date',
                        date: _startDate,
                        onTap: () => _selectDate(true),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildDatePicker(
                        label: 'End Date',
                        date: _endDate,
                        onTap: () => _selectDate(false),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color:
                        widget.isDarkMode
                            ? AppTheme.navy.withOpacity(0.5)
                            : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                          widget.isDarkMode
                              ? AppTheme.blue
                              : AppTheme.rustOrange,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _status,
                      isExpanded: true,
                      items:
                          ['ongoing', 'completed', 'pending'].map((status) {
                            return DropdownMenuItem<String>(
                              value: status,
                              child: Text(
                                status.toUpperCase(),
                                style: TextStyle(
                                  color:
                                      widget.isDarkMode
                                          ? Colors.white
                                          : Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _status = value);
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _saveProject,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          widget.isDarkMode
                              ? AppTheme.blue
                              : AppTheme.rustOrange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child:
                        _isLoading
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : Text(
                              widget.project != null
                                  ? 'Update Project'
                                  : 'Create Project',
                              style: const TextStyle(
                                fontSize: 16,
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

  Widget _buildDatePicker({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color:
              widget.isDarkMode ? AppTheme.navy.withOpacity(0.5) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.isDarkMode ? AppTheme.blue : AppTheme.rustOrange,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today,
              size: 20,
              color: widget.isDarkMode ? AppTheme.amber : AppTheme.blue,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                date == null ? label : date.toLocal().toString().split(' ')[0],
                style: TextStyle(
                  color: widget.isDarkMode ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
