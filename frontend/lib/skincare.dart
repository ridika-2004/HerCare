import 'package:flutter/material.dart';
import 'constants/colors.dart';

class MorningGlowPage extends StatelessWidget {
  const MorningGlowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _SkinScaffold(
      title: 'Morning Glow (SPF)',
      hero: const _HeroCard(
        emoji: '🌞',
        title: 'Protect & Brighten',
        subtitle: 'A simple AM routine to hydrate, protect, and add glow.',
      ),
      children: [
        _ProductTypeRow(types: [
          _ProductTypeItem(emoji: '🧼', label: 'Cleanse'),
          _ProductTypeItem(emoji: '💧', label: 'Hydrate'),
          _ProductTypeItem(emoji: '🛡️', label: 'Protect'),
        ]),
        const SizedBox(height: 24),
        const _SectionTitle(icon: '⏱️', text: 'Steps (5–7 mins)'),
        const SizedBox(height: 12),
        _SkincareStep(
          stepNumber: '1',
          icon: '🧼',
          title: 'Gentle Cleanser',
          description: 'Wash with lukewarm water to remove overnight oils.',
          timing: '1 min',
        ),
        const SizedBox(height: 10),
        _SkincareStep(
          stepNumber: '2',
          icon: '💦',
          title: 'Hydrating Toner/Mist',
          description: 'Prep skin to absorb serums and lock in moisture.',
          timing: '30 sec',
        ),
        const SizedBox(height: 10),
        _SkincareStep(
          stepNumber: '3',
          icon: '✨',
          title: 'Serum (Vitamin C)',
          description: 'Brightens and protects against environmental damage. Optional.',
          timing: '1 min',
        ),
        const SizedBox(height: 10),
        _SkincareStep(
          stepNumber: '4',
          icon: '🧴',
          title: 'Lightweight Moisturizer',
          description: 'Lock in hydration without feeling heavy.',
          timing: '1 min',
        ),
        const SizedBox(height: 10),
        _SkincareStep(
          stepNumber: '5',
          icon: '☀️',
          title: 'Sunscreen SPF 30+',
          description: 'Essential final step—apply generously to face, neck & ears.',
          timing: '1-2 min',
          isHighlight: true,
        ),
        const SizedBox(height: 24),
        _TipsCard(
          icon: '💡',
          title: 'Pro Tips',
          tips: [
            _TipItem(icon: '⏰', text: 'Reapply SPF every 2–3 hours when outdoors'),
            _TipItem(icon: '🌤️', text: 'Wear SPF even on cloudy days—UV rays penetrate clouds'),
            _TipItem(icon: '👂', text: 'Don\'t forget neck, ears, and hands'),
            _TipItem(icon: '⏱️', text: 'Wait 1-2 minutes between each layer for best absorption'),
          ],
        ),
        const SizedBox(height: 16),
        _BenefitsCard(
          benefits: [
            _BenefitItem(icon: '🌟', text: 'Prevents premature aging'),
            _BenefitItem(icon: '🛡️', text: 'Protects from UV damage'),
            _BenefitItem(icon: '💎', text: 'Maintains skin brightness'),
          ],
        ),
      ],
    );
  }
}

class NightRepairPage extends StatelessWidget {
  const NightRepairPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _SkinScaffold(
      title: 'Night Repair',
      hero: const _HeroCard(
        emoji: '🌙',
        title: 'Restore & Soothe',
        subtitle: 'PM routine focused on barrier support and gentle actives.',
      ),
      children: [
        _ProductTypeRow(types: [
          _ProductTypeItem(emoji: '🧽', label: 'Deep Clean'),
          _ProductTypeItem(emoji: '🔬', label: 'Active'),
          _ProductTypeItem(emoji: '🌿', label: 'Repair'),
        ]),
        const SizedBox(height: 24),
        const _SectionTitle(icon: '🌙', text: 'Steps (6–10 mins)'),
        const SizedBox(height: 12),
        _SkincareStep(
          stepNumber: '1',
          icon: '🧽',
          title: 'Cleanser (Double Cleanse)',
          description: 'Oil cleanser first if wearing makeup/SPF, then gentle water-based cleanser.',
          timing: '2 min',
        ),
        const SizedBox(height: 10),
        _SkincareStep(
          stepNumber: '2',
          icon: '💧',
          title: 'Hydrating Essence/Toner',
          description: 'Restore pH balance and prep for actives.',
          timing: '30 sec',
        ),
        const SizedBox(height: 10),
        _SkincareStep(
          stepNumber: '3',
          icon: '🔬',
          title: 'Serum (Active)',
          description: 'Niacinamide or Retinol—alternate nights. Start slow with actives.',
          timing: '1-2 min',
          isHighlight: true,
        ),
        const SizedBox(height: 10),
        _SkincareStep(
          stepNumber: '4',
          icon: '🧴',
          title: 'Richer Moisturizer',
          description: 'Thicker formula to support overnight repair.',
          timing: '1 min',
        ),
        const SizedBox(height: 10),
        _SkincareStep(
          stepNumber: '5',
          icon: '🌿',
          title: 'Occlusive Balm (Optional)',
          description: 'Spot-treat dry areas to seal in moisture.',
          timing: '30 sec',
        ),
        const SizedBox(height: 24),
        _ActivesInfoCard(),
        const SizedBox(height: 16),
        _TipsCard(
          icon: '⚠️',
          title: 'Important Reminders',
          tips: [
            _TipItem(icon: '🐢', text: 'Introduce actives slowly—start 2-3x per week'),
            _TipItem(icon: '🧪', text: 'Patch test new products on inner arm first'),
            _TipItem(icon: '🌙', text: 'Never mix retinol with vitamin C or AHAs/BHAs'),
            _TipItem(icon: '☀️', text: 'Always wear SPF next day after using retinol'),
          ],
        ),
      ],
    );
  }
}

class HydrationBoostPage extends StatelessWidget {
  const HydrationBoostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _SkinScaffold(
      title: 'Hydration Boost',
      hero: const _HeroCard(
        emoji: '💧',
        title: '5-Minute Mask',
        subtitle: 'A quick, skin-soothing reset anytime you feel dry or tight.',
      ),
      children: [
        _MaskTypeRow(types: [
          _MaskTypeItem(emoji: '🧊', label: 'Cooling'),
          _MaskTypeItem(emoji: '💦', label: 'Hydrating'),
          _MaskTypeItem(emoji: '😌', label: 'Calming'),
        ]),
        const SizedBox(height: 24),
        const _SectionTitle(icon: '⚡', text: 'Quick Routine'),
        const SizedBox(height: 12),
        _MaskStep(
          stepNumber: '1',
          icon: '💦',
          title: 'Prep with Mist',
          description: 'Dampen your face with hydrating toner or facial mist.',
          duration: '30 sec',
        ),
        const SizedBox(height: 10),
        _MaskStep(
          stepNumber: '2',
          icon: '😌',
          title: 'Apply Hydrating Mask',
          description: 'Use gel or cream mask. Relax for 5-10 minutes.',
          duration: '5-10 min',
          isHighlight: true,
        ),
        const SizedBox(height: 10),
        _MaskStep(
          stepNumber: '3',
          icon: '🧴',
          title: 'Seal with Moisturizer',
          description: 'Remove excess mask, then lock everything in with your moisturizer.',
          duration: '1 min',
        ),
        const SizedBox(height: 24),
        _WhenToUseCard(),
        const SizedBox(height: 16),
        _TipsCard(
          icon: '💡',
          title: 'Masking Tips',
          tips: [
            _TipItem(icon: '💧', text: 'Apply on damp skin for better absorption'),
            _TipItem(icon: '❌', text: 'Avoid over-exfoliation on the same day'),
            _TipItem(icon: '🧊', text: 'Store mask in fridge for extra cooling effect'),
            _TipItem(icon: '📅', text: 'Use 2-3 times per week for best results'),
          ],
        ),
        const SizedBox(height: 16),
        _IngredientsCard(),
      ],
    );
  }
}

/* ---------- Shared Scaffold ---------- */

class _SkinScaffold extends StatelessWidget {
  final String title;
  final Widget hero;
  final List<Widget> children;
  const _SkinScaffold({required this.title, required this.hero, required this.children});

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
          children: [hero, const SizedBox(height: 20), ...children],
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

/* ---------- Product Type Rows ---------- */

class _ProductTypeRow extends StatelessWidget {
  final List<_ProductTypeItem> types;
  const _ProductTypeRow({required this.types});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: types.map((type) => Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: type))).toList(),
    );
  }
}

class _ProductTypeItem extends StatelessWidget {
  final String emoji;
  final String label;
  const _ProductTypeItem({required this.emoji, required this.label});

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

class _MaskTypeRow extends StatelessWidget {
  final List<_MaskTypeItem> types;
  const _MaskTypeRow({required this.types});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: types.map((type) => Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: type))).toList(),
    );
  }
}

class _MaskTypeItem extends StatelessWidget {
  final String emoji;
  final String label;
  const _MaskTypeItem({required this.emoji, required this.label});

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

/* ---------- Skincare Step Card ---------- */

class _SkincareStep extends StatelessWidget {
  final String stepNumber;
  final String icon;
  final String title;
  final String description;
  final String timing;
  final bool isHighlight;
  const _SkincareStep({
    required this.stepNumber,
    required this.icon,
    required this.title,
    required this.description,
    required this.timing,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kWhiteCardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isHighlight ? kPrimaryDarkPink.withOpacity(0.3) : kPrimaryDarkPink.withOpacity(0.1),
          width: isHighlight ? 2 : 1,
        ),
        boxShadow: isHighlight
            ? [BoxShadow(color: kPrimaryDarkPink.withOpacity(0.15), blurRadius: 16, offset: const Offset(0, 6))]
            : null,
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
                    colors: isHighlight
                        ? [kPrimaryDarkPink.withOpacity(0.3), kPrimaryDarkPink.withOpacity(0.15)]
                        : [kPrimaryDarkPink.withOpacity(0.2), kPrimaryDarkPink.withOpacity(0.1)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(child: Text(icon, style: const TextStyle(fontSize: 24))),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: kPrimaryDarkPink.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(stepNumber, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: kPrimaryDarkPink)),
              ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kAppBarTextColor)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: kPrimaryDarkPink.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(timing, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: kPrimaryDarkPink)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(description, style: TextStyle(fontSize: 13, color: kAppBarTextColor.withOpacity(0.7), height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MaskStep extends StatelessWidget {
  final String stepNumber;
  final String icon;
  final String title;
  final String description;
  final String duration;
  final bool isHighlight;
  const _MaskStep({
    required this.stepNumber,
    required this.icon,
    required this.title,
    required this.description,
    required this.duration,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return _SkincareStep(
      stepNumber: stepNumber,
      icon: icon,
      title: title,
      description: description,
      timing: duration,
      isHighlight: isHighlight,
    );
  }
}

/* ---------- Info Cards ---------- */

class _TipsCard extends StatelessWidget {
  final String icon;
  final String title;
  final List<_TipItem> tips;
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
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tip.icon, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 10),
                Expanded(child: Text(tip.text, style: TextStyle(fontSize: 14, color: kAppBarTextColor.withOpacity(0.8), height: 1.4))),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _TipItem {
  final String icon;
  final String text;
  const _TipItem({required this.icon, required this.text});
}

class _BenefitsCard extends StatelessWidget {
  final List<_BenefitItem> benefits;
  const _BenefitsCard({required this.benefits});

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
              const Text('Key Benefits', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kAppBarTextColor)),
            ],
          ),
          const SizedBox(height: 14),
          ...benefits.map((benefit) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Text(benefit.icon, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 10),
                Expanded(child: Text(benefit.text, style: TextStyle(fontSize: 14, color: kAppBarTextColor.withOpacity(0.8)))),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _BenefitItem {
  final String icon;
  final String text;
  const _BenefitItem({required this.icon, required this.text});
}

class _ActivesInfoCard extends StatelessWidget {
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
              Text('🔬', style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 10),
              const Text('Active Ingredients Guide', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kAppBarTextColor)),
            ],
          ),
          const SizedBox(height: 14),
          _ActiveRow(
            name: 'Niacinamide',
            emoji: '💎',
            benefit: 'Brightens, minimizes pores, balances oil',
          ),
          _ActiveRow(
            name: 'Retinol',
            emoji: '⭐',
            benefit: 'Anti-aging, smooths texture, boosts cell turnover',
          ),
        ],
      ),
    );
  }
}

class _ActiveRow extends StatelessWidget {
  final String name;
  final String emoji;
  final String benefit;
  const _ActiveRow({required this.name, required this.emoji, required this.benefit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: kPrimaryDarkPink.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(child: Text(emoji, style: const TextStyle(fontSize: 20))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: kPrimaryDarkPink)),
                const SizedBox(height: 2),
                Text(benefit, style: TextStyle(fontSize: 13, color: kAppBarTextColor.withOpacity(0.7), height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WhenToUseCard extends StatelessWidget {
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
              Text('⏰', style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 10),
              const Text('When to Use', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kAppBarTextColor)),
            ],
          ),
          const SizedBox(height: 14),
          _WhenRow(icon: '✈️', text: 'Before/after flights or travel'),
          _WhenRow(icon: '❄️', text: 'During dry or cold weather'),
          _WhenRow(icon: '😴', text: 'After a long day or poor sleep'),
          _WhenRow(icon: '🏖️', text: 'Post-sun exposure (not sunburn!)'),
        ],
      ),
    );
  }
}

class _WhenRow extends StatelessWidget {
  final String icon;
  final String text;
  const _WhenRow({required this.icon, required this.text});

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

class _IngredientsCard extends StatelessWidget {
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
              Text('🧪', style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 10),
              const Text('Look for These Ingredients', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kAppBarTextColor)),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _IngredientChip(label: 'Hyaluronic Acid'),
              _IngredientChip(label: 'Glycerin'),
              _IngredientChip(label: 'Aloe Vera'),
              _IngredientChip(label: 'Ceramides'),
              _IngredientChip(label: 'Peptides'),
              _IngredientChip(label: 'Squalane'),
            ],
          ),
        ],
      ),
    );
  }
}

class _IngredientChip extends StatelessWidget {
  final String label;
  const _IngredientChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: kPrimaryDarkPink.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kPrimaryDarkPink.withOpacity(0.2)),
      ),
      child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: kPrimaryDarkPink.withOpacity(0.9))),
    );
  }
}
