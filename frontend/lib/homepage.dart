import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';  // 👈 Import for color constants like kPrimaryDarkPink etc.

// Feature Card Colors
const Color kCardPeriodRed = Color(0xFFD84A62);
const Color kCardPregnancyOrange = Color(0xFFF58461);
const Color kCardMentalTeal = Color(0xFF63C2C0);
const Color kCardBreastRed = Color(0xFFDA566E);
const Color kCardGamesPurple = Color(0xFF8B64CC);
const Color kCardPodcastBlue = Color(0xFF5CA6D6);

class HerCareHomePage extends StatelessWidget {
  const HerCareHomePage({super.key});

  final List<Map<String, dynamic>> landingFeatures = const [
    {'title': 'Period Tracker', 'subtitle': 'Track your cycle status', 'icon': Icons.calendar_today_rounded, 'color': kCardPeriodRed},
    {'title': 'Pregnancy Tracker', 'subtitle': 'Monitor growth, week by week.', 'icon': Icons.pregnant_woman_rounded, 'color': kCardPregnancyOrange},
    {'title': 'Mental Health', 'subtitle': 'Meditations, journal & support', 'icon': Icons.self_improvement_rounded, 'color': kCardMentalTeal},
    {'title': 'Breast Health Check', 'subtitle': 'Self-exam guide & detection', 'icon': Icons.visibility_rounded, 'color': kCardBreastRed},
    {'title': 'Podcasts', 'subtitle': 'Listen to expert wellness adv...', 'icon': Icons.mic_external_on_rounded, 'color': kCardPodcastBlue},
  ];

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
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/signup'); // Navigate to the SignUp screen
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
            feature['color'] as Color,
          );
        },
      ),
    );
  }

  Widget _buildFeatureCard(
      BuildContext context,
      String title,
      String subtitle,
      IconData icon,
      Color color,
      ) {
    return GestureDetector(
      onTap: () {
        if (title == 'Period Tracker') {
          Navigator.pushNamed(context, '/period');   // ✅ Navigate to Period Tracker
        }

        // Later, you can add similar conditions:
        else if (title == 'Pregnancy Tracker') {
          Navigator.pushNamed(context, '/pregnancy');
        }
        else if (title == 'Breast Health Check') {
          Navigator.pushNamed(context, '/breast');
        }
        else if (title == 'Mental Health') {
          Navigator.pushNamed(context, '/mental');
        }
        else if (title == 'Podcasts') {
          Navigator.pushNamed(context, '/podcast');
        }

      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
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
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Wave clipper
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

