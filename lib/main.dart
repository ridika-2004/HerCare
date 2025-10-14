import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Theme Colors for HerCare (Approximated from your screenshots) ---
const Color kPrimaryDarkPink = Color(0xFFE9386D); 
const Color kPrimaryLightPink = Color(0xFFF794B2); 
const Color kBackgroundColor = Color(0xFFFFFAFD); // Very light pink background
const Color kAppBarTextColor = Color(0xFF4A4A4A);
const Color kWhiteCardColor = Color(0xFFFFFFFF); // Use this for the greeting card

// Feature Card Colors (from Landing Page image)
const Color kCardPeriodRed = Color(0xFFD84A62);
const Color kCardPregnancyOrange = Color(0xFFF58461);
const Color kCardMentalTeal = Color(0xFF63C2C0);
const Color kCardBreastRed = Color(0xFFDA566E);
const Color kCardGamesPurple = Color(0xFF8B64CC);
const Color kCardPodcastBlue = Color(0xFF5CA6D6);

void main() {
  runApp(const HerCareApp());
}

class HerCareApp extends StatelessWidget {
  const HerCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HerCare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.poppins().fontFamily,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink).copyWith(
          primary: kPrimaryDarkPink,
          secondary: kPrimaryDarkPink,
          background: kBackgroundColor,
        ),
      ),
      home: const MainNavigatorScreen(),
    );
  }
}

class MainNavigatorScreen extends StatefulWidget {
  const MainNavigatorScreen({super.key});

  @override
  State<MainNavigatorScreen> createState() => _MainNavigatorScreenState();
}

class _MainNavigatorScreenState extends State<MainNavigatorScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = const <Widget>[
    HerCareHomePage(),
    Center(child: Text('Period Tracker Screen (Coming Soon)', style: TextStyle(color: kAppBarTextColor))), 
    Center(child: Text('Recommended Doctors Screen (Coming Soon)', style: TextStyle(color: kAppBarTextColor))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today_rounded), label: 'Tracker'),
          BottomNavigationBarItem(icon: Icon(Icons.medical_services_rounded), label: 'Doctors'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryDarkPink,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

// ====================================================================
// 1. LANDING PAGE (HerCareHomePage)
// ====================================================================

class HerCareHomePage extends StatelessWidget {
  const HerCareHomePage({super.key});

  final List<Map<String, dynamic>> landingFeatures = const [
    {'title': 'Period Tracker', 'subtitle': 'Track your cycle status', 'icon': Icons.calendar_today_rounded, 'color': kCardPeriodRed},
    {'title': 'Pregnancy Tracker', 'subtitle': 'Monitor growth, week by week.', 'icon': Icons.pregnant_woman_rounded, 'color': kCardPregnancyOrange},
    {'title': 'Mental Health', 'subtitle': 'Meditations, journal & support', 'icon': Icons.self_improvement_rounded, 'color': kCardMentalTeal},
    {'title': 'Breast Health Check', 'subtitle': 'Self-exam guide & detection', 'icon': Icons.visibility_rounded, 'color': kCardBreastRed},
    {'title': 'Fun & Games', 'subtitle': 'Quizzes, puzzles & more', 'icon': Icons.gamepad_rounded, 'color': kCardGamesPurple},
    {'title': 'Podcasts', 'subtitle': 'Listen to expert wellness adv...', 'icon': Icons.mic_external_on_rounded, 'color': kCardPodcastBlue},
  ];

  @override
  Widget build(BuildContext context) {
    // Determine the height of the safe area and app bar combined
    final double topAreaHeight = MediaQuery.of(context).padding.top + kToolbarHeight;
    // Define the height of the wavy header section
    const double headerHeight = 250.0; 
    // Define the height of the white "Welcome" card
    const double welcomeCardHeight = 150.0;
    // Calculate the amount the welcome card overlaps the grid below it
    const double overlap = welcomeCardHeight / 3; 

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              print("Sign In pressed");
            },
            child: Text(
              'Sign In', 
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
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
            // 1. Wavy Pink Header (This now defines the background area)
            _buildWavyHeaderBackground(headerHeight),
            
            // 2. The area where the Welcome Card and the rest of the content lives
            Transform.translate(
              // Move this section upwards to overlap with the header
              offset: Offset(0.0, -overlap),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // White "Welcome" Card (Outside the wave, positioned just below the wave's dip)
                  _buildWelcomeCard(context),

                  // 🌟 Main Feature Grid
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
                    child: Text(
                      "Choose Your Focus Today",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: kAppBarTextColor),
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
        onPressed: () {},
        backgroundColor: kPrimaryDarkPink,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Find a Doctor extended", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  
  // New method for the Wavy Pink Background
  Widget _buildWavyHeaderBackground(double height) {
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        height: height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [kPrimaryLightPink, kPrimaryDarkPink], 
            begin: Alignment.topCenter, 
            end: Alignment.bottomCenter
          ),
        ),
      ),
    );
  }

  // New method for the White Greeting Card
  Widget _buildWelcomeCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
          color: kWhiteCardColor,
          borderRadius: BorderRadius.circular(30), 
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome to HerCare 💖", style: GoogleFonts.poppins(color: kAppBarTextColor, fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text("Your companion for complete wellness.", style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 16)),
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
          return _buildFeatureCard(
            context, 
            feature['title'] as String, 
            feature['subtitle'] as String, 
            feature['icon'] as IconData, 
            feature['color'] as Color
          );
        },
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, String subtitle, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color, 
        borderRadius: BorderRadius.circular(20), 
        boxShadow: [
          BoxShadow(color: color.withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
        children: [
          Icon(icon, color: Colors.white, size: 48),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 4),
              Text(subtitle, style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70), maxLines: 2, overflow: TextOverflow.ellipsis),
            ],
          ),
        ],
      ),
    );
  }
}

// CustomClipper to create the wavy effect
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height); // Start at bottom-left corner

    // First wave (upwards curve)
    var firstControlPoint = Offset(size.width * 0.25, size.height - 50);
    var firstEndPoint = Offset(size.width * 0.5, size.height - 20);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    // Second wave (downwards curve)
    var secondControlPoint = Offset(size.width * 0.75, size.height + 10);
    var secondEndPoint = Offset(size.width, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0); // Connect to top right
    path.lineTo(0, 0); // Connect to top left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}