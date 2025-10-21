import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'constants/colors.dart';

// --- Theme Colors (Consistent with MentalHealth.dart) ---

class SleepStoriesScreen extends StatefulWidget {
  const SleepStoriesScreen({super.key});

  @override
  State<SleepStoriesScreen> createState() => _SleepStoriesScreenState();
}

class _SleepStoriesScreenState extends State<SleepStoriesScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentlyPlayingUrl;
  bool _isPlaying = false;
  double _progress = 0.0;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  int _storiesPlayed = 0; // Track number of stories played

  // List of sleep stories, including a custom add card
  List<Map<String, dynamic>> stories = [
    {
      'title': 'Moonlit Forest',
      'subtitle': 'A calming journey through a serene forest',
      'audioUrl': 'https://cdn.pixabay.com/audio/2022/08/02/audio_d2b76c6e95.mp3',
      'icon': Icons.nights_stay_rounded,
      'color': kCardGamesPurple,
    },
    {
      'title': 'Ocean Whispers',
      'subtitle': 'Gentle waves for deep relaxation',
      'audioUrl': 'https://cdn.pixabay.com/audio/2023/03/28/audio_6e5bece4f6.mp3',
      'icon': Icons.waves_rounded,
      'color': kPrimaryDarkPink,
    },
    {
      'title': 'Starry Night',
      'subtitle': 'A soothing tale under the stars',
      'audioUrl': 'https://cdn.pixabay.com/audio/2023/08/08/audio_b8e5865df1.mp3',
      'icon': Icons.star_border_rounded,
      'color': kPrimaryLightPink,
    },
    {'isCustomAdd': true, 'category': 'Sleep Stories'},
  ];

  // Variables for custom story input
  String _customTitle = '';
  String _customSubtitle = '';
  String _customAudioUrl = '';

  @override
  void initState() {
    super.initState();
    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _currentPosition = position;
        if (_totalDuration.inSeconds > 0) {
          _progress = _currentPosition.inSeconds / _totalDuration.inSeconds;
        }
      });
    });
    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _totalDuration = duration;
      });
    });
    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _storiesPlayed++;
        _isPlaying = false;
        _currentlyPlayingUrl = null;
        _progress = 0.0;
        _currentPosition = Duration.zero;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // Toggle audio playback
Future<void> _toggleAudio(String audioUrl) async {
  try {
    print('🔄 Attempting to play: $audioUrl'); // Debug print
    
    if (_currentlyPlayingUrl == audioUrl && _isPlaying) {
      await _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    } else {
      if (_currentlyPlayingUrl != audioUrl) {
        await _audioPlayer.stop();
        await _audioPlayer.play(UrlSource(audioUrl));
        setState(() {
          _currentlyPlayingUrl = audioUrl;
          _progress = 0.0;
          _currentPosition = Duration.zero;
        });
      } else {
        await _audioPlayer.resume();
      }
      setState(() {
        _isPlaying = true;
      });
    }
    print('✅ Audio playing successfully'); // Debug print
  } catch (e) {
    print('❌ Error playing audio: $e'); // This will show the exact error
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error playing audio: ${e.toString()}')),
    );
  }
}

  // Stop audio playback
  Future<void> _stopAudio() async {
    try {
      await _audioPlayer.stop();
      setState(() {
        _isPlaying = false;
        _currentlyPlayingUrl = null;
        _progress = 0.0;
        _currentPosition = Duration.zero;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error stopping audio')),
      );
    }
  }

  // Show dialog to add custom story
  void _showCustomAddDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Custom Sleep Story",
              style: GoogleFonts.poppins(color: kAppBarTextColor)),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  onChanged: (value) => _customTitle = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description/Notes'),
                  onChanged: (value) => _customSubtitle = value,
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Audio URL (e.g., MP3 link)'),
                  onChanged: (value) => _customAudioUrl = value,
                ),
              ],
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
                if (_customTitle.isNotEmpty &&
                    _customSubtitle.isNotEmpty &&
                    _customAudioUrl.isNotEmpty) {
                  // Basic URL validation
                  if (_customAudioUrl.startsWith('http') &&
                      _customAudioUrl.endsWith('.mp3')) {
                    setState(() {
                      stories.insert(stories.length - 1, {
                        'title': _customTitle,
                        'subtitle': _customSubtitle,
                        'audioUrl': _customAudioUrl,
                        'icon': Icons.nights_stay_rounded,
                        'color': kCardGamesPurple,
                      });
                    });
                    Navigator.of(context).pop();
                    _customTitle = '';
                    _customSubtitle = '';
                    _customAudioUrl = '';
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please enter a valid MP3 URL')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all fields')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Get motivational message based on stories played
  String _getMotivationalMessage() {
    if (_storiesPlayed == 0) {
      return 'Start your journey to a restful night!';
    } else if (_storiesPlayed < 3) {
      return 'Great job! Keep relaxing with these soothing stories.';
    } else {
      return 'You’re a sleep story pro! Sweet dreams await!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Sleep Stories',
          style: GoogleFonts.poppins(
            color: kAppBarTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: kBackgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: kAppBarTextColor),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Playback Progress
          if (_currentlyPlayingUrl != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                children: [
                  Text(
                    _currentlyPlayingUrl != null
                        ? 'Now Playing: ${stories.firstWhere((story) => story['audioUrl'] == _currentlyPlayingUrl, orElse: () => {'title': 'Unknown Story'})['title']}'
                        : 'No story playing',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: kAppBarTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: _progress,
                    backgroundColor: kPrimaryLightPink,
                    valueColor: AlwaysStoppedAnimation<Color>(kPrimaryDarkPink),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${_currentPosition.inMinutes}:${(_currentPosition.inSeconds % 60).toString().padLeft(2, '0')} / ${_totalDuration.inMinutes}:${(_totalDuration.inSeconds % 60).toString().padLeft(2, '0')}',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: kAppBarTextColor.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Stop Button
                  ElevatedButton(
                    onPressed: _stopAudio,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryDarkPink,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Stop Story',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: kWhiteCardColor,
                        fontWeight: FontWeight.bold,
                      ),
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
                ],
              ),
            ),
          // Stories List
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(
              'Choose a Story',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: kAppBarTextColor,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              itemCount: stories.length,
              itemBuilder: (context, index) {
                final story = stories[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: story.containsKey('isCustomAdd') &&
                          story['isCustomAdd'] == true
                      ? _buildCustomAddCard()
                      : _buildStoryCard(story),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Builds the "Add Custom" card
  Widget _buildCustomAddCard() {
    return GestureDetector(
      onTap: _showCustomAddDialog,
      child: Container(
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
        child: Row(
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
            const SizedBox(width: 10),
            Column(
              children: [
                Text(
                  "Add Custom Story",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: kPrimaryDarkPink),
                ),
                Text(
                  "Create your own",
                  style: GoogleFonts.poppins(
                      fontSize: 12, color: kAppBarTextColor.withOpacity(0.7)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Builds an individual story card
  Widget _buildStoryCard(Map<String, dynamic> story) {
    final isPlayingThis = _currentlyPlayingUrl == story['audioUrl'] && _isPlaying;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: story['color'] as Color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: (story['color'] as Color).withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 5)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kWhiteCardColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(story['icon'] as IconData, color: Colors.white, size: 36),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  story['title'] as String,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  story['subtitle'] as String,
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _toggleAudio(story['audioUrl'] as String),
            icon: Icon(
              isPlayingThis
                  ? Icons.pause_circle_filled_rounded
                  : Icons.play_circle_filled_rounded,
              color: kWhiteCardColor,
              size: 36,
            ),
          ),
        ],
      ),
    );
  }
}