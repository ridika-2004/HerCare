import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home/homepage.dart';
import 'period_tracker_page.dart';
import 'breast_cancer.dart';
import 'pregnancy.dart';
import 'mentalhealth.dart';
import 'podcast.dart';
import 'signup.dart';
import 'history/history_page.dart';
import 'constants/colors.dart'; // Add this import

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
          primary: kPrimaryDarkPink, // Now from constants/colors.dart
          secondary: kPrimaryDarkPink,
          surface: kBackgroundColor,
        ),
      ),
      routes: {
        '/period': (context) => PeriodTrackerPage(),
        '/breast': (context) => BreastCancerCheckApp(),
        '/pregnancy': (context) => PregnancyApp(),
        '/mental': (context) => MentalHealthScreen(),
        '/podcast': (context) => PodcastScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/history': (context) => const HistoryPage(),
      },
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

  final List<Widget> _widgetOptions = <Widget>[
    const HerCareHomePage(),
    const Center(
      child: Text(
        'Recommended Doctors Screen (Coming Soon)',
        style: TextStyle(color: kAppBarTextColor), // Now from constants/colors.dart
      ),
    ),
    const HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.medical_services_rounded), label: 'Doctors'),
          BottomNavigationBarItem(icon: Icon(Icons.history_rounded), label: 'History'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryDarkPink, // Now from constants/colors.dart
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}