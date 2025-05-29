import 'package:flutter/material.dart';
import 'package:wellnessbridge/HomePages/login.dart';
import 'package:wellnessbridge/backend_api/auth/signup_api.dart';
import 'package:wellnessbridge/theme/snack_bar.dart'; // Import your snack bar utility
import 'package:wellnessbridge/theme/theme.dart';
// import 'package:intl/intl.dart'; // No longer needed for date formatting if DOB is removed

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? _selectedRole; // State variable for selected role
  String? _selectedGender; // State variable for selected gender
  String? _selectedCadID; // State variable for selected cadID
  bool _agreeToTerms = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  // Controllers - Removed _dobController, _phoneController, _addressController
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _cadIDSearchController =
      TextEditingController(); // Controller for cadID search input

  List<String> _allCadIDs = []; // Stores all fetched cadIDs
  List<String> _filteredCadIDs = []; // Stores cadIDs filtered by search
  Map<String, String> _cadIDToName = {}; // Map to store CadID to name mapping

  @override
  void initState() {
    super.initState();
    _fetchCadIDs(); // Fetch cadIDs when the page initializes
  }

  // Function to fetch cadIDs from the backend
  Future<void> _fetchCadIDs() async {
    try {
      final List<Map<String, dynamic>> fetchedCadres =
          await SignUpApi.fetchCadres();
      setState(() {
        _allCadIDs =
            fetchedCadres.map((cadre) => cadre['cadID'].toString()).toList();
        _filteredCadIDs = List.from(_allCadIDs);
        // Create mapping of CadID to name
        _cadIDToName = Map.fromEntries(
          fetchedCadres.map(
            (cadre) => MapEntry(
              cadre['cadID'].toString(),
              cadre['name']?.toString() ?? 'Unknown',
            ),
          ),
        );
      });
    } catch (e) {
      CustomSnackBar.showError(
        context,
        "Failed to load cadres: ${e.toString().replaceFirst('Exception: ', '')}",
      );
    }
  }

  // Enhanced email validation
  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      caseSensitive: false,
    );
    return emailRegex.hasMatch(email);
  }

  // Strong password validation (minimum 8 chars with at least 1 uppercase, 1 lowercase, 1 number, 1 special char)
  bool isStrongPassword(String password) {
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    if (!password.contains(RegExp(r'[a-z]'))) return false;
    if (!password.contains(RegExp(r'[0-9]'))) return false;
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
    return true;
  }

  // Phone validation (kept for potential future use or if backend still validates it, but not used in UI)
  bool isValidPhone(String phone) {
    return RegExp(r'^\d{10,15}$').hasMatch(phone);
  }

  // Handle sign up with email existence check
  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) {
      CustomSnackBar.showError(
        context,
        "Please correct the errors in the form",
      );
      return;
    }

    if (!_agreeToTerms) {
      CustomSnackBar.showError(
        context,
        "You must agree to the terms and conditions",
      );
      return;
    }

    if (_selectedCadID == null) {
      CustomSnackBar.showError(context, "Please select a CadID");
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Prepare data for registration, only sending required fields
      final userData = {
        "name": _nameController.text.trim(),
        "gender": _selectedGender,
        "role": _selectedRole,
        "email": _emailController.text.trim(),
        "password": _passwordController.text,
        "cadID":
            _selectedCadID, // Changed back to cadID to match database schema
        // Optional fields are not included in the request
      };

      print("Attempting to register with data: $userData"); // For debugging

      // Call the signup API
      final responseData = await SignUpApi.signUpUser(userData);

      print(
        "Registration successful! Response: $responseData",
      ); // For debugging

      CustomSnackBar.showSuccess(context, "Registration successful!");

      // Clear form and navigate to login
      _formKey.currentState!.reset();
      setState(() {
        // Clear all controllers
        _nameController.clear();
        _emailController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();
        _cadIDSearchController.clear(); // Clear search controller
        _selectedRole = null; // Reset selected role
        _selectedGender = null; // Reset selected gender
        _selectedCadID = null; // Reset selected cadID
        _agreeToTerms = false;
        _fetchCadIDs(); // Re-fetch cadIDs to refresh the list if needed
      });

      Navigator.pushReplacementNamed(context, '/wellnessbridge/page/login');
    } catch (e) {
      CustomSnackBar.showError(
        context,
        "Registration failed: ${e.toString().replaceFirst('Exception: ', '')}",
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Function to show the searchable CadID dropdown dialog
  void _showCadIDSearchDialog() {
    _cadIDSearchController.clear(); // Clear previous search
    setState(() {
      _filteredCadIDs = List.from(_allCadIDs); // Reset filtered list
    });

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Select CadID',
            style: AppTheme.subtitleTextStyle.copyWith(color: AppTheme.navy),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _cadIDSearchController,
                      decoration: InputDecoration(
                        labelText: 'Search CadID or Name',
                        labelStyle: AppTheme.bodyTextStyle,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.search, color: AppTheme.blue),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppTheme.rustOrange,
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (query) {
                        setState(() {
                          _filteredCadIDs =
                              _allCadIDs
                                  .where(
                                    (cadID) =>
                                        cadID.toLowerCase().contains(
                                          query.toLowerCase(),
                                        ) ||
                                        (_cadIDToName[cadID] ?? '')
                                            .toLowerCase()
                                            .contains(query.toLowerCase()),
                                  )
                                  .toList();
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    Container(
                      constraints: BoxConstraints(maxHeight: 200),
                      child:
                          _filteredCadIDs.isEmpty
                              ? Center(
                                child: Text(
                                  'No matching CadIDs found.',
                                  style: AppTheme.bodyTextStyle.copyWith(
                                    color: AppTheme.navy,
                                  ),
                                ),
                              )
                              : ListView.builder(
                                itemCount: _filteredCadIDs.length,
                                itemBuilder: (context, index) {
                                  final cadID = _filteredCadIDs[index];
                                  final name = _cadIDToName[cadID] ?? 'Unknown';
                                  return ListTile(
                                    title: Text(
                                      cadID,
                                      style: AppTheme.bodyTextStyle.copyWith(
                                        color: AppTheme.navy,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      name,
                                      style: AppTheme.bodyTextStyle.copyWith(
                                        color: AppTheme.blue,
                                      ),
                                    ),
                                    onTap: () {
                                      this.setState(() {
                                        _selectedCadID = cadID;
                                        _allCadIDs.remove(cadID);
                                        _cadIDSearchController.text = cadID;
                                      });
                                      Navigator.of(dialogContext).pop();
                                    },
                                  );
                                },
                              ),
                    ),
                  ],
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text(
                'Cancel',
                style: AppTheme.bodyTextStyle.copyWith(color: AppTheme.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    // _dobController.dispose(); // Removed
    // _phoneController.dispose(); // Removed
    _emailController.dispose();
    // _addressController.dispose(); // Removed
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _cadIDSearchController.dispose(); // Dispose cadID search controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine if current theme is dark or light based on brightness
    final Brightness brightness = Theme.of(context).brightness;
    final bool isDarkMode = brightness == Brightness.dark;

    // Apply appropriate background color based on theme
    final Color backgroundColor =
        isDarkMode
            ? AppTheme.nightBackgroundColor
            : AppTheme.sunBackgroundColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo & Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppTheme.amber.withOpacity(
                          0.2,
                        ), // Using amber with opacity
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/uploads/logo.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'WellnessBridge',
                      style: AppTheme.titleTextStyle.copyWith(
                        fontSize: 32,
                        color: AppTheme.rustOrange, // Using theme primary color
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),

                // Sign Up Form
                Container(
                  width:
                      MediaQuery.of(context).size.width > 600
                          ? 400
                          : double.infinity,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.blue.withOpacity(
                          0.2,
                        ), // Using theme blue with opacity
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create an Account',
                        style: AppTheme.subtitleTextStyle.copyWith(
                          fontSize: 18,
                          color: AppTheme.navy, // Using theme navy color
                        ),
                      ),
                      SizedBox(height: 20),

                      // Full Name
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: AppTheme.blue,
                          ), // Using theme blue
                          labelText: 'Full Name',
                          labelStyle: AppTheme.bodyTextStyle,
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppTheme.rustOrange,
                              width: 2,
                            ), // Using theme primary
                          ),
                        ),
                        validator:
                            (value) =>
                                value!.isEmpty ? "Name is required" : null,
                      ),
                      SizedBox(height: 15),

                      // Gender Dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedGender,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppTheme.rustOrange,
                              width: 2,
                            ), // Using theme primary
                          ),
                          prefixIcon: Icon(
                            Icons.transgender,
                            color: AppTheme.blue,
                          ), // Using theme blue
                          labelText: 'Select Gender',
                          labelStyle: AppTheme.bodyTextStyle,
                        ),
                        dropdownColor: Colors.white,
                        style: AppTheme.bodyTextStyle.copyWith(
                          color: AppTheme.navy,
                        ), // Using theme navy
                        items:
                            ['Male', 'Female', 'Other']
                                .map(
                                  (gender) => DropdownMenuItem(
                                    value: gender,
                                    child: Text(gender),
                                  ),
                                )
                                .toList(),
                        onChanged:
                            (newValue) =>
                                setState(() => _selectedGender = newValue),
                        validator:
                            (value) =>
                                value == null ? "Please select gender" : null,
                      ),
                      SizedBox(height: 15),

                      // Role Dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedRole,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppTheme.rustOrange,
                              width: 2,
                            ), // Using theme primary
                          ),
                          prefixIcon: Icon(
                            Icons.work,
                            color: AppTheme.blue,
                          ), // Using theme blue
                          labelText: 'Select Role',
                          labelStyle: AppTheme.bodyTextStyle,
                        ),
                        dropdownColor: Colors.white,
                        style: AppTheme.bodyTextStyle.copyWith(
                          color: AppTheme.navy,
                        ), // Using theme navy
                        items:
                            ['Umunyabuzima', 'Parent', 'Admin']
                                .map(
                                  (role) => DropdownMenuItem(
                                    value: role,
                                    child: Text(role),
                                  ),
                                )
                                .toList(),
                        onChanged:
                            (newValue) =>
                                setState(() => _selectedRole = newValue),
                        validator:
                            (value) =>
                                value == null ? "Please select a role" : null,
                      ),
                      SizedBox(height: 15),

                      // CadID Searchable Dropdown (TextFormField that opens a dialog)
                      TextFormField(
                        controller: TextEditingController(
                          text: _selectedCadID,
                        ), // Display selected value
                        readOnly: true,
                        onTap: _showCadIDSearchDialog,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.badge, // Or another relevant icon
                            color: AppTheme.blue,
                          ),
                          labelText: 'Select CadID',
                          labelStyle: AppTheme.bodyTextStyle,
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppTheme.rustOrange,
                              width: 2,
                            ),
                          ),
                          suffixIcon:
                              _selectedCadID != null
                                  ? IconButton(
                                    icon: Icon(
                                      Icons.clear,
                                      color: AppTheme.blue,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _selectedCadID = null;
                                        _cadIDSearchController.clear();
                                        _fetchCadIDs(); // Re-fetch all cadIDs if cleared
                                      });
                                    },
                                  )
                                  : null,
                        ),
                        validator:
                            (value) =>
                                _selectedCadID == null
                                    ? "CadID is required"
                                    : null,
                      ),
                      SizedBox(height: 15),

                      // Email with existence check
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: AppTheme.blue,
                          ), // Using theme blue
                          labelText: 'Email Address',
                          labelStyle: AppTheme.bodyTextStyle,
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppTheme.rustOrange,
                              width: 2,
                            ), // Using theme primary
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return "Email is required";
                          if (!isValidEmail(value)) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      // Password with strength validation
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: AppTheme.blue,
                          ), // Using theme blue
                          labelText: 'Password',
                          labelStyle: AppTheme.bodyTextStyle,
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppTheme.rustOrange,
                              width: 2,
                            ), // Using theme primary
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.info_outline,
                              color: AppTheme.amber,
                            ), // Using theme amber
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                      title: Text(
                                        "Password Requirements",
                                        style: TextStyle(
                                          color: AppTheme.rustOrange,
                                        ), // Using theme primary
                                      ),
                                      content: Text(
                                        "• At least 8 characters\n"
                                        "• 1 uppercase letter\n"
                                        "• 1 lowercase letter\n"
                                        "• 1 number\n"
                                        "• 1 special character",
                                        style: AppTheme.bodyTextStyle,
                                      ),
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                              );
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return "Password is required";
                          if (!isStrongPassword(value)) {
                            return "Password doesn't meet requirements";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      // Confirm Password
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: AppTheme.blue,
                          ), // Using theme blue
                          labelText: 'Confirm Password',
                          labelStyle: AppTheme.bodyTextStyle,
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppTheme.rustOrange,
                              width: 2,
                            ), // Using theme primary
                          ),
                        ),
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return "Passwords don't match";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),

                      // Terms Checkbox
                      Row(
                        children: [
                          Checkbox(
                            value: _agreeToTerms,
                            onChanged:
                                (value) => setState(
                                  () => _agreeToTerms = value ?? false,
                                ),
                            activeColor:
                                AppTheme.rustOrange, // Using theme primary
                          ),
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                // Show terms and conditions
                              },
                              child: Text(
                                "I agree to the terms and conditions",
                                style: AppTheme.bodyTextStyle.copyWith(
                                  decoration: TextDecoration.underline,
                                  color: AppTheme.navy, // Using theme navy
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Sign Up Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleSignUp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                AppTheme.rustOrange, // Using theme primary
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            disabledBackgroundColor: AppTheme.rustOrange
                                .withOpacity(
                                  0.5,
                                ), // Using theme primary with opacity
                          ),
                          child:
                              _isLoading
                                  ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : Text(
                                    "SIGN UP",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                        ),
                      ),
                      SizedBox(height: 15),

                      // Login Link
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              '/wellnessbridge/page/login',
                            );
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(
                                color: AppTheme.navy,
                              ), // Using theme navy
                              children: [
                                TextSpan(
                                  text: "Log In",
                                  style: TextStyle(
                                    color: AppTheme.blue, // Using theme blue
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
