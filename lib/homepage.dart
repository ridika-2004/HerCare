import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'signup.dart' as signup; // for logout redirection
import 'history/history_manager.dart'; // Add this import for history tracking

// Feature Card Colors
const Color kCardPeriodRed = Color(0xFFD84A62);
const Color kCardPregnancyOrange = Color(0xFFF58461);
const Color kCardMentalTeal = Color(0xFF63C2C0);
const Color kCardBreastRed = Color(0xFFDA566E);
const Color kCardGamesPurple = Color(0xFF8B64CC);
const Color kCardPodcastBlue = Color(0xFF5CA6D6);

class HerCareHomePage extends StatefulWidget {
  const HerCareHomePage({super.key});

  @override
  State<HerCareHomePage> createState() => _HerCareHomePageState();
}

class _HerCareHomePageState extends State<HerCareHomePage> {
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString('userEmail');
    });
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userEmail');
    setState(() {
      userEmail = null;
    });

    // Navigate to sign-up/login page
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const signup.SignUpScreen()),
      (route) => false,
    );
  }

  // Updated to include category and emoji icons for history tracking
  final List<Map<String, dynamic>> landingFeatures = [
    {
      'title': 'Period Tracker',
      'subtitle': 'Track your cycle status',
      'icon': Icons.calendar_today_rounded,
      'emoji': '📅', // For history tracking
      'color': kCardPeriodRed,
      'category': 'Menstrual Health',
      'route': '/period',
    },
    {
      'title': 'Pregnancy Tracker',
      'subtitle': 'Monitor growth, week by week.',
      'icon': Icons.pregnant_woman_rounded,
      'emoji': '🤰', // For history tracking
      'color': kCardPregnancyOrange,
      'category': 'Pregnancy',
      'route': '/pregnancy',
    },
    {
      'title': 'Mental Health',
      'subtitle': 'Meditations, journal & support',
      'icon': Icons.self_improvement_rounded,
      'emoji': '🧠', // For history tracking
      'color': kCardMentalTeal,
      'category': 'Mental Wellness',
      'route': '/mental',
    },
    {
      'title': 'Breast Health Check',
      'subtitle': 'Self-exam guide & detection',
      'icon': Icons.visibility_rounded,
      'emoji': '🎗️', // For history tracking
      'color': kCardBreastRed,
      'category': 'Cancer Awareness',
      'route': '/breast',
    },
    {
      'title': 'Fun & Games',
      'subtitle': 'Quizzes, puzzles & more',
      'icon': Icons.gamepad_rounded,
      'emoji': '🎮', // For history tracking
      'color': kCardGamesPurple,
      'category': 'Education',
      'route': '', // No route yet
    },
    {
      'title': 'Podcasts',
      'subtitle': 'Listen to expert wellness adv...',
      'icon': Icons.mic_external_on_rounded,
      'emoji': '🎧', // For history tracking
      'color': kCardPodcastBlue,
      'category': 'Education',
      'route': '/podcast',
    },
  ];

  // Method to handle feature card taps with history tracking
  void _onFeatureTap(Map<String, dynamic> feature, BuildContext context) {
    // Track the visit in history
    HistoryManager().addHistory(
      feature['title'] as String,
      feature['emoji'] as String,
      feature['category'] as String,
    );

    // Navigate to the appropriate route
    final String route = feature['route'] as String;
    if (route.isNotEmpty) {
      Navigator.pushNamed(context, route);
    } else {
      // Show coming soon for features without routes
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${feature['title']} - Coming Soon!'),
          backgroundColor: kPrimaryDarkPink,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const double headerHeight = 250.0;
    const double welcomeCardHeight = 150.0;
    const double overlap = welcomeCardHeight / 3;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "HerCare",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        actions: [
          // 👇 LOGIN / LOGOUT button based on user status
          TextButton(
            onPressed: () {
              if (userEmail != null) {
                _logout(context);
              } else {
                Navigator.pushNamed(context, '/signup');
              }
            },
            child: Text(
              userEmail != null ? 'Logout' : 'Sign In',
              style: GoogleFonts.poppins(
                  color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.settings_rounded, color: Colors.white, size: 28),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWavyHeaderBackground(headerHeight),
            Transform.translate(
              offset: const Offset(0.0, -overlap),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWelcomeCard(context),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
                    child: Text(
                      "Choose Your Focus Today",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: kAppBarTextColor),
                    ),
                  ),
                  _buildFeatureGrid(context),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Track doctor search in history
          HistoryManager().addHistory(
            'Find a Doctor',
            '👩‍⚕️',
            'Healthcare',
          );
          // Navigate to doctors tab or page
          // You can implement this based on your navigation structure
        },
        backgroundColor: kPrimaryDarkPink,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Find a Doctor",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildWavyHeaderBackground(double height) {
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        height: height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [kPrimaryLightPink, kPrimaryDarkPink],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
          color: kWhiteCardColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15,
                offset: const Offset(0, 5)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome to HerCare 💖",
                style: GoogleFonts.poppins(
                    color: kAppBarTextColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(
                userEmail != null
                    ? "Logged in as $userEmail"
                    : "Your companion for complete wellness.",
                style: GoogleFonts.poppins(
                    color: Colors.grey[600], fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.0,
        ),
        itemCount: landingFeatures.length,
        itemBuilder: (context, index) {
          final feature = landingFeatures[index];
          return _buildFeatureCard(context, feature);
        },
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, Map<String, dynamic> feature) {
    return GestureDetector(
      onTap: () => _onFeatureTap(feature, context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: feature['color'] as Color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: (feature['color'] as Color).withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(feature['icon'] as IconData, color: Colors.white, size: 48),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(feature['title'] as String,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white)),
                const SizedBox(height: 4),
                Text(feature['subtitle'] as String,
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: Colors.white70),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Wave clipper remains same
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    var firstControlPoint = Offset(size.width * 0.25, size.height - 50);
    var firstEndPoint = Offset(size.width * 0.5, size.height - 20);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width * 0.75, size.height + 10);
    var secondEndPoint = Offset(size.width, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}