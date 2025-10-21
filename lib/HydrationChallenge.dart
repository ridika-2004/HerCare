import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants/colors.dart';

// Theme Colors (Consistent with MentalHealth.dart)

// ====================================================================
// HYDRATION CHALLENGE SCREEN - Daily Water Intake Tracker
// Girlish, Wellness Theme with Bangladeshi Context
// ====================================================================

class HydrationChallengeScreen extends StatefulWidget {
  const HydrationChallengeScreen({super.key});

  @override
  State<HydrationChallengeScreen> createState() => _HydrationChallengeScreenState();
}

class _HydrationChallengeScreenState extends State<HydrationChallengeScreen> {
  final int _dailyGoal = 8; // 8 glasses (~2 liters) as a common hydration goal
  int _glassesDrunk = 0; // Current number of glasses consumed
  final List<Map<String, dynamic>> _intakeLog = []; // Log of water intake with timestamps
  double _progress = 0.0; // Progress towards daily goal

  // Log a glass of water and update progress
  void _logWaterIntake() {
    setState(() {
      _glassesDrunk++;
      _progress = _glassesDrunk / _dailyGoal;
      final now = DateTime.now();
      _intakeLog.add({
        'amount': '1 glass (~250ml)',
        'time': '${now.hour % 12}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}',
      });
      if (_progress >= 1.0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Yay, you hit your hydration goal, queen! 🎉',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            backgroundColor: kPrimaryDarkPink,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    });
  }

  // Reset daily progress with confirmation
  void _resetProgress() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kBackgroundColor,
          title: Text(
            'Reset Hydration',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kAppBarTextColor,
            ),
          ),
          content: Text(
            'Are you sure you want to reset your hydration progress?',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: kAppBarTextColor.withOpacity(0.7),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(color: kAppBarTextColor),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _glassesDrunk = 0;
                  _progress = 0.0;
                  _intakeLog.clear();
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Hydration progress reset successfully',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                    backgroundColor: kPrimaryDarkPink,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryDarkPink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Reset',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  // Get motivational message based on progress
  String _getMotivationalMessage() {
    if (_glassesDrunk == 0) {
      return 'Start sipping, queen! Your body loves water! 💖';
    } else if (_glassesDrunk < 4) {
      return 'Great job! Keep drinking to glow from within! ✨';
    } else if (_glassesDrunk < 8) {
      return 'You’re almost there! Stay hydrated, superstar! 🌟';
    } else {
      return 'Wow, you’re a hydration pro! Keep shining! 💧';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Hydration Challenge 💧',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: kPrimaryDarkPink,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gradient Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [kPrimaryLightPink, kPrimaryDarkPink],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.water_drop, color: Colors.white, size: 30),
                        const SizedBox(width: 10),
                        Text(
                          'Stay Hydrated, Queen!',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(Icons.favorite, color: Colors.white, size: 30),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Drink 8 glasses (~2L) daily for a happy, healthy you! 💖',
                      style: GoogleFonts.poppins(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Progress Indicator
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: CircularProgressIndicator(
                        value: _progress,
                        strokeWidth: 10,
                        backgroundColor: kPrimaryLightPink,
                        valueColor: const AlwaysStoppedAnimation<Color>(kCardPodcastBlue),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          '$_glassesDrunk / $_dailyGoal',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: kAppBarTextColor,
                          ),
                        ),
                        Text(
                          'Glasses',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: kAppBarTextColor.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Motivational Message
              Center(
                child: Text(
                  _getMotivationalMessage(),
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: kAppBarTextColor.withOpacity(0.8),
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),

              // Log Water Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: _logWaterIntake,
                  icon: const Icon(Icons.local_drink, size: 24, color: Colors.white),
                  label: Text(
                    'Log 1 Glass (~250ml)',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kCardPodcastBlue,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 5,
                    shadowColor: kCardPodcastBlue.withOpacity(0.4),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Reset Button
              Center(
                child: OutlinedButton.icon(
                  onPressed: _resetProgress,
                  icon: const Icon(Icons.refresh, size: 24, color: kPrimaryDarkPink),
                  label: Text(
                    'Reset Progress',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: kPrimaryDarkPink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: kPrimaryDarkPink, width: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Intake Log
              if (_intakeLog.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: kWhiteCardColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.history, size: 20, color: kPrimaryDarkPink),
                          const SizedBox(width: 8),
                          Text(
                            'Your Hydration Log 📝',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kAppBarTextColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ..._intakeLog.map((log) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                Icon(Icons.water_drop, size: 16, color: kCardPodcastBlue),
                                const SizedBox(width: 8),
                                Text(
                                  '${log['amount']} at ${log['time']}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: kAppBarTextColor.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              const SizedBox(height: 20),

              // Hydration Tips for Bangladeshi Context
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: kWhiteCardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lightbulb_outline, size: 20, color: kPrimaryDarkPink),
                        const SizedBox(width: 8),
                        Text(
                          'Hydration Tips for You 💡',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kAppBarTextColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ...[
                      'Use boiled or filtered water to stay safe 💧',
                      'Add a slice of lemon or cucumber for flavor 🍋',
                      'Carry a reusable bottle for on-the-go hydration 🌍',
                      'Sip water during meals to aid digestion 🍽️',
                      'Set reminders to drink every 1-2 hours ⏰',
                    ].map((tip) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              Icon(Icons.circle, size: 6, color: kPrimaryDarkPink),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  tip,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: kAppBarTextColor.withOpacity(0.9),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}