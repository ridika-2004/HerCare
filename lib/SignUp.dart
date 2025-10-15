import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Theme Colors (Matching previous files) ---
const Color kPrimaryDarkPink = Color(0xFFE9386D); 
const Color kAppBarTextColor = Color.fromARGB(255, 74, 3, 40);
const Color kBackgroundColor = Color(0xFFFFFAFD);
const Color kInputFillColor = Color(0xFFF0E4E7);


// ====================================================================
// 1. PLACEHOLDER HOME SCREEN (Navigation Target)
//    This is where the user goes after successfully signing in.
// ====================================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text('Welcome Home! ✨', 
          style: GoogleFonts.poppins(color: kAppBarTextColor, fontWeight: FontWeight.bold)
        ),
        backgroundColor: kPrimaryDarkPink.withOpacity(0.1),
        elevation: 0,
        automaticallyImplyLeading: false, 
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, size: 100, color: kPrimaryDarkPink),
            const SizedBox(height: 20),
            Text(
              'Authentication Successful!',
              style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600, color: kAppBarTextColor),
            ),
            const SizedBox(height: 10),
            Text(
              'You are now on the main app page.',
              style: GoogleFonts.poppins(fontSize: 16, color: kAppBarTextColor.withOpacity(0.7)),
            ),
          ],
        ),
      ),
    );
  }
}

// ====================================================================
// 2. SIGN UP / LOG IN SCREEN
// ====================================================================

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true; // State to switch between Login and Sign Up
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _submitForm() {
    // We use the null-aware operator '?? false' to handle the nullable bool 
    // returned by validate(), preventing runtime errors.
    if (_formKey.currentState!.validate() ?? false) {
      // --- Simulated Authentication ---
      
      // Navigate to the HomeScreen upon successful "authentication"
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }
  
  // Custom Text Field Widget
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
        // Default validation logic
        validator: validator ?? (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $labelText.';
          }
          if (labelText == 'Email' && !value.contains('@')) {
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

  @override
  void dispose() {
    // Good practice to dispose controllers
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
              // Logo/Title Area
              SizedBox(height: screenHeight * 0.05),
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
                  color: kAppBarTextColor
                ),
              ),
              const SizedBox(height: 5),
              Text(
                _isLogin ? 'Log in to continue your journey.' : 'Join the Girl Power community.',
                style: GoogleFonts.poppins(
                  fontSize: 16, 
                  color: kAppBarTextColor.withOpacity(0.6)
                ),
              ),
              const SizedBox(height: 40),

              // Authentication Form
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
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
                      child: ElevatedButton(
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
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                    // Clear controllers when switching mode
                    _emailController.clear();
                    _passwordController.clear();
                    _confirmPasswordController.clear();
                  });
                },
                child: Text(
                  _isLogin ? 'Don\'t have an account? Sign Up' : 'Already have an account? Log In',
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
