import 'package:flutter/material.dart';
import 'constants/colors.dart';

class GentleYogaFlowPage extends StatelessWidget {
  const GentleYogaFlowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _ExerciseScaffold(
      title: 'Gentle Yoga Flow',
      hero: const _HeroCard(
        emoji: '🧘‍♀️',
        title: 'Slow Flow',
        subtitle: 'A calm, beginner-friendly routine to release stress and improve mobility.',
      ),
      children: [
        _PoseGallery(poses: [
          _PoseItem(emoji: '🐱', label: 'Cat-Cow'),
          _PoseItem(emoji: '🙏', label: 'Child\'s Pose'),
          _PoseItem(emoji: '🦵', label: 'Low Lunge'),
        ]),
        const SizedBox(height: 24),
        const _SectionTitle(icon: '⏱️', text: 'Routine (10–12 mins)'),
        const SizedBox(height: 12),
        _TimelineStep(
          time: '2 min',
          icon: '🫁',
          title: 'Box Breathing',
          description: 'Breathe in a 4-4-4-4 pattern to center yourself.',
        ),
        const SizedBox(height: 10),
        _TimelineStep(
          time: '2 min',
          icon: '🐱',
          title: 'Cat–Cow Flow',
          description: 'Slow spine waves to warm up your back.',
        ),
        const SizedBox(height: 10),
        _TimelineStep(
          time: '3 min',
          icon: '🙏',
          title: 'Child\'s Pose & Thread the Needle',
          description: 'Release tension in shoulders and hips (both sides).',
        ),
        const SizedBox(height: 10),
        _TimelineStep(
          time: '3 min',
          icon: '🦵',
          title: 'Low Lunge & Half Split',
          description: 'Open hip flexors and hamstrings (both sides).',
        ),
        const SizedBox(height: 10),
        _TimelineStep(
          time: '2 min',
          icon: '😌',
          title: 'Savasana',
          description: 'Complete relaxation—let everything go.',
        ),
        const SizedBox(height: 24),
        _TipsCard(
          icon: '✨',
          title: 'Gentle Reminders',
          tips: [
            'Move with your breath—never force a pose',
            'If anything hurts, skip it or modify',
            'Keep shoulders soft and jaw relaxed',
            'Use props like cushions for support',
          ],
        ),
      ],
    );
  }
}

class WalkingTrailsPage extends StatelessWidget {
  const WalkingTrailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _ExerciseScaffold(
      title: 'Walking Trails',
      hero: const _HeroCard(
        emoji: '🚶‍♀️',
        title: 'Mindful Walk',
        subtitle: 'Outdoor (or indoor) walking focused on breath, posture, and presence.',
      ),
      children: [
        _EnvironmentOptions(options: [
          _OptionItem(emoji: '🌳', label: 'Park Trail'),
          _OptionItem(emoji: '🏡', label: 'Neighborhood'),
          _OptionItem(emoji: '🏠', label: 'Indoor'),
        ]),
        const SizedBox(height: 24),
        const _SectionTitle(icon: '📋', text: 'Quick Plan (12–15 mins)'),
        const SizedBox(height: 12),
        _PhaseCard(
          phase: 'Warm-up',
          duration: '2 min',
          icon: '🔆',
          description: 'Stand tall, roll shoulders back, and set an easy comfortable pace.',
        ),
        const SizedBox(height: 12),
        _PhaseCard(
          phase: 'Main Walk',
          duration: '8–10 min',
          icon: '🚶‍♀️',
          description: 'Maintain steady pace. Breathe: 4 steps inhale, 6 steps exhale.',
        ),
        const SizedBox(height: 12),
        _PhaseCard(
          phase: 'Cool Down',
          duration: '2–3 min',
          icon: '🧊',
          description: 'Slow your pace gradually, gentle calf and hamstring stretches.',
        ),
        const SizedBox(height: 24),
        _MindfulnessCard(),
        const SizedBox(height: 16),
        _BenefitsCard(
          icon: '💚',
          benefits: [
            'Improves cardiovascular health',
            'Boosts mood and reduces anxiety',
            'Increases daily energy levels',
            'Enhances mindfulness practice',
          ],
        ),
      ],
    );
  }
}

class DeskStretchesPage extends StatelessWidget {
  const DeskStretchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _ExerciseScaffold(
      title: 'Desk Stretches',
      hero: const _HeroCard(
        emoji: '💺',
        title: 'Quick Break',
        subtitle: '3–5 minute reset for neck, shoulders, wrists, and hips right at your desk.',
      ),
      children: [
        _BodyPartsRow(parts: [
          _BodyPartItem(emoji: '🦴', label: 'Neck'),
          _BodyPartItem(emoji: '💪', label: 'Shoulders'),
          _BodyPartItem(emoji: '🤲', label: 'Wrists'),
          _BodyPartItem(emoji: '🪑', label: 'Hips'),
        ]),
        const SizedBox(height: 24),
        const _SectionTitle(icon: '⚡', text: '3–5 Minute Flow'),
        const SizedBox(height: 12),
        _StretchCard(
          icon: '🦴',
          area: 'Neck',
          instruction: 'Slow circles, 3 rotations each direction. Keep movements gentle.',
        ),
        const SizedBox(height: 10),
        _StretchCard(
          icon: '💪',
          area: 'Shoulders',
          instruction: '10 shoulder rolls backward, then cross-body stretch (15s each side).',
        ),
        const SizedBox(height: 10),
        _StretchCard(
          icon: '🤲',
          area: 'Wrists',
          instruction: 'Flex and extend wrists, then gentle circles in both directions.',
        ),
        const SizedBox(height: 10),
        _StretchCard(
          icon: '🧘',
          area: 'Spine',
          instruction: 'Seated twist—hold each side for 15–20 seconds with deep breaths.',
        ),
        const SizedBox(height: 10),
        _StretchCard(
          icon: '🪑',
          area: 'Hips',
          instruction: 'Figure-4 stretch—cross ankle over knee, hold 20–30s each side.',
        ),
        const SizedBox(height: 24),
        _ProTipCard(),
        const SizedBox(height: 16),
        _FrequencyCard(),
      ],
    );
  }
}

/* ---------- Shared Scaffold ---------- */

class _ExerciseScaffold extends StatelessWidget {
  final String title;
  final Widget hero;
  final List<Widget> children;

  const _ExerciseScaffold({
    required this.title,
    required this.hero,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: kAppBarTextColor),
        title: Text(title, style: const TextStyle(color: kAppBarTextColor, fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hero,
            const SizedBox(height: 20),
            ...children,
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

/* ---------- Gallery Components ---------- */

class _PoseGallery extends StatelessWidget {
  final List<_PoseItem> poses;
  const _PoseGallery({required this.poses});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: poses.map((pose) => Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: pose))).toList(),
    );
  }
}

class _PoseItem extends StatelessWidget {
  final String emoji;
  final String label;
  const _PoseItem({required this.emoji, required this.label});

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
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: kAppBarTextColor), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _EnvironmentOptions extends StatelessWidget {
  final List<_OptionItem> options;
  const _EnvironmentOptions({required this.options});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: options.map((opt) => Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: opt))).toList(),
    );
  }
}

class _OptionItem extends StatelessWidget {
  final String emoji;
  final String label;
  const _OptionItem({required this.emoji, required this.label});

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
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: kAppBarTextColor), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _BodyPartsRow extends StatelessWidget {
  final List<_BodyPartItem> parts;
  const _BodyPartsRow({required this.parts});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: parts.map((part) => Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 3), child: part))).toList(),
    );
  }
}

class _BodyPartItem extends StatelessWidget {
  final String emoji;
  final String label;
  const _BodyPartItem({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
      decoration: BoxDecoration(
        color: kWhiteCardColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: kPrimaryDarkPink.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: kAppBarTextColor), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

/* ---------- Section Components ---------- */

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

class _TimelineStep extends StatelessWidget {
  final String time;
  final String icon;
  final String title;
  final String description;
  const _TimelineStep({required this.time, required this.icon, required this.title, required this.description});

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
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [kPrimaryDarkPink.withOpacity(0.2), kPrimaryDarkPink.withOpacity(0.1)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(child: Text(icon, style: const TextStyle(fontSize: 24))),
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

class _PhaseCard extends StatelessWidget {
  final String phase;
  final String duration;
  final String icon;
  final String description;
  const _PhaseCard({required this.phase, required this.duration, required this.icon, required this.description});

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
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: kPrimaryDarkPink.withOpacity(0.1),
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
                    Text(phase, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kAppBarTextColor)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: kPrimaryDarkPink.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(duration, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: kPrimaryDarkPink)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(description, style: TextStyle(fontSize: 13, color: kAppBarTextColor.withOpacity(0.7), height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StretchCard extends StatelessWidget {
  final String icon;
  final String area;
  final String instruction;
  const _StretchCard({required this.icon, required this.area, required this.instruction});

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
                Text(area, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: kPrimaryDarkPink)),
                const SizedBox(height: 4),
                Text(instruction, style: TextStyle(fontSize: 13, color: kAppBarTextColor.withOpacity(0.8), height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ---------- Info Cards ---------- */

class _TipsCard extends StatelessWidget {
  final String icon;
  final String title;
  final List<String> tips;
  const _TipsCard({required this.icon, required this.title, required this.tips});

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
              Text(icon, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 10),
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kAppBarTextColor)),
            ],
          ),
          const SizedBox(height: 14),
          ...tips.map((tip) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• ', style: TextStyle(fontSize: 14, color: kAppBarTextColor.withOpacity(0.8))),
                Expanded(child: Text(tip, style: TextStyle(fontSize: 14, color: kAppBarTextColor.withOpacity(0.8), height: 1.4))),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _MindfulnessCard extends StatelessWidget {
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
              Text('🧠', style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 10),
              const Text('Mindfulness Cues', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kAppBarTextColor)),
            ],
          ),
          const SizedBox(height: 14),
          _MindfulRow(number: '5', text: 'Things you see'),
          _MindfulRow(number: '4', text: 'Things you feel (texture, temperature)'),
          _MindfulRow(number: '3', text: 'Things you hear'),
          const SizedBox(height: 8),
          Text('Let thoughts pass by like clouds—no judgment.', style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic, color: kAppBarTextColor.withOpacity(0.7))),
        ],
      ),
    );
  }
}

class _MindfulRow extends StatelessWidget {
  final String number;
  final String text;
  const _MindfulRow({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: kPrimaryDarkPink.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: Text(number, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: kPrimaryDarkPink))),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: TextStyle(fontSize: 14, color: kAppBarTextColor.withOpacity(0.8)))),
        ],
      ),
    );
  }
}

class _BenefitsCard extends StatelessWidget {
  final String icon;
  final List<String> benefits;
  const _BenefitsCard({required this.icon, required this.benefits});

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
              Text(icon, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 10),
              const Text('Benefits', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kAppBarTextColor)),
            ],
          ),
          const SizedBox(height: 14),
          ...benefits.map((benefit) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Text('✓', style: TextStyle(fontSize: 16, color: kPrimaryDarkPink, fontWeight: FontWeight.w700)),
                const SizedBox(width: 10),
                Expanded(child: Text(benefit, style: TextStyle(fontSize: 14, color: kAppBarTextColor.withOpacity(0.8)))),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _ProTipCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kPrimaryDarkPink.withOpacity(0.08), kPrimaryDarkPink.withOpacity(0.03)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kPrimaryDarkPink.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kWhiteCardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text('💡', style: const TextStyle(fontSize: 32)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Pro Tip', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kAppBarTextColor)),
                const SizedBox(height: 6),
                Text(
                  'Set a timer every 60–90 minutes to stand, sip water, and stretch for 60 seconds.',
                  style: TextStyle(fontSize: 14, color: kAppBarTextColor.withOpacity(0.8), height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FrequencyCard extends StatelessWidget {
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
              Text('📅', style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 10),
              const Text('Recommended Frequency', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kAppBarTextColor)),
            ],
          ),
          const SizedBox(height: 14),
          _FrequencyRow(icon: '⏰', text: 'Every 60–90 minutes during work'),
          _FrequencyRow(icon: '🎯', text: 'Minimum 3–4 times per day'),
          _FrequencyRow(icon: '✨', text: 'Morning & evening for best results'),
        ],
      ),
    );
  }
}

class _FrequencyRow extends StatelessWidget {
  final String icon;
  final String text;
  const _FrequencyRow({required this.icon, required this.text});

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