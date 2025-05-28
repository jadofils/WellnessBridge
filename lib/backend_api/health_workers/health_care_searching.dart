import 'package:flutter/material.dart';
import 'package:wellnessbridge/theme/theme.dart';

class HealthWorkerSearch extends StatefulWidget {
  final bool isDarkMode;
  final List<String> healthWorkers; // Example list of health workers

  const HealthWorkerSearch({
    super.key,
    required this.isDarkMode,
    required this.healthWorkers,
  });

  @override
  _HealthWorkerSearchState createState() => _HealthWorkerSearchState();
}

class _HealthWorkerSearchState extends State<HealthWorkerSearch> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredHealthWorkers = [];

  @override
  void initState() {
    super.initState();
    _filteredHealthWorkers = widget.healthWorkers;
  }

  void _filterHealthWorkers(String query) {
    setState(() {
      _filteredHealthWorkers =
          widget.healthWorkers
              .where(
                (worker) => worker.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterHealthWorkers,
                  decoration: InputDecoration(
                    hintText: "Search health workers...",
                    prefixIcon: Icon(
                      Icons.search,
                      color:
                          widget.isDarkMode
                              ? AppTheme.blue
                              : AppTheme.rustOrange,
                    ),
                    filled: true,
                    fillColor: widget.isDarkMode ? AppTheme.navy : Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // List of Health Workers
        Expanded(
          child: ListView.builder(
            itemCount: _filteredHealthWorkers.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  _filteredHealthWorkers[index],
                  style: TextStyle(
                    color:
                        widget.isDarkMode
                            ? AppTheme.amber
                            : AppTheme.rustOrange,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
