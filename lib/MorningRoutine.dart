import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'constants/colors.dart';

// Theme Colors (Duplicated to ensure independence)


// ====================================================================
// 5-MINUTE MORNING CALM EXERCISE SCREEN
// Provides a guided 5-minute morning calm exercise with step-by-step instructions,
// a countdown timer, and optional background calming audio.
// ====================================================================

class FiveMinuteMorningCalmScreen extends StatefulWidget {
  const FiveMinuteMorningCalmScreen({super.key});

  @override
  State<FiveMinuteMorningCalmScreen> createState() => _FiveMinuteMorningCalmScreenState();
}

class _FiveMinuteMorningCalmScreenState extends State<FiveMinuteMorningCalmScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Timer? _timer;
  int _remainingTime = 300; // 5 minutes in seconds
  bool _isRunning = false;
  int _currentStep = 0;

  // Step-by-step instructions for the 5-minute exercise
  final List<Map<String, dynamic>> _steps = [
    {
      'title': 'Step 1: Find a Comfortable Position',
      'description': 'Sit or lie down in a quiet place. Close your eyes gently and relax your body.',
      'duration': 30, // seconds
    },
    {
      'title': 'Step 2: Deep Breathing',
      'description': 'Inhale deeply through your nose for 4 counts, hold for 4, exhale through your mouth for 4. Repeat.',
      'duration': 60,
    },
    {
      'title': 'Step 3: Body Scan',
      'description': 'Starting from your toes, mentally scan your body up to your head, releasing tension in each area.',
      'duration': 120,
    },
    {
      'title': 'Step 4: Positive Affirmations',
      'description': 'Repeat silently: "I am calm, I am strong, today is a good day." Feel the words resonate.',
      'duration': 60,
    },
    {
      'title': 'Step 5: Gentle Awakening',
      'description': 'Wiggle your fingers and toes, open your eyes slowly, and stretch gently.',
      'duration': 30,
    },
  ];

  @override
  void initState() {
    super.initState();
    // Preload audio
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _startExercise() {
    if (_isRunning) return;
    setState(() {
      _isRunning = true;
      _currentStep = 0;
      _remainingTime = _steps.fold(0, (sum, step) => sum + (step['duration'] as int));
    });

    // Play background calming audio
    _audioPlayer.play(UrlSource('https://cdn.pixabay.com/audio/2022/08/02/audio_d2b76c6e95.mp3')); // Calm nature sounds

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
          _updateCurrentStep();
        });
      } else {
        _stopExercise();
      }
    });
  }

  void _pauseExercise() {
    if (!_isRunning) return;
    _timer?.cancel();
    _audioPlayer.pause();
    setState(() {
      _isRunning = false;
    });
  }

  void _stopExercise() {
    _timer?.cancel();
    _audioPlayer.stop();
    setState(() {
      _isRunning = false;
      _remainingTime = 300;
      _currentStep = 0;
    });
  }

  void _updateCurrentStep() {
    int elapsed = 300 - _remainingTime;
    int cumulative = 0;
    for (int i = 0; i < _steps.length; i++) {
      cumulative += _steps[i]['duration'] as int;
      if (elapsed < cumulative) {
        _currentStep = i;
        return;
      }
    }
    _currentStep = _steps.length - 1;
  }

  String _formatTime(int seconds) {
    int min = seconds ~/ 60;
    int sec = seconds % 60;
    return '$min:${sec.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 234, 247),
      appBar: AppBar(
        title: Text('5-Min Morning Calm', style: GoogleFonts.poppins(color: kAppBarTextColor, fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 240, 180, 215),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 171, 4, 91)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Timer Display
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 249, 222, 238).withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Text(
                _formatTime(_remainingTime),
                style: GoogleFonts.poppins(fontSize: 48, fontWeight: FontWeight.bold, color: kPrimaryDarkPink),
              ),
            ),
            const SizedBox(height: 30),
            // Current Step
            if (_currentStep < _steps.length)
              Card(
                color: kWhiteCardColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _steps[_currentStep]['title'] as String,
                        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: kAppBarTextColor),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _steps[_currentStep]['description'] as String,
                        style: GoogleFonts.poppins(fontSize: 16, color: kAppBarTextColor.withOpacity(0.8)),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 30),
            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow, color: Colors.white),
                  label: Text(_isRunning ? 'Pause' : 'Start'),
                  onPressed: _isRunning ? _pauseExercise : _startExercise,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryDarkPink,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                const SizedBox(width: 20),
                if (_isRunning || _remainingTime < 300)
                  ElevatedButton.icon(
                    icon: const Icon(Icons.stop, color: Colors.white),
                    label: const Text('Stop'),
                    onPressed: _stopExercise,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 229, 242),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 40),
            // All Steps List (for reference)
            Text(
              'Full Step-by-Step Guide',
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: kAppBarTextColor),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _steps.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 84, 10, 53),
                    child: Text('${index + 1}', style: const TextStyle(color: Colors.white)),
                  ),
                  title: Text(_steps[index]['title'] as String, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                  subtitle: Text(_steps[index]['description'] as String),
                  trailing: Text('${_steps[index]['duration']}s', style: const TextStyle(color: Color.fromARGB(255, 241, 210, 226))),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}