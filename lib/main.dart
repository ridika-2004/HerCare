import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'homepage.dart';                  // Home / dashboard
import 'period_tracker_page.dart';
import 'breast_cancer.dart';// Your PeriodTrackerPage
import 'pregnancy.dart';
import 'mentalhealth.dart';
import 'podcast.dart';
import 'signup.dart';

// --- Theme Colors ---
const Color kPrimaryDarkPink = Color(0xFFE9386D);
const Color kPrimaryLightPink = Color(0xFFF794B2);
const Color kBackgroundColor = Color(0xFFFFFAFD);
const Color kAppBarTextColor = Color(0xFF4A4A4A);
const Color kWhiteCardColor = Color(0xFFFFFFFF);

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
          surface: kBackgroundColor,
        ),
      ),
      // Route so the home card can do: Navigator.pushNamed(context, '/period')
      routes: {
        '/period': (context) => PeriodTrackerPage(),
        '/breast': (context) =>BreastCancerCheckApp(),
        '/pregnancy': (context) =>PregnancyApp(),
        '/mental': (context) =>MentalHealthScreen(),
        '/podcast': (context) => PodcastScreen(),
        '/signup': (context) => SignUpScreen(),
      },
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

  // ⚠️ Not const, because PeriodTrackerPage() is a StatefulWidget.
  final List<Widget> _widgetOptions = <Widget>[
    const HerCareHomePage(),
    PeriodTrackerPage(), // real Tracker tab
    const Center(
      child: Text(
        'Recommended Doctors Screen (Coming Soon)',
        style: TextStyle(color: kAppBarTextColor),
      ),
    ),
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
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
