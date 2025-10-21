import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/colors.dart';

// Theme Colors (Matching main.dart and HerCareHomePage.dart for consistency)

// ====================================================================
// PODCAST SCREEN
// ====================================================================

class PodcastScreen extends StatefulWidget {
  const PodcastScreen({super.key});

  @override
  State<PodcastScreen> createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
  }

  Future<void> _loadUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('userEmail');

    if (email != null) {
      print("✅ Logged in as: $email");
      setState(() {
        userEmail = email;
      });
    }
  }

  // Function to handle the button press (placeholder for now)
  void _addCustomPodcast(BuildContext context) {
    // This is where you would launch a modal/dialog
    // to collect the custom podcast link and name.
    print('Add Custom Podcast button pressed. Implement modal here!');

    // Show a quick feedback SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Custom link feature coming soon!',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: kAppBarTextColor,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Girl Power Podcasts 🎧',
          style: GoogleFonts.poppins(
            color: kAppBarTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: kBackgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: kAppBarTextColor),
        actions: [
          if (userEmail != null)
            IconButton(
              icon: const Icon(Icons.logout, color: kAppBarTextColor),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('userEmail'); // Clear login
                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/signup', (route) => false);
                }
              },
            ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.mic_rounded, size: 80, color: kPrimaryDarkPink),
              const SizedBox(height: 20),
              Text(
                'Podcast Hub',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: kAppBarTextColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'We are curating the best wellness and empowerment content for you! This screen will feature recommended podcasts and a custom link option soon.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: kAppBarTextColor.withOpacity(0.7),
                ),
              ),
              // CUSTOM PODCAST BUTTON
              const SizedBox(height: 40),
              SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () => _addCustomPodcast(context),
                  icon: const Icon(Icons.add_link_rounded, color: Colors.white),
                  label: Text(
                    'Add Custom Podcast',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryDarkPink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    shadowColor: kPrimaryDarkPink.withOpacity(0.5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}