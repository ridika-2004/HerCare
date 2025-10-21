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
import 'constants/colors.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load user preferences and email
  final prefs = await SharedPreferences.getInstance();
  final savedEmail = prefs.getString('userEmail');
  final isLoggedIn = savedEmail != null && savedEmail.isNotEmpty;

  print("🔍 Startup — Found saved email: $savedEmail");
  print("🔍 Startup — User is logged in: $isLoggedIn");

  // Initialize StorageService with user email
  if (isLoggedIn) {
    await StorageService.loadUserEmail();
  }

  runApp(HerCareApp(isLoggedIn: isLoggedIn));
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
        style: TextStyle(color: kAppBarTextColor),
      ),
    ),
    const HistoryPage(),
  ];

  // Add logout functionality
  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userEmail');
    await prefs.setBool('isLoggedIn', false);
    await StorageService.clearData();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HerCare',
          style: GoogleFonts.poppins(
            color: kAppBarTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: kBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: kPrimaryDarkPink),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.medical_services_rounded), label: 'Doctors'),
          BottomNavigationBarItem(icon: Icon(Icons.history_rounded), label: 'History'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryDarkPink,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}