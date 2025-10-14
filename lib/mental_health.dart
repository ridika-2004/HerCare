import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Theme Colors (Defined Locally for independence, matching main.dart) ---
const Color kPrimaryDarkPink = Color(0xFFE9386D); 
const Color kPrimaryLightPink = Color.fromARGB(255, 212, 178, 189); 
const Color kBackgroundColor = Color(0xFFFFFAFD);
const Color kAppBarTextColor = Color.fromARGB(255, 74, 3, 40);
const Color kWhiteCardColor = Color.fromARGB(255, 243, 219, 237);
const Color kSectionGrey = Color.fromARGB(255, 255, 218, 247);

// Feature Card Colors (The 'Girly' Theme Palette)
const Color kCardPeriodRed = Color(0xFFD84A62);
const Color kCardPregnancyOrange = Color(0xFFF58461);
const Color kCardMentalTeal = Color(0xFF63C2C0); // Teal
const Color kCardBreastRed = Color(0xFFDA566E);
const Color kCardGamesPurple = Color(0xFF8B64CC); // Purple
const Color kCardPodcastBlue = Color(0xFF5CA6D6); // Blue


// ====================================================================
// MENTAL HEALTH SCREEN (With Conditional Custom Fields)
// ====================================================================

class MentalHealthScreen extends StatefulWidget {
  const MentalHealthScreen({super.key});

  @override
  State<MentalHealthScreen> createState() => _MentalHealthScreenState();
}

class _MentalHealthScreenState extends State<MentalHealthScreen> {
  String _selectedCategory = 'Meditation'; 

  // Data structure including a placeholder for the "Add Custom" card in EACH list
  final Map<String, List<Map<String, dynamic>>> contentData = {
    'Meditation': [
      {'title': '5-Min Morning Calm', 'subtitle': 'Mindfulness', 'icon': Icons.self_improvement_rounded, 'color': kCardMentalTeal}, 
      {'title': 'Sleep Stories', 'subtitle': 'Bedtime Relaxation', 'icon': Icons.nights_stay_rounded, 'color': kCardGamesPurple}, 
      {'title': 'Anxiety Relief', 'subtitle': 'Quick Session', 'icon': Icons.spa_rounded, 'color': kPrimaryDarkPink}, 
      {'isCustomAdd': true, 'category': 'Meditation'}, // Custom Add Card
    ],
    'Music': [
      {'title': 'Focus Beats', 'subtitle': 'Concentration', 'icon': Icons.music_note_rounded, 'color': kCardPodcastBlue}, 
      {'title': 'Soothing Piano', 'subtitle': 'Relaxation', 'icon': Icons.piano_rounded, 'color': kCardPeriodRed}, 
      {'title': 'Calm Nature Sounds', 'subtitle': 'Ambient', 'icon': Icons.forest_rounded, 'color': kCardMentalTeal.withOpacity(0.8)}, 
      {'isCustomAdd': true, 'category': 'Music'}, // Custom Add Card
    ],
    'Exercise': [
      {'title': 'Gentle Yoga Flow', 'subtitle': 'Stress release', 'icon': Icons.accessibility_new_rounded, 'color': kCardPregnancyOrange}, 
      {'title': 'Walking Trails', 'subtitle': 'Outdoor activity', 'icon': Icons.directions_walk_rounded, 'color': const Color.fromARGB(255, 195, 104, 133)}, 
      {'title': 'Desk Stretches', 'subtitle': 'Quick break', 'icon': Icons.chair_rounded, 'color': kCardGamesPurple.withOpacity(0.9)}, 
      {'isCustomAdd': true, 'category': 'Exercise'}, // Custom Add Card
    ],
    'Diet': [
      {'title': 'Mood-Boosting Foods', 'subtitle': 'Nutrition tips', 'icon': Icons.local_dining_rounded, 'color': kCardBreastRed}, 
      {'title': 'Hydration Challenge', 'subtitle': 'Water intake', 'icon': Icons.water_drop_rounded, 'color': kCardPodcastBlue.withOpacity(0.7)}, 
      {'title': 'Gut Health Basics', 'subtitle': 'Wellness connection', 'icon': Icons.healing_rounded, 'color': kCardPeriodRed}, 
      {'isCustomAdd': true, 'category': 'Diet'}, // Custom Add Card
    ],
    'Travel / Tours': [
      {'title': 'Virtual Nature Walk', 'subtitle': 'Forest sounds', 'icon': Icons.terrain_rounded, 'color': kCardMentalTeal}, 
      {'title': 'Visual Relaxation', 'subtitle': 'Ocean view', 'icon': Icons.beach_access_rounded, 'color': kCardPregnancyOrange}, 
      {'isCustomAdd': true, 'category': 'Travel / Tours'}, // Custom Add Card
    ],
  };
  
  // Custom input fields builder
  List<Widget> _buildCustomFields(String category) {
    List<Widget> fields = [
      TextFormField(
        decoration: const InputDecoration(labelText: 'Title'),
      ),
      TextFormField(
        decoration: const InputDecoration(labelText: 'Description/Notes'),
      ),
      const SizedBox(height: 15),
    ];

    switch (category) {
      case 'Music':
      case 'Travel / Tours':
        fields.add(
          TextFormField(
            decoration: const InputDecoration(labelText: 'Supporting Link'),
          ),
        );
        break;
      case 'Meditation':
        fields.add(
          OutlinedButton.icon(
            icon: const Icon(Icons.camera_alt_rounded, color: kPrimaryDarkPink),
            label: const Text('Upload Image (Optional)', style: TextStyle(color: kPrimaryDarkPink)),
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
      // Other categories can have different or no extra fields
      case 'Exercise':
      case 'Diet':
        fields.add(
          TextFormField(
            decoration: const InputDecoration(labelText: 'Source/Reference (Optional)'),
          ),
        );
        break;
    }
    return fields;
  }

  // Updated function for custom addition dialog
  void _showCustomAddDialog(String category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Custom $category Idea"),
          content: SingleChildScrollView(
            child: ListBody(
              children: _buildCustomFields(category),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: kAppBarTextColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save', style: TextStyle(color: kPrimaryDarkPink, fontWeight: FontWeight.bold)),
              onPressed: () {
                // TODO: Implement actual data saving logic here
                Navigator.of(context).pop();
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
        title: Text('Mental Health Hub', style: GoogleFonts.poppins(color: kAppBarTextColor, fontWeight: FontWeight.bold)),
        backgroundColor: kBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: kAppBarTextColor),
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
                    child: Text(_selectedCategory, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: kAppBarTextColor)),
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
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? kPrimaryDarkPink : kWhiteCardColor,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: isSelected ? kPrimaryDarkPink : Colors.grey.shade300),
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
      height: 250, // Fixed height for the horizontal list
      child: ListView.builder(
        scrollDirection: Axis.horizontal, 
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        itemCount: contentList.length,
        itemBuilder: (context, index) {
          final content = contentList[index];
          return Padding(
            padding: EdgeInsets.only(right: index == contentList.length - 1 ? 0 : 16.0),
            child: content.containsKey('isCustomAdd') && content['isCustomAdd'] == true
                ? _buildCustomAddCard(content['category'] as String) // Special card for "Add Custom"
                : _buildContentCard(content), // Regular content card
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
          color: kSectionGrey, // Use a light, neutral color
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: kPrimaryLightPink, width: 3, style: BorderStyle.solid), 
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
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
              child: const Icon(Icons.add_circle_outline_rounded, color: kPrimaryDarkPink, size: 36),
            ),
            const SizedBox(height: 10),
            Text(
              "Add Custom", 
              style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16, color: kPrimaryDarkPink), 
              textAlign: TextAlign.center,
            ),
            Text(
              category, 
              style: GoogleFonts.poppins(fontSize: 12, color: kAppBarTextColor.withOpacity(0.7)), 
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds an individual content card.
  Widget _buildContentCard(Map<String, dynamic> content) {
    return Container(
      width: 180, // Fixed width for horizontal scrolling
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: content['color'] as Color, 
        borderRadius: BorderRadius.circular(20), 
        boxShadow: [
          BoxShadow(color: (content['color'] as Color).withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 5)),
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
              Text(content['title'] as String, style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.white), maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 4),
              Text(content['subtitle'] as String, style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70), maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Text("Start Now", style: TextStyle(color: kWhiteCardColor, fontWeight: FontWeight.bold, fontSize: 13)),
                  SizedBox(width: 5),
                  Icon(Icons.arrow_forward_ios_rounded, color: kWhiteCardColor, size: 14),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}