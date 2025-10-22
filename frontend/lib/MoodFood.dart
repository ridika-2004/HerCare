import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants/colors.dart';

// --- Theme Colors (Consistent with MentalHealth.dart) ---


// ====================================================================
// MOOD FOOD SCREEN - Bangladeshi Easy Recipes for Mood Boosting
// Girlish, Foodie Theme with Icons, Steps, and Creative UI
// ====================================================================

class MoodFoodScreen extends StatefulWidget {
  const MoodFoodScreen({super.key});

  @override
  State<MoodFoodScreen> createState() => _MoodFoodScreenState();
}

class _MoodFoodScreenState extends State<MoodFoodScreen> {
  String _selectedRecipe = 'Khichuri'; // Default selected recipe

  // Data structure for recipes: easy Bangladeshi mood-boosting foods
  final Map<String, Map<String, dynamic>> recipesData = {
    'Khichuri': {
      'title': 'Comfort Khichuri 🌾',
      'subtitle': 'Warm, soothing lentil-rice porridge to calm your soul 💖',
      'icon': Icons.restaurant,
      'color': kCardMentalTeal,
      'moodBoost': 'Serotonin from carbs, magnesium from lentils – pure comfort hug!',
      'ingredients': [
        '1/2 cup rice',
        '1/4 cup moong dal',
        '1 tsp cumin seeds',
        '1/2 tsp turmeric',
        'Salt to taste',
        'Ghee for flavor',
        'Water (2 cups)',
      ],
      'steps': [
        {'step': '1', 'description': 'Rinse rice and dal together 💧', 'icon': Icons.wash},
        {'step': '2', 'description': 'Heat ghee, add cumin, then add rice-dal mix 🌟', 'icon': Icons.add_circle},
        {'step': '3', 'description': 'Add turmeric, salt, water; cook 20 min until soft 🍲', 'icon': Icons.timer},
        {'step': '4', 'description': 'Serve hot with a dollop of ghee – hug in a bowl! 😍', 'icon': Icons.favorite},
      ],
      'time': '20 mins',
      'difficulty': 'Super Easy',
    },
    'Shorshe Ilish': {
      'title': 'Hilsa in Mustard Magic 🐟',
      'subtitle': 'Omega-3 rich fish for happy brain vibes ✨',
      'icon': Icons.water_drop,
      'color': kCardPregnancyOrange,
      'moodBoost': 'Omega-3s fight blues, mustard adds zing for joy boost!',
      'ingredients': [
        '4 Hilsa steaks',
        '2 tbsp mustard paste',
        '1 tsp green chili paste',
        'Turmeric, salt',
        'Mustard oil',
        'Water',
      ],
      'steps': [
        {'step': '1', 'description': 'Marinate fish with salt, turmeric 10 min 🧂', 'icon': Icons.timer_off},
        {'step': '2', 'description': 'Blend mustard + chili paste 🌿', 'icon': Icons.blender},
        {'step': '3', 'description': 'Heat oil, add paste, then fish + water; steam 15 min 🔥', 'icon': Icons.fireplace},
        {'step': '4', 'description': 'Garnish with cilantro – feel the river-fresh glow! 🌊', 'icon': Icons.restaurant,
        },
      ],
      'time': '25 mins',
      'difficulty': 'Easy Peasy',
    },
    'Cholar Dal': {
      'title': 'Golden Cholar Dal 🌱',
      'subtitle': 'Protein-packed Bengal gram for steady energy & smiles ☀️',
      'icon': Icons.eco,
      'color': kCardBreastRed,
      'moodBoost': 'B vitamins for mood stability, fiber for gut-happy days!',
      'ingredients': [
        '1 cup chana dal',
        '1 tsp cumin',
        '1/2 tsp turmeric',
        'Ginger paste 1 tsp',
        'Salt, sugar',
        'Bay leaf',
        'Mustard oil',
      ],
      'steps': [
        {'step': '1', 'description': 'Soak dal 30 min, boil with turmeric & salt 🍲', 'icon': Icons.local_drink},
        {'step': '2', 'description': 'Heat oil, fry cumin & bay leaf, add ginger 🌿', 'icon': Icons.add_circle},
        {'step': '3', 'description': 'Mix in boiled dal, simmer 10 min with sugar 🧈', 'icon': Icons.rotate_right},
        {'step': '4', 'description': 'Serve with rice – golden glow for your heart! 💛', 'icon': Icons.heart_broken},
      ],
      'time': '40 mins',
      'difficulty': 'Beginner Fun',
    },
  };

  @override
  Widget build(BuildContext context) {
    final recipe = recipesData[_selectedRecipe]!;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop(); // Back to MentalHealth.dart
          },
        ),
        title: Text(
          'Mood Food Magic 🍲💕',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Girly Header with Sparkles
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [kPrimaryLightPink, kPrimaryDarkPink],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.local_dining, color: Colors.white, size: 30),
                        const SizedBox(width: 10),
                        Text(
                          'Bangla Bites for Bliss!',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(Icons.restaurant, color: Colors.white, size: 30),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Easy Bangladeshi treats to lift your mood 💖',
                      style: GoogleFonts.poppins(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Recipe Selection Grid - Girly Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Pick Your Mood Booster 💕',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kAppBarTextColor,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.2,
                ),
                itemCount: recipesData.length,
                itemBuilder: (context, index) {
                  final recipeKey = recipesData.keys.elementAt(index);
                  final r = recipesData[recipeKey]!;
                  final isSelected = _selectedRecipe == recipeKey;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedRecipe = recipeKey),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: isSelected ? r['color'] : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? r['color'] : Colors.grey.shade300,
                          width: isSelected ? 3 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: r['color'].withOpacity(isSelected ? 0.4 : 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(r['icon'], size: 40, color: isSelected ? Colors.white : r['color']),
                          const SizedBox(height: 8),
                          Text(
                            r['title'].split(' ')[0], // Short title for card
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : kAppBarTextColor,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Selected Recipe Details - Creative, Step-by-Step
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.all(20),
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
                    // Header with Icon and Mood Boost
                    Row(
                      children: [
                        Icon(recipe['icon'], size: 30, color: recipe['color']),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipe['title'],
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: kAppBarTextColor,
                                ),
                              ),
                              Text(
                                recipe['subtitle'],
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: kAppBarTextColor.withOpacity(0.7),
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: recipe['color'].withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            recipe['difficulty'],
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: recipe['color'],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Why It Boosts Your Mood 💖',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryDarkPink,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      recipe['moodBoost'],
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: kAppBarTextColor.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Ingredients Section
                    _buildSection('Ingredients ✨', Icons.list_alt, recipe['ingredients']),
                    const SizedBox(height: 15),

                    // Steps Section - Step-by-Step with Icons
                    _buildSection('Step-by-Step Magic 🍴', Icons.menu_book, null),
                    const SizedBox(height: 10),
                    Column(
                      children: List.generate(
                        recipe['steps'].length,
                            (index) {
                          final step = recipe['steps'][index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: kPrimaryDarkPink.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(step['icon'], size: 20, color: kPrimaryDarkPink),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Step ${step['step']} ',
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: kAppBarTextColor,
                                            ),
                                          ),
                                          Icon(Icons.star, color: kPrimaryDarkPink, size: 16),
                                        ],
                                      ),
                                      Text(
                                        step['description'],
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: kAppBarTextColor.withOpacity(0.9),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Time: ${recipe['time']} | Let\'s cook, queen! 👑',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: kPrimaryDarkPink,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }

  // Helper method to build sections like Ingredients
  Widget _buildSection(String title, IconData icon, List<String>? items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: kPrimaryDarkPink),
            const SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kAppBarTextColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (items != null)
          Column(
            children: items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                children: [
                  Icon(Icons.circle, size: 6, color: kPrimaryDarkPink),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: GoogleFonts.poppins(fontSize: 14, color: kAppBarTextColor),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ),
      ],
    );
  }
}