import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'constants/colors.dart';

// --- Theme Colors (Consistent with MentalHealth.dart) ---


// ====================================================================
// MENTAL SUPPORT SCREEN (With Three Support Options)
// ====================================================================

class MentalSupportScreen extends StatelessWidget {
  const MentalSupportScreen({super.key});

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
          'Mental Support',
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Connect with Support',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: kAppBarTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height:100),
            Text(
              'Choose an option to find the support you need.',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: kAppBarTextColor.withOpacity(0.7),
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            _buildSupportButton(
              context,
              title: 'Chat with Expert',
              icon: Icons.person_rounded,
              color: const Color.fromARGB(255, 204, 198, 115),
              onPressed: () {
                // Placeholder URL for professional support (e.g., therapy platform)
                _launchUrl(context, 'https://www.betterhelp.com');
              },
            ),
            const SizedBox(height:30),
            _buildSupportButton(
              context,
              title: 'Chat with Someone Like You',
              icon: Icons.group_rounded,
              color: kCardPregnancyOrange,
              onPressed: () {
                // Placeholder URL for peer support (e.g., community forum)
                _launchUrl(context, 'https://www.7cups.com');
              },
            ),
            const SizedBox(height: 30),
            _buildSupportButton(
              context,
              title: 'Talk to AI',
              icon: Icons.chat_bubble_rounded,
              color: kCardBreastRed,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AISupportChatScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportButton(BuildContext context,
      {required String title,
      required IconData icon,
      required Color color,
      required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: const Color.fromARGB(255, 250, 205, 239), size: 24),
      label: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: kWhiteCardColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 5,
        shadowColor: color.withOpacity(0.4),
      ),
    );
  }

  Future<void> _launchUrl(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }
}

// ====================================================================
// AI SUPPORT CHAT SCREEN (Sample Chatbox)
// ====================================================================

class AISupportChatScreen extends StatefulWidget {
  const AISupportChatScreen({super.key});

  @override
  State<AISupportChatScreen> createState() => _AISupportChatScreenState();
}

class _AISupportChatScreenState extends State<AISupportChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {
      'sender': 'AI',
      'text': 'Hello! I’m here to offer some support. How are you feeling today?'
    }
  ];

  // Sample responses for the AI
  final List<String> _aiResponses = [
    'You’re doing great just by being here! Want to share what’s on your mind?',
    'It’s okay to feel overwhelmed sometimes. Try taking a deep breath and let me know how I can help.',
    'You are stronger than you know! What’s something positive you’ve experienced today?',
    'I’m here for you. Want to talk about what’s been going on?',
    'You’ve got this! How about setting a small goal for today to lift your spirits?'
    'I’m really sorry you’re feeling that way 💙 Want to talk about it?',
    'It’s okay to not be okay sometimes. I’m here to listen',
    'Sounds like you’ve had a rough day. Let’s take it slow together',
    'If it helps, I can share something comforting or lighthearted.',
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'sender': 'User',
        'text': _controller.text.trim(),
      });

      // Simulate AI response with a delay
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _messages.add({
            'sender': 'AI',
            'text': _aiResponses[DateTime.now().millisecond % _aiResponses.length],
          });
        });
      });

      _controller.clear();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          'Talk to AI',
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
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['sender'] == 'User';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? kPrimaryDarkPink : kWhiteCardColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      message['text']!,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: isUser ? kWhiteCardColor : kAppBarTextColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle: GoogleFonts.poppins(
                        color: kAppBarTextColor.withOpacity(0.5),
                      ),
                      filled: true,
                      fillColor: kSectionGrey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: GoogleFonts.poppins(color: kAppBarTextColor),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send_rounded, color: kPrimaryDarkPink),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}