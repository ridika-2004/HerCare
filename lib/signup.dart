import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/colors.dart';
import 'services/storage_service.dart'; // ADD THIS IMPORT

// ====================================================================
// SIGN UP / LOGIN SCREEN
// ====================================================================

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  bool _isLoading = false;

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // --------------------------------------------------------------------
  // Submit function to call Django backend
  // --------------------------------------------------------------------
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final confirmPassword = _confirmPasswordController.text.trim();

      // For Android emulator, use 10.0.2.2 instead of 127.0.0.1
      final url = _isLogin
          ? Uri.parse('http://127.0.0.1:8000/user/login/')
          : Uri.parse('http://127.0.0.1:8000/user/signup/');

      final body = json.encode({
        "email": email,
        "password": password,
        if (!_isLogin) ...{
          "name": name,
          "confirm_password": confirmPassword,
        },
      });

      try {
        final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: body,
        );

        final data = json.decode(response.body);

        if (!mounted) return;

        setState(() {
          _isLoading = false;
        });

        if (response.statusCode == 200 && data["status"] == "success") {
          // ✅ CORRECTED: Save user email to SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('userEmail', email); // Use the email variable
          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('userName', data["data"]?["name"] ?? name);

          // ✅ CORRECTED: Set email in StorageService for period tracker
          StorageService.userEmail = email;
          
          print("✅ ${_isLogin ? 'Login' : 'Signup'} success — saved: $email");

          // Navigate to main app
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainNavigatorScreen()),
          );

        } else {
          // Handle different error cases
          String errorMessage = data["message"] ?? "Authentication failed";
          if (response.statusCode == 400) {
            errorMessage = "Invalid email or password format";
          } else if (response.statusCode == 401) {
            errorMessage = "Invalid credentials";
          } else if (response.statusCode == 500) {
            errorMessage = "Server error. Please try again later.";
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }

      } catch (e) {
        if (!mounted) return;
        
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Network error: Please check your connection"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // --------------------------------------------------------------------
  // Custom Input Field Widget
  // --------------------------------------------------------------------
  Widget _buildInputField({
    required String labelText,
    required IconData icon,
    required TextEditingController controller,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        style: GoogleFonts.poppins(color: kAppBarTextColor),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.poppins(color: kAppBarTextColor.withOpacity(0.8)),
          prefixIcon: Icon(icon, color: kPrimaryDarkPink),
          fillColor: kInputFillColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: kPrimaryDarkPink, width: 2),
          ),
        ),
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your $labelText.';
              }
              if (labelText.toLowerCase().contains('email') && !value.contains('@')) {
                return 'Please enter a valid email.';
              }
              if (isPassword && value.length < 6) {
                return 'Password must be at least 6 characters.';
              }
              return null;
            },
      ),
    );
  }

  // --------------------------------------------------------------------
  // Dispose controllers to free memory
  // --------------------------------------------------------------------
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // --------------------------------------------------------------------
  // Main Build UI
  // --------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: screenHeight * 0.05),

              // Icon & Titles
              Icon(
                _isLogin ? Icons.lock_open_rounded : Icons.person_add_alt_1_rounded,
                size: 80,
                color: kPrimaryDarkPink,
              ),
              const SizedBox(height: 10),
              Text(
                _isLogin ? 'Welcome Back! 👋' : 'Create Your Account',
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: kAppBarTextColor,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                _isLogin
                    ? 'Log in to continue your journey.'
                    : 'Join the Girl Power community.',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: kAppBarTextColor.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 40),

              // ---------------- Form ----------------
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    if (!_isLogin)
                      _buildInputField(
                        labelText: 'Username',
                        icon: Icons.person_rounded,
                        controller: _nameController,
                      ),
                    _buildInputField(
                      labelText: 'Email',
                      icon: Icons.email_rounded,
                      controller: _emailController,
                    ),
                    _buildInputField(
                      labelText: 'Password',
                      icon: Icons.vpn_key_rounded,
                      controller: _passwordController,
                      isPassword: true,
                    ),
                    if (!_isLogin)
                      _buildInputField(
                        labelText: 'Confirm Password',
                        icon: Icons.check_circle_outline_rounded,
                        controller: _confirmPasswordController,
                        isPassword: true,
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match.';
                          }
                          return null;
                        },
                      ),

                    const SizedBox(height: 30),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: _isLoading
                          ? ElevatedButton(
                              onPressed: null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryDarkPink.withOpacity(0.7),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'PLEASE WAIT...',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ElevatedButton(
                              onPressed: _submitForm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryDarkPink,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 8,
                                shadowColor: kPrimaryDarkPink.withOpacity(0.5),
                              ),
                              child: Text(
                                _isLogin ? 'LOG IN' : 'SIGN UP',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Switch Mode Button
              if (!_isLoading)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                      _nameController.clear();
                      _emailController.clear();
                      _passwordController.clear();
                      _confirmPasswordController.clear();
                    });
                  },
                  child: Text(
                    _isLogin
                        ? 'Don\'t have an account? Sign Up'
                        : 'Already have an account? Log In',
                    style: GoogleFonts.poppins(
                      color: kPrimaryDarkPink,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}