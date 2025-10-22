import 'package:flutter/material.dart';
import 'constants/colors.dart';

class GutHealthBasicsPage extends StatelessWidget {
  const GutHealthBasicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: kAppBarTextColor),
        title: const Text(
          'Gut Health Basics',
          style: TextStyle(color: kAppBarTextColor, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeroCard(
              emoji: '🦠',
              title: 'Microbiome 101',
              subtitle: 'Your gut is home to trillions of microbes that impact mood, energy, and immunity.',
            ),
            const SizedBox(height: 20),
            _KeyFactsRow(facts: [
              _KeyFactItem(emoji: '🧬', number: '100T', label: 'Microbes'),
              _KeyFactItem(emoji: '🧠', number: '90%', label: 'Serotonin'),
              _KeyFactItem(emoji: '🛡️', number: '70%', label: 'Immunity'),
            ]),
            const SizedBox(height: 24),
            const _SectionTitle(icon: '⚡', text: 'Daily Quick Wins'),
            const SizedBox(height: 12),
            _QuickWinCard(
              icon: '🥗',
              title: 'Fiber First',
              description: 'Add veggies, beans, and whole grains to every meal.',
            ),
            const SizedBox(height: 10),
            _QuickWinCard(
              icon: '💧',
              title: 'Hydrate Consistently',
              description: 'Sip water throughout the day, not just at meals.',
            ),
            const SizedBox(height: 10),
            _QuickWinCard(
              icon: '😴',
              title: 'Sleep 7–9 Hours',
              description: 'Microbes thrive on routine—keep consistent sleep times.',
            ),
            const SizedBox(height: 10),
            _QuickWinCard(
              icon: '🚶',
              title: 'Move Gently',
              description: '10–20 minute walk or light stretches daily.',
            ),
            const SizedBox(height: 24),
            const _SectionTitle(icon: '🍽️', text: 'Food Categories'),
            const SizedBox(height: 12),
            _FoodCategoryCard(
              icon: '🦠',
              category: 'Probiotics',
              color: Colors.purple,
              subtitle: 'Live beneficial bacteria',
              foods: ['Yogurt', 'Kefir', 'Kimchi', 'Sauerkraut', 'Miso'],
            ),
            const SizedBox(height: 12),
            _FoodCategoryCard(
              icon: '🌾',
              category: 'Prebiotics',
              color: Colors.orange,
              subtitle: 'Food for good bacteria',
              foods: ['Oats', 'Banana', 'Onion', 'Garlic', 'Asparagus'],
            ),
            const SizedBox(height: 12),
            _FoodCategoryCard(
              icon: '🍇',
              category: 'Polyphenols',
              color: Colors.deepPurple,
              subtitle: 'Antioxidants for gut health',
              foods: ['Berries', 'Olive oil', 'Green tea', 'Cocoa', 'Apples'],
            ),
            const SizedBox(height: 12),
            _FoodCategoryCard(
              icon: '🐟',
              category: 'Omega-3s',
              color: Colors.blue,
              subtitle: 'Anti-inflammatory fats',
              foods: ['Salmon', 'Chia seeds', 'Walnuts', 'Flaxseed', 'Sardines'],
            ),
            const SizedBox(height: 24),
            const _SectionTitle(icon: '📅', text: 'Simple 1-Day Meal Plan'),
            const SizedBox(height: 12),
            _MealCard(
              mealTime: 'Breakfast',
              icon: '🌅',
              time: '7-9 AM',
              meal: 'Greek yogurt + berries + oats',
              benefits: 'Probiotics, fiber, antioxidants',
            ),
            const SizedBox(height: 10),
            _MealCard(
              mealTime: 'Lunch',
              icon: '☀️',
              time: '12-2 PM',
              meal: 'Grain bowl: brown rice + beans + greens + olive oil',
              benefits: 'Fiber, protein, healthy fats',
            ),
            const SizedBox(height: 10),
            _MealCard(
              mealTime: 'Snack',
              icon: '🍎',
              time: '3-4 PM',
              meal: 'Banana + peanut butter',
              benefits: 'Prebiotics, protein',
            ),
            const SizedBox(height: 10),
            _MealCard(
              mealTime: 'Dinner',
              icon: '🌙',
              time: '6-8 PM',
              meal: 'Salmon (or beans) + roasted veggies + quinoa',
              benefits: 'Omega-3s, fiber, complete nutrition',
            ),
            const SizedBox(height: 24),
            _TipsCard(),
            const SizedBox(height: 16),
            _ProgressTrackerCard(),
          ],
        ),
      ),
    );
  }
}

/* ---------- Hero Card ---------- */

class _HeroCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  const _HeroCard({required this.emoji, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kPrimaryDarkPink.withOpacity(0.08), kPrimaryDarkPink.withOpacity(0.02)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: kPrimaryDarkPink.withOpacity(0.1), width: 1),
        boxShadow: [
          BoxShadow(color: kPrimaryDarkPink.withOpacity(0.15), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kWhiteCardColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(emoji, style: const TextStyle(fontSize: 48)),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: kAppBarTextColor)),
                const SizedBox(height: 8),
                Text(subtitle, style: TextStyle(fontSize: 15, color: kAppBarTextColor.withOpacity(0.7), height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ---------- Key Facts Row ---------- */

class _KeyFactsRow extends StatelessWidget {
  final List<_KeyFactItem> facts;
  const _KeyFactsRow({required this.facts});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: facts.map((fact) => Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: fact))).toList(),
    );
  }
}

class _KeyFactItem extends StatelessWidget {
  final String emoji;
  final String number;
  final String label;
  const _KeyFactItem({required this.emoji, required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: kWhiteCardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: kPrimaryDarkPink.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 32)),
          const SizedBox(height: 8),
          Text(number, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: kPrimaryDarkPink)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: kAppBarTextColor), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

/* ---------- Section Title ---------- */

class _SectionTitle extends StatelessWidget {
  final String icon;
  final String text;
  const _SectionTitle({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(icon, style: const TextStyle(fontSize: 24)),
        const SizedBox(width: 10),
        Text(text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: kAppBarTextColor)),
      ],
    );
  }
}

/* ---------- Quick Win Card ---------- */

class _QuickWinCard extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  const _QuickWinCard({required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kWhiteCardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kPrimaryDarkPink.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: kPrimaryDarkPink.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Text(icon, style: const TextStyle(fontSize: 24))),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: kAppBarTextColor)),
                const SizedBox(height: 4),
                Text(description, style: TextStyle(fontSize: 13, color: kAppBarTextColor.withOpacity(0.7), height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ---------- Food Category Card ---------- */

class _FoodCategoryCard extends StatelessWidget {
  final String icon;
  final String category;
  final Color color;
  final String subtitle;
  final List<String> foods;
  const _FoodCategoryCard({
    required this.icon,
    required this.category,
    required this.color,
    required this.subtitle,
    required this.foods,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kWhiteCardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.2), width: 1.5),
        boxShadow: [BoxShadow(color: color.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(icon, style: const TextStyle(fontSize: 28)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(category, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: color)),
                    const SizedBox(height: 2),
                    Text(subtitle, style: TextStyle(fontSize: 12, color: kAppBarTextColor.withOpacity(0.6))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: foods.map((food) => _FoodChip(label: food, color: color)).toList(),
          ),
        ],
      ),
    );
  }
}

class _FoodChip extends StatelessWidget {
  final String label;
  final Color color;
  const _FoodChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color.withOpacity(0.9))),
    );
  }
}

/* ---------- Meal Card ---------- */

class _MealCard extends StatelessWidget {
  final String mealTime;
  final String icon;
  final String time;
  final String meal;
  final String benefits;
  const _MealCard({
    required this.mealTime,
    required this.icon,
    required this.time,
    required this.meal,
    required this.benefits,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kWhiteCardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kPrimaryDarkPink.withOpacity(0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [kPrimaryDarkPink.withOpacity(0.2), kPrimaryDarkPink.withOpacity(0.1)],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(child: Text(icon, style: const TextStyle(fontSize: 28))),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(mealTime, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kAppBarTextColor)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: kPrimaryDarkPink.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(time, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: kPrimaryDarkPink)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(meal, style: TextStyle(fontSize: 14, color: kAppBarTextColor.withOpacity(0.85), height: 1.3)),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: kPrimaryDarkPink.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(benefits, style: TextStyle(fontSize: 11, color: kPrimaryDarkPink.withOpacity(0.8), fontStyle: FontStyle.italic)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ---------- Tips Card ---------- */

class _TipsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kPrimaryDarkPink.withOpacity(0.06), kPrimaryDarkPink.withOpacity(0.02)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kPrimaryDarkPink.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('💡', style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 10),
              const Text('Important Tips', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kAppBarTextColor)),
            ],
          ),
          const SizedBox(height: 14),
          _TipRow(icon: '🐢', text: 'Introduce fiber gradually & drink plenty of water to avoid bloating'),
          _TipRow(icon: '🌈', text: 'Variety matters—aim for 20–30 different plant foods per week'),
          _TipRow(icon: '👂', text: 'Notice how foods make you feel; adjust your diet gently'),
          _TipRow(icon: '⏱️', text: 'Give changes 2–4 weeks to show effects on your gut health'),
        ],
      ),
    );
  }
}

class _TipRow extends StatelessWidget {
  final String icon;
  final String text;
  const _TipRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: TextStyle(fontSize: 14, color: kAppBarTextColor.withOpacity(0.8), height: 1.4))),
        ],
      ),
    );
  }
}

/* ---------- Progress Tracker Card ---------- */

class _ProgressTrackerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: kWhiteCardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kPrimaryDarkPink.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('📊', style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 10),
              const Text('Track Your Progress', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kAppBarTextColor)),
            ],
          ),
          const SizedBox(height: 14),
          _ProgressRow(label: 'Energy levels', emoji: '⚡'),
          _ProgressRow(label: 'Digestion comfort', emoji: '😊'),
          _ProgressRow(label: 'Mood stability', emoji: '🌈'),
          _ProgressRow(label: 'Sleep quality', emoji: '😴'),
          const SizedBox(height: 8),
          Text(
            'Keep a simple journal to notice positive changes over time!',
            style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic, color: kAppBarTextColor.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }
}

class _ProgressRow extends StatelessWidget {
  final String label;
  final String emoji;
  const _ProgressRow({required this.label, required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: TextStyle(fontSize: 14, color: kAppBarTextColor.withOpacity(0.8)))),
          Container(
            width: 80,
            height: 6,
            decoration: BoxDecoration(
              color: kPrimaryDarkPink.withOpacity(0.1),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ],
      ),
    );
  }
}