import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';                  // Home / dashboard
import 'period_tracker_page.dart';
import 'breast_cancer.dart';// Your PeriodTrackerPage
import 'pregnancy.dart';
import 'mentalhealth.dart';
import 'podcast.dart';
import 'signup.dart';
import 'history/history_page.dart'; // Add this import

// --- Theme Colors ---
const Color kPrimaryDarkPink = Color(0xFFE9386D);
const Color kPrimaryLightPink = Color(0xFFF794B2);
const Color kBackgroundColor = Color(0xFFFFFAFD);
const Color kAppBarTextColor = Color(0xFF4A4A4A);
const Color kWhiteCardColor = Color(0xFFFFFFFF);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final savedEmail = prefs.getString('userEmail');

  print("🔍 Startup — Found saved email: $savedEmail");

  runApp(HerCareApp(isLoggedIn: savedEmail != null));
}

class HerCareApp extends StatelessWidget {
  final bool isLoggedIn;
  const HerCareApp({super.key, required this.isLoggedIn});

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
          surface: kBackgroundColor,
        ),
      ),
      routes: {
        // ❌ REMOVE this line: '/': (context) => isLoggedIn ? const MainNavigatorScreen() : const SignUpScreen(),
        '/period': (context) => PeriodTrackerPage(),
        '/breast': (context) => BreastCancerCheckApp(),
        '/pregnancy': (context) => PregnancyApp(),
        '/mental': (context) => MentalHealthScreen(),
        '/podcast': (context) => PodcastScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/history': (context) => const HistoryPage(),
      },
      // ✅ Keep only the home property
      home: isLoggedIn ? const MainNavigatorScreen() : const SignUpScreen(),
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

  // Updated to include History page
  final List<Widget> _widgetOptions = <Widget>[
    const HerCareHomePage(),
    const Center(
      child: Text(
        'Recommended Doctors Screen (Coming Soon)',
        style: TextStyle(color: kAppBarTextColor),
      ),
    ),
    const HistoryPage(), // Add History as the third tab
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.medical_services_rounded), label: 'Doctors'),
          BottomNavigationBarItem(icon: Icon(Icons.history_rounded), label: 'History'), // Add History tab
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryDarkPink,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}