import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'MorningRoutine.dart'; // Ensure MorningRoutine.dart contains FiveMinuteMorningCalmScreen
import 'SleepStories.dart'; // Ensure SleepStories.dart contains SleepStoriesScreen
import 'package:url_launcher/url_launcher.dart';
import 'constants/colors.dart';

// --- Theme Colors (Defined Locally for independence) ---

// ====================================================================
// MENTAL HEALTH SCREEN (With Conditional Custom Fields and Dynamic Music)
// ====================================================================

class MentalHealthScreen extends StatefulWidget {
  const MentalHealthScreen({super.key});

  @override
  State<MentalHealthScreen> createState() => _MentalHealthScreenState();
}

class _MentalHealthScreenState extends State<MentalHealthScreen> {
  String _selectedCategory = 'Meditation';
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentlyPlayingUrl; // Track the currently playing music URL
  bool _isPlaying = false; // Track play/pause state

  // Data structure including a placeholder for the "Add Custom" card in EACH list
  final Map<String, List<Map<String, dynamic>>> contentData = {
    'Meditation': [
      {
        'title': '5-Min Morning Calm',
        'subtitle': 'Mindfulness',
        'icon': Icons.self_improvement_rounded,
        'color': kCardMentalTeal
      },
      {
        'title': 'Sleep Stories',
        'subtitle': 'Bedtime Relaxation',
        'icon': Icons.nights_stay_rounded,
        'color': kCardGamesPurple
      },
      {
        'title': 'Anxiety Relief',
        'subtitle': 'Quick Session',
        'icon': Icons.spa_rounded,
        'color': kPrimaryDarkPink
      },
      {'isCustomAdd': true, 'category': 'Meditation'},
    ],
    'Music': [
      {
        'title': 'Focus Beats',
        'subtitle': 'Concentration',
        'icon': Icons.music_note_rounded,
        'color': kCardPodcastBlue,
        'audioUrl': 'https://cdn.pixabay.com/audio/2023/08/08/audio_b8e5865df1.mp3',
      },
      {
        'title': 'Soothing Piano',
        'subtitle': 'Relaxation',
        'icon': Icons.piano_rounded,
        'color': kCardPeriodRed,
        'audioUrl': 'https://cdn.pixabay.com/audio/2023/03/28/audio_6e5bece4f6.mp3',
      },
      {
        'title': 'Calm Nature Sounds',
        'subtitle': 'Ambient',
        'icon': Icons.forest_rounded,
        'color': kCardMentalTeal.withOpacity(0.8),
        'audioUrl': 'https://cdn.pixabay.com/audio/2022/08/02/audio_d2b76c6e95.mp3',
      },
      {'isCustomAdd': true, 'category': 'Music'},
    ],
    'Exercise': [
      {
        'title': 'Gentle Yoga Flow',
        'subtitle': 'Stress release',
        'icon': Icons.accessibility_new_rounded,
        'color': kCardPregnancyOrange
      },
      {
        'title': 'Walking Trails',
        'subtitle': 'Outdoor activity',
        'icon': Icons.directions_walk_rounded,
        'color': const Color.fromARGB(255, 195, 104, 133)
      },
      {
        'title': 'Desk Stretches',
        'subtitle': 'Quick break',
        'icon': Icons.chair_rounded,
        'color': kCardGamesPurple.withOpacity(0.9)
      },
      {'isCustomAdd': true, 'category': 'Exercise'},
    ],
    'Diet': [
      {
        'title': 'Mood-Boosting Foods',
        'subtitle': 'Nutrition tips',
        'icon': Icons.local_dining_rounded,
        'color': kCardBreastRed
      },
      {
        'title': 'Hydration Challenge',
        'subtitle': 'Water intake',
        'icon': Icons.water_drop_rounded,
        'color': kCardPodcastBlue.withOpacity(0.7)
      },
      {
        'title': 'Gut Health Basics',
        'subtitle': 'Wellness connection',
        'icon': Icons.healing_rounded,
        'color': kCardPeriodRed
      },
      {'isCustomAdd': true, 'category': 'Diet'},
    ],
    'Travel / Tours': [
      {
        'title': 'Virtual Nature Walk',
        'subtitle': 'Forest sounds',
        'icon': Icons.terrain_rounded,
        'color': kCardMentalTeal
      },
      {
        'title': 'Visual Relaxation',
        'subtitle': 'Ocean view',
        'icon': Icons.beach_access_rounded,
        'color': kCardPregnancyOrange
      },
      {'isCustomAdd': true, 'category': 'Travel / Tours'},
    ],
  };

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // Play or pause audio for a given URL
  Future<void> _toggleAudio(String audioUrl) async {
    try {
      if (_currentlyPlayingUrl == audioUrl && _isPlaying) {
        await _audioPlayer.pause();
        setState(() {
          _isPlaying = false;
        });
      } else {
        if (_currentlyPlayingUrl != audioUrl) {
          await _audioPlayer.stop();
          await _audioPlayer.play(UrlSource(audioUrl));
        } else {
          await _audioPlayer.resume();
        }
        setState(() {
          _currentlyPlayingUrl = audioUrl;
          _isPlaying = true;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error playing audio')),
      );
    }
  }

  // Launch URL for external services
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  // Custom input fields builder
  List<Widget> _buildCustomFields(String category) {
    List<Widget> fields = [
      TextFormField(
        decoration: const InputDecoration(labelText: 'Title'),
        onChanged: (value) => _customTitle = value,
      ),
      TextFormField(
        decoration: const InputDecoration(labelText: 'Description/Notes'),
        onChanged: (value) => _customSubtitle = value,
      ),
      const SizedBox(height: 15),
    ];

    switch (category) {
      case 'Music':
        fields.add(
          TextFormField(
            decoration: const InputDecoration(labelText: 'Audio URL (e.g., MP3 link)'),
            onChanged: (value) => _customAudioUrl = value,
          ),
        );
        break;
      case 'Travel / Tours':
        fields.add(
          TextFormField(
            decoration: const InputDecoration(labelText: 'Supporting Link'),
            onChanged: (value) => _customLink = value,
          ),
        );
        break;
      case 'Meditation':
        fields.add(
          TextFormField(
            decoration: const InputDecoration(labelText: 'Supporting Link (Optional)'),
            onChanged: (value) => _customLink = value,
          ),
        );
        fields.add(
          OutlinedButton.icon(
            icon: const Icon(Icons.camera_alt_rounded, color: kPrimaryDarkPink),
            label: const Text('Upload Image (Optional)',
                style: TextStyle(color: kPrimaryDarkPink)),
            onPressed: () {
              // Placeholder for image upload logic
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: kPrimaryLightPink),
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        );
        break;
      case 'Exercise':
      case 'Diet':
        fields.add(
          TextFormField(
            decoration: const InputDecoration(labelText: 'Source/Reference (Optional)'),
            onChanged: (value) => _customLink = value,
          ),
        );
        break;
    }
    return fields;
  }

  // Variables to store custom input
  String _customTitle = '';
  String _customSubtitle = '';
  String _customAudioUrl = '';
  String _customLink = '';

  // Updated function for custom addition dialog
  void _showCustomAddDialog(String category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Custom $category Idea",
              style: GoogleFonts.poppins(color: kAppBarTextColor)),
          content: SingleChildScrollView(
            child: ListBody(
              children: _buildCustomFields(category),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel',
                  style: TextStyle(color: kAppBarTextColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save',
                  style: TextStyle(
                      color: kPrimaryDarkPink, fontWeight: FontWeight.bold)),
              onPressed: () {
                if (_customTitle.isNotEmpty && _customSubtitle.isNotEmpty) {
                  if (category == 'Music' && _customAudioUrl.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Audio URL is required for Music')),
                    );
                    return;
                  }

                  IconData customIcon = Icons.help_outline; // Default icon
                  Color customColor = kPrimaryDarkPink; // Default color

                  // Choose icon and color based on category
                  switch (category) {
                    case 'Meditation':
                      customIcon = Icons.self_improvement_rounded;
                      customColor = kCardMentalTeal;
                      break;
                    case 'Music':
                      customIcon = Icons.music_note_rounded;
                      customColor = kCardPodcastBlue;
                      break;
                    case 'Exercise':
                      customIcon = Icons.accessibility_new_rounded;
                      customColor = kCardPregnancyOrange;
                      break;
                    case 'Diet':
                      customIcon = Icons.local_dining_rounded;
                      customColor = kCardBreastRed;
                      break;
                    case 'Travel / Tours':
                      customIcon = Icons.terrain_rounded;
                      customColor = kCardMentalTeal;
                      break;
                  }

                  final newItem = {
                    'title': _customTitle,
                    'subtitle': _customSubtitle,
                    'icon': customIcon,
                    'color': customColor,
                  };

                  if (category == 'Music') {
                    newItem['audioUrl'] = _customAudioUrl;
                  }
                  if (category == 'Travel / Tours' ||
                      category == 'Exercise' ||
                      category == 'Diet' ||
                      category == 'Meditation') {
                    newItem['link'] = _customLink;
                  }

                  setState(() {
                    contentData[category]!.insert(contentData[category]!.length - 1, newItem);
                  });
                  Navigator.of(context).pop();
                  _customTitle = '';
                  _customSubtitle = '';
                  _customAudioUrl = '';
                  _customLink = '';
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all required fields')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kAppBarTextColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Mental Health Hub',
            style: GoogleFonts.poppins(
                color: kAppBarTextColor, fontWeight: FontWeight.bold)),
        backgroundColor: kBackgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: kAppBarTextColor),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategorySegmentedControl(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(_selectedCategory,
                        style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: kAppBarTextColor)),
                  ),
                  const SizedBox(height: 15),
                  _buildHorizontalContentList(contentData[_selectedCategory] ?? []),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the horizontal scrolling bar for category selection.
  Widget _buildCategorySegmentedControl() {
    return Container(
      height: 50,
      color: kSectionGrey,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: contentData.keys.map((category) {
          bool isSelected = _selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                  if (_isPlaying) {
                    _audioPlayer.stop();
                    _isPlaying = false;
                    _currentlyPlayingUrl = null;
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? kPrimaryDarkPink : kWhiteCardColor,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                      color: isSelected ? kPrimaryDarkPink : Colors.grey.shade300),
                ),
                child: Center(
                  child: Text(
                    category,
                    style: GoogleFonts.poppins(
                      color: isSelected ? kWhiteCardColor : kAppBarTextColor,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// Builds the horizontal scrolling list of content cards.
  Widget _buildHorizontalContentList(List<Map<String, dynamic>> contentList) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        itemCount: contentList.length,
        itemBuilder: (context, index) {
          final content = contentList[index];
          return Padding(
            padding: EdgeInsets.only(right: index == contentList.length - 1 ? 0 : 16.0),
            child: content.containsKey('isCustomAdd') && content['isCustomAdd'] == true
                ? _buildCustomAddCard(content['category'] as String)
                : _buildContentCard(content),
          );
        },
      ),
    );
  }

  /// Builds the special "Add Custom" content card.
  Widget _buildCustomAddCard(String category) {
    return GestureDetector(
      onTap: () => _showCustomAddDialog(category),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kSectionGrey,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: kPrimaryLightPink, width: 3, style: BorderStyle.solid),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: kPrimaryDarkPink.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add_circle_outline_rounded,
                  color: kPrimaryDarkPink, size: 36),
            ),
            const SizedBox(height: 10),
            Text(
              "Add Custom",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: kPrimaryDarkPink),
              textAlign: TextAlign.center,
            ),
            Text(
              category,
              style: GoogleFonts.poppins(
                  fontSize: 12, color: kAppBarTextColor.withOpacity(0.7)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds an individual content card.
  Widget _buildContentCard(Map<String, dynamic> content) {
    final isMusicCategory = _selectedCategory == 'Music';
    final isPlayingThis =
        isMusicCategory && _currentlyPlayingUrl == content['audioUrl'] && _isPlaying;

    return Container(
      width: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: content['color'] as Color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: (content['color'] as Color).withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kWhiteCardColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(content['icon'] as IconData, color: Colors.white, size: 36),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                content['title'] as String,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                content['subtitle'] as String,
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              if (isMusicCategory)
                GestureDetector(
                  onTap: () => _toggleAudio(content['audioUrl'] as String),
                  child: Row(
                    children: [
                      Icon(
                        isPlayingThis
                            ? Icons.pause_circle_filled_rounded
                            : Icons.play_circle_filled_rounded,
                        color: kWhiteCardColor,
                        size: 24,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        isPlayingThis ? 'Pause' : 'Play Now',
                        style: GoogleFonts.poppins(
                            color: kWhiteCardColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ],
                  ),
                )
              else
                GestureDetector(
                  onTap: () {
                    if (_isPlaying) {
                      _audioPlayer.stop();
                      _isPlaying = false;
                      _currentlyPlayingUrl = null;
                    }
                    if (content['title'] == '5-Min Morning Calm') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FiveMinuteMorningCalmScreen()),
                      );
                    } else if (content['title'] == 'Anxiety Relief') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AnxietyReliefScreen()),
                      );
                    } else if (content['title'] == 'Sleep Stories') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SleepStoriesScreen()),
                      );
                    } else if (content.containsKey('link') && content['link'] != null) {
                      _launchUrl(content['link'] as String);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Coming soon: ${content['title']}')),
                      );
                    }
                  },
                  child: Row(
                    children: [
                      Text(
                        'Start Now',
                        style: GoogleFonts.poppins(
                            color: kWhiteCardColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                      const SizedBox(width: 5),
                      const Icon(Icons.arrow_forward_ios_rounded,
                          color: kWhiteCardColor, size: 14),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ====================================================================
// ANXIETY RELIEF SCREEN (Guided Breathing, Audio, and Progress Tracker)
// ====================================================================

class AnxietyReliefScreen extends StatefulWidget {
  const AnxietyReliefScreen({super.key});

  @override
  State<AnxietyReliefScreen> createState() => _AnxietyReliefScreenState();
}

class _AnxietyReliefScreenState extends State<AnxietyReliefScreen>
    with SingleTickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _isSessionRunning = true; // Track if the session is running
  final String _audioUrl =
      'https://cdn.pixabay.com/audio/2022/08/02/audio_d2b76c6e95.mp3'; // Sample calming audio
  int _breathingCycles = 0;
  String _breathingPhase = 'Inhale';
  double _progress = 0.0;
  late AnimationController _animationController;
  Timer? _breathingTimer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 19), // Total: 4s inhale + 7s hold + 8s exhale
    )..addListener(() {
      setState(() {
        _progress = _animationController.value;
        if (_progress < 4 / 19) {
          _breathingPhase = 'Inhale';
        } else if (_progress < 11 / 19) {
          _breathingPhase = 'Hold';
        } else {
          _breathingPhase = 'Exhale';
        }
      });
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _breathingCycles++;
        });
        _animationController.reset();
        if (_isSessionRunning) {
          _startBreathingCycle();
        }
      }
    });

    _startBreathingCycle();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _animationController.dispose();
    _breathingTimer?.cancel();
    super.dispose();
  }

  // Start or resume the breathing cycle
  void _startBreathingCycle() {
    _breathingTimer?.cancel();
    _animationController.forward();
    setState(() {
      _isSessionRunning = true;
    });
  }

  // Reset the entire session
  void _resetSession() {
    _animationController.stop();
    _animationController.reset();
    _breathingTimer?.cancel();
    if (_isPlaying) {
      _audioPlayer.stop();
    }
    setState(() {
      _breathingCycles = 0;
      _progress = 0.0;
      _breathingPhase = 'Inhale';
      _isPlaying = false;
      _isSessionRunning = false;
    });
  }

  // Toggle audio playback
  Future<void> _toggleAudio() async {
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
        setState(() {
          _isPlaying = false;
        });
      } else {
        await _audioPlayer.play(UrlSource(_audioUrl));
        setState(() {
          _isPlaying = true;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error playing audio')),
      );
    }
  }

  // Get motivational message based on cycles completed
  String _getMotivationalMessage() {
    if (_breathingCycles < 2) {
      return 'Great start! Keep breathing to feel calmer.';
    } else if (_breathingCycles < 5) {
      return 'Youâ€™re doing amazing! Feel the calm wash over you.';
    } else {
      return 'Wow, youâ€™re a pro! Keep it up for ultimate relaxation.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kAppBarTextColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Anxiety Relief',
          style: GoogleFonts.poppins(
            color: kAppBarTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: kBackgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: kAppBarTextColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Breathing Animation
            Text(
              _breathingPhase,
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: kPrimaryDarkPink,
              ),
            ),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: _progress,
                    strokeWidth: 10,
                    backgroundColor: kPrimaryLightPink,
                    valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryDarkPink),
                  ),
                ),
                Text(
                  '${((_progress * 19).round())}s',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    color: kAppBarTextColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Cycles Completed: $_breathingCycles',
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: kAppBarTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _getMotivationalMessage(),
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: kAppBarTextColor.withOpacity(0.7),
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // Audio Control
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kWhiteCardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: kPrimaryDarkPink.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _toggleAudio,
                    icon: Icon(
                      _isPlaying
                          ? Icons.pause_circle_filled_rounded
                          : Icons.play_circle_filled_rounded,
                      color: kPrimaryDarkPink,
                      size: 40,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    _isPlaying ? 'Pause Calming Audio' : 'Play Calming Audio',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: kPrimaryDarkPink,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Control Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isSessionRunning
                      ? null
                      : () {
                    _startBreathingCycle();
                    if (_isPlaying) {
                      _audioPlayer.resume();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kCardMentalTeal,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 5,
                    shadowColor: kCardMentalTeal.withOpacity(0.4),
                  ),
                  child: Text(
                    'Resume/Continue',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: kWhiteCardColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _resetSession,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryDarkPink,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 5,
                    shadowColor: kPrimaryDarkPink.withOpacity(0.4),
                  ),
                  child: Text(
                    'Stop Session',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: kWhiteCardColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}