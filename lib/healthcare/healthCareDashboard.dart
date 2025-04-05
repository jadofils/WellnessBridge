import 'package:flutter/material.dart';
import 'package:health_assistant_app/theme/theme.dart';

class HealthCareDashboard extends StatefulWidget {
  @override
  _HealthCareDashboardState createState() => _HealthCareDashboardState();
}

class _HealthCareDashboardState extends State<HealthCareDashboard> {
  bool _showMeasurementForm = false;
  bool _isDarkMode = false;
  
  // Controllers for measurement form
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _heartRateController = TextEditingController();
  final TextEditingController _bloodSugarController = TextEditingController();
  final TextEditingController _bloodPressureController = TextEditingController();
  final TextEditingController _chestController = TextEditingController();
  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _hipController = TextEditingController();

  // Sample patient data
  final List<Map<String, String>> _patients = [
    {
      'parentId': 'P001',
      'parentEmail': 'parent1@example.com',
      'telephone': '0781234567',
      'childId': 'C001',
      'childNames': 'John Doe',
    },
    {
      'parentId': 'P002',
      'parentEmail': 'parent2@example.com',
      'telephone': '0787654321',
      'childId': 'C002',
      'childNames': 'Jane Smith',
    },
  ];

  @override
  void dispose() {
    // Clean up controllers
    _weightController.dispose();
    _heightController.dispose();
    _heartRateController.dispose();
    _bloodSugarController.dispose();
    _bloodPressureController.dispose();
    _chestController.dispose();
    _waistController.dispose();
    _hipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: Scaffold(
        backgroundColor: _isDarkMode ? AppTheme.nightBackgroundColor : AppTheme.backgroundColor,
        appBar: AppBar(
          title: Text("Health Care Online Status", 
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          centerTitle: true,
          backgroundColor: AppTheme.primaryColor,
          actions: [
            Container(
              width: 200,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.white70),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  filled: true,
                  fillColor: Colors.white24,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            IconButton(
              icon: Icon(_isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              },
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == "Logout") {
                  Navigator.pop(context);
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(value: "Profile", child: Text("Profile")),
                  PopupMenuItem(value: "Settings", child: Text("Settings")),
                  PopupMenuItem(value: "Logout", child: Text("Logout")),
                ];
              },
              icon: Icon(Icons.more_vert, color: Colors.white),
            ),
          ],
        ),
        drawer: _buildAppDrawer(),
        body: _buildDashboardBody(),
      ),
    );
  }

  Widget _buildAppDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppTheme.primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.account_circle, size: 60, color: Colors.white),
                SizedBox(height: 10),
                Text("Health Worker Account", 
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.medical_services),
            title: Text("Check Patient Records"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.access_time),
            title: Text("Schedule Appointments"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text("Medical History"),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardBody() {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to HealthCare Dashboard",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              
              // Reports Section
              _buildReportsSection(),
              SizedBox(height: 20),
              
              // Quick Links Section
              _buildQuickLinksSection(),
              SizedBox(height: 20),
              
              // Measurements Section
              _buildMeasurementsSection(),
              SizedBox(height: 20),
              
              // Patients Table
              _buildPatientsTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReportsSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildReportCard("📊 Daily Parents", "Total: 25", "Active: 5")),
            SizedBox(width: 10),
            Expanded(child: _buildReportCard("📊 Daily Children", "Total: 25", "Active: 5")),
          ],
        ),
        SizedBox(height: 10),
        _buildVaccinationCard(),
      ],
    );
  }

  Widget _buildReportCard(String title, String total, String active) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, 
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: _isDarkMode ? Colors.white : Colors.black87,
                )),
            SizedBox(height: 10),
            Text(total, 
                style: TextStyle(
                  fontSize: 16,
                  color: _isDarkMode ? Colors.white70 : Colors.black54,
                )),
            Text(active, 
                style: TextStyle(
                  fontSize: 16,
                  color: _isDarkMode ? Colors.white70 : Colors.black54,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildVaccinationCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("💉 Vaccination Status", 
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: _isDarkMode ? Colors.white : Colors.black87,
                )),
            SizedBox(height: 10),
            Icon(Icons.vaccines, size: 40, color: Colors.blue),
            Text("Completed: 25", 
                style: TextStyle(
                  fontSize: 16,
                  color: _isDarkMode ? Colors.white70 : Colors.black54,
                )),
            Text("Pending: 5", 
                style: TextStyle(
                  fontSize: 16,
                  color: _isDarkMode ? Colors.white70 : Colors.black54,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickLinksSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Quick Links", 
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: _isDarkMode ? Colors.white : Colors.black87,
                )),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _buildQuickLinkButton("Diseases", Icons.medical_services),
                _buildQuickLinkButton("Helps", Icons.help),
                _buildQuickLinkButton("Events", Icons.event),
                _buildQuickLinkButton("Announcements", Icons.announcement),
                _buildQuickLinkButton("Settings", Icons.settings),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickLinkButton(String title, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16),
      label: Text(title),
      style: ElevatedButton.styleFrom(
        backgroundColor: _isDarkMode ? Colors.blue[900] : Colors.blue[50],
        foregroundColor: _isDarkMode ? Colors.white : Colors.blue[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _buildMeasurementsSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Take Measurements", 
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: _isDarkMode ? Colors.white : Colors.black87,
                    )),
                IconButton(
                  icon: Icon(_showMeasurementForm ? Icons.remove : Icons.add_circle, 
                           color: Colors.blue, size: 30),
                  onPressed: () {
                    setState(() {
                      _showMeasurementForm = !_showMeasurementForm;
                    });
                  },
                ),
              ],
            ),
            _showMeasurementForm ? _buildMeasurementForm() : _buildMeasurementChips(),
          ],
        ),
      ),
    );
  }

  Widget _buildMeasurementChips() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          _buildMeasurementChip("Weight"),
          _buildMeasurementChip("Height"),
          _buildMeasurementChip("Heart Rate"),
          _buildMeasurementChip("Blood Sugar"),
          _buildMeasurementChip("Blood Pressure"),
          _buildMeasurementChip("Chest"),
          _buildMeasurementChip("Waist"),
          _buildMeasurementChip("Hip"),
        ],
      ),
    );
  }

  Widget _buildMeasurementChip(String measurement) {
    return Chip(
      label: Text(measurement),
      backgroundColor: _isDarkMode ? Colors.blue[900] : Colors.blue[50],
      labelStyle: TextStyle(
        color: _isDarkMode ? Colors.white : Colors.blue[800],
      ),
    );
  }

  Widget _buildMeasurementForm() {
    return Column(
      children: [
        SizedBox(height: 10),
        _buildMeasurementField("Weight (kg)", _weightController),
        _buildMeasurementField("Height (cm)", _heightController),
        _buildMeasurementField("Heart Rate (bpm)", _heartRateController),
        _buildMeasurementField("Blood Sugar (mg/dL)", _bloodSugarController),
        _buildMeasurementField("Blood Pressure (mmHg)", _bloodPressureController),
        _buildMeasurementField("Chest (cm)", _chestController),
        _buildMeasurementField("Waist (cm)", _waistController),
        _buildMeasurementField("Hip (cm)", _hipController),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _showMeasurementForm = false;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.buttonColor,
            foregroundColor: AppTheme.buttonTextColor,
          ),
          child: Text("Save Measurements"),
        ),
      ],
    );
  }

  Widget _buildMeasurementField(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: _isDarkMode ? Colors.white70 : Colors.black54,
          ),
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: _isDarkMode ? Colors.blue : Colors.grey,
            ),
          ),
        ),
        style: TextStyle(
          color: _isDarkMode ? Colors.white : Colors.black87,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget _buildPatientsTable() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Patient Records", 
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: _isDarkMode ? Colors.white : Colors.black87,
                )),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  _buildDataColumn("Parent ID"),
                  _buildDataColumn("Parent Email"),
                  _buildDataColumn("Telephone"),
                  _buildDataColumn("Child ID"),
                  _buildDataColumn("Child Names"),
                  _buildDataColumn("Actions"),
                ],
                rows: _patients.map(_buildDataRow).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataColumn _buildDataColumn(String label) {
    return DataColumn(
      label: Text(label, 
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _isDarkMode ? Colors.white : Colors.black87,
          )),
    );
  }

  DataRow _buildDataRow(Map<String, String> patient) {
    return DataRow(
      cells: [
        _buildDataCell(patient['parentId']!),
        _buildDataCell(patient['parentEmail']!),
        _buildDataCell(patient['telephone']!),
        _buildDataCell(patient['childId']!),
        _buildDataCell(patient['childNames']!),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blue),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  DataCell _buildDataCell(String text) {
    return DataCell(
      Text(text,
          style: TextStyle(
            color: _isDarkMode ? Colors.white70 : Colors.black54,
          )),
    );
  }
}