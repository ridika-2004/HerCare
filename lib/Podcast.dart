import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/colors.dart';
import '../services/podcast_service.dart';

class PodcastScreen extends StatefulWidget {
  const PodcastScreen({super.key});

  @override
  State<PodcastScreen> createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  String? userEmail;
  List<dynamic> podcasts = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
  }

  Future<void> _loadUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('userEmail');

    if (email != null) {
      print("✅ Logged in as: $email");
      setState(() => userEmail = email);
      await _fetchPodcasts(); // fetch after login
    }
  }

  Future<void> _fetchPodcasts() async {
    if (userEmail == null) return;
    setState(() => isLoading = true);

    try {
      final data = await PodcastService.getPodcasts(userEmail!);
      setState(() => podcasts = data);
    } catch (e) {
      print("❌ Failed to load podcasts: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load podcasts: $e")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _deletePodcast(String title) async {
    if (userEmail == null) return;
    try {
      await PodcastService.deletePodcast(userEmail!, title);
      await _fetchPodcasts(); // refresh list
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Podcast deleted")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete: $e")),
      );
    }
  }

  Future<void> _addCustomPodcast(BuildContext context) async {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController linkController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Custom Podcast',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Podcast Title'),
              ),
              TextField(
                controller: linkController,
                decoration: const InputDecoration(labelText: 'Podcast Link'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await PodcastService.addPodcast(
                    userEmail ?? "unknown@example.com",
                    titleController.text.trim(),
                    linkController.text.trim(),
                  );
                  if (context.mounted) {
                    Navigator.pop(context);
                    await _fetchPodcasts(); // refresh list
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Podcast saved!")),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed: $e")),
                  );
                }
              },
              child: const Text('Save'),
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
      title: Text(
        'Girl Power Podcasts 🎧',
        style: GoogleFonts.poppins(
          color: kAppBarTextColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: kBackgroundColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: kAppBarTextColor),
      actions: [
        if (userEmail != null)
          IconButton(
            icon: const Icon(Icons.logout, color: kAppBarTextColor),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('userEmail'); // Clear login
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/signup', (route) => false);
              }
            },
          ),
      ],
    ),
    // <<< REPLACE THIS `body:` PART WITH THE NEW SNIPPET
    body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: _fetchPodcasts,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  if (podcasts.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Text(
                        "No podcasts added yet 💫",
                        style: GoogleFonts.poppins(
                          color: kAppBarTextColor.withOpacity(0.7),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ...podcasts.map((podcast) => Card(
                        color: Colors.white,
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(
                            podcast["title"] ?? "Untitled",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            podcast["link"] ?? "",
                            style: GoogleFonts.poppins(
                              color: Colors.grey[600],
                              fontSize: 13,
                            ),
                          ),
                          trailing: Wrap(
                            spacing: 12,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.play_arrow,
                                    color: kPrimaryDarkPink),
                                onPressed: () async {
                                  final url = Uri.parse(podcast["link"]);
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Could not open link")));
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.redAccent),
                                onPressed: () =>
                                    _deletePodcast(podcast["title"]),
                              ),
                            ],
                          ),
                        ),
                      )),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () => _addCustomPodcast(context),
                      icon: const Icon(Icons.add_link_rounded,
                          color: Colors.white),
                      label: Text(
                        'Add Custom Podcast',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryDarkPink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                        shadowColor: kPrimaryDarkPink.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
  );
}

}
