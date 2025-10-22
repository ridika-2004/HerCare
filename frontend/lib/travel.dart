import 'package:flutter/material.dart';
import 'constants/colors.dart';

class VirtualNatureWalkPage extends StatelessWidget {
  const VirtualNatureWalkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: kAppBarTextColor),
        title: const Text('Virtual Nature Walk', style: TextStyle(color: kAppBarTextColor, fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeroCard(
              emoji: '🏞️',
              title: 'Forest Path',
              subtitle: 'Slow down. Breathe. Imagine walking among pine trees with soft forest sounds.',
            ),
            const SizedBox(height: 20),
            _SceneryRow(
              scenes: [
                _SceneItem(emoji: '🌲', label: 'Pine Forest'),
                _SceneItem(emoji: '🦋', label: 'Butterfly Meadow'),
                _SceneItem(emoji: '🏔️', label: 'Mountain Trail'),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'How to use',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: kAppBarTextColor),
            ),
            const SizedBox(height: 12),
            _InstructionCard(
              icon: '🧘',
              step: 'Step 1',
              description: 'Sit comfortably and close your eyes for 3–5 minutes.',
            ),
            const SizedBox(height: 12),
            _InstructionCard(
              icon: '🫁',
              step: 'Step 2',
              description: 'Inhale for 4s, hold 2s, exhale 6s—repeat slowly.',
            ),
            const SizedBox(height: 12),
            _InstructionCard(
              icon: '🌿',
              step: 'Step 3',
              description: 'Visualize the trail, rustling leaves, and distant birds.',
            ),
            const SizedBox(height: 12),
            _InstructionCard(
              icon: '🎵',
              step: 'Optional',
              description: 'Play soft nature audio from the Music tab for deeper immersion.',
            ),
            const SizedBox(height: 24),
            _BenefitsCard(),
          ],
        ),
      ),
    );
  }
}

class VisualRelaxationPage extends StatelessWidget {
  const VisualRelaxationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: kAppBarTextColor),
        title: const Text('Visual Relaxation', style: TextStyle(color: kAppBarTextColor, fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeroCard(
              emoji: '🌊',
              title: 'Ocean View',
              subtitle: 'Imagine gentle waves and warm light. Let your gaze soften and your shoulders drop.',
            ),
            const SizedBox(height: 20),
            _SceneryRow(
              scenes: [
                _SceneItem(emoji: '🌅', label: 'Sunrise Beach'),
                _SceneItem(emoji: '☁️', label: 'Cloud Gazing'),
                _SceneItem(emoji: '✨', label: 'Starlit Sky'),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Quick 4-minute routine',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: kAppBarTextColor),
            ),
            const SizedBox(height: 12),
            _TimelineCard(
              time: '1 min',
              icon: '⏱️',
              title: 'Box Breathing',
              description: 'Breathe in a 4-4-4-4 pattern. Inhale, hold, exhale, hold.',
            ),
            const SizedBox(height: 12),
            _TimelineCard(
              time: '2 min',
              icon: '🌊',
              title: 'Wave Visualization',
              description: 'Visualize waves rolling in sync with your breath. Feel the rhythm.',
            ),
            const SizedBox(height: 12),
            _TimelineCard(
              time: '1 min',
              icon: '💭',
              title: 'Gratitude Moment',
              description: 'Think of one calming memory that brings you peace.',
            ),
            const SizedBox(height: 24),
            _TipsCard(),
          ],
        ),
      ),
    );
  }
}

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

class _SceneryRow extends StatelessWidget {
  final List<_SceneItem> scenes;
  const _SceneryRow({required this.scenes});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: scenes.map((scene) => Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: scene))).toList(),
    );
  }
}

class _SceneItem extends StatelessWidget {
  final String emoji;
  final String label;
  const _SceneItem({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: kWhiteCardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: kPrimaryDarkPink.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 32)),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: kAppBarTextColor), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _InstructionCard extends StatelessWidget {
  final String icon;
  final String step;
  final String description;
  const _InstructionCard({required this.icon, required this.step, required this.description});

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
                Text(step, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: kPrimaryDarkPink)),
                const SizedBox(height: 4),
                Text(description, style: TextStyle(fontSize: 14, color: kAppBarTextColor.withOpacity(0.8), height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineCard extends StatelessWidget {
  final String time;
  final String icon;
  final String title;
  final String description;
  const _TimelineCard({required this.time, required this.icon, required this.title, required this.description});

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
          Column(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [kPrimaryDarkPink.withOpacity(0.2), kPrimaryDarkPink.withOpacity(0.1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(child: Text(icon, style: const TextStyle(fontSize: 26))),
              ),
              const SizedBox(height: 6),
              Text(time, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: kPrimaryDarkPink)),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kAppBarTextColor)),
                const SizedBox(height: 6),
                Text(description, style: TextStyle(fontSize: 14, color: kAppBarTextColor.withOpacity(0.7), height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BenefitsCard extends StatelessWidget {
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
              Text('✨', style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 10),
              const Text('Benefits', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kAppBarTextColor)),
            ],
          ),
          const SizedBox(height: 14),
          _BenefitRow(icon: '🧠', text: 'Reduces mental fatigue and stress'),
          _BenefitRow(icon: '💆', text: 'Lowers blood pressure naturally'),
          _BenefitRow(icon: '😌', text: 'Enhances mood and emotional balance'),
        ],
      ),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  final String icon;
  final String text;
  const _BenefitRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: TextStyle(fontSize: 14, color: kAppBarTextColor.withOpacity(0.8)))),
        ],
      ),
    );
  }
}

class _TipsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kPrimaryDarkPink.withOpacity(0.06), kPrimaryDarkPink.withOpacity(0.02)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
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
              const Text('Pro Tips', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kAppBarTextColor)),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            '• Practice in a quiet, dimly lit space\n'
                '• Use headphones for better immersion\n'
                '• Try different scenes to find what works\n'
                '• Consistency is key—aim for daily practice',
            style: TextStyle(fontSize: 14, color: kAppBarTextColor.withOpacity(0.8), height: 1.5),
          ),
        ],
      ),
    );
  }
}