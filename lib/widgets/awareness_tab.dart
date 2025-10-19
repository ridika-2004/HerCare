import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class AwarenessTab extends StatelessWidget {
  const AwarenessTab({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Menstrual Health & Hygiene',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppConstants.textColor,
              ),
            ),
            SizedBox(height: 16),
            _buildAwarenessCardWithImage(
              'How to Use Sanitary Pads',
              '📌',
              'Change every 4-8 hours depending on flow',
              _buildPadUsageSteps(),
            ),
            SizedBox(height: 16),
            _buildAwarenessCardWithImage(
              'Pad Change Schedule',
              '⏰',
              'Based on your flow intensity',
              _buildChangeSchedule(),
            ),
            SizedBox(height: 16),
            _buildAwarenessCardWithImage(
              'Menstrual Hygiene Steps',
              '🚿',
              'Daily hygiene practices',
              _buildHygieneSteps(),
            ),
            SizedBox(height: 16),
            _buildAwarenessCardWithImage(
              'Proper Disposal',
              '♻️',
              'Safe and hygienic disposal methods',
              _buildDisposalSteps(),
            ),
            SizedBox(height: 16),
            _buildAwarenessCardWithImage(
              'Health Warning Signs',
              '⚠️',
              'When to consult a doctor',
              _buildWarningSignsInfo(),
            ),
            SizedBox(height: 16),
            _buildAwarenessCardWithImage(
              'Nutrition Tips',
              '🍎',
              'Foods to eat during your period',
              _buildNutritionTips(),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  
  Widget _buildAwarenessCardWithImage(
      String title, String emoji, String subtitle, Widget contentWidget) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppConstants.lightPink,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppConstants.primaryColor, AppConstants.secondaryColor],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Text(emoji, style: TextStyle(fontSize: 36)),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: contentWidget,
          ),
        ],
      ),
    );
  }
  
  Widget _buildPadUsageSteps() {
    return Column(
      children: [
        _buildVisualStep(1, '🧼', 'Wash Hands', 'Clean hands before use'),
        SizedBox(height: 12),
        _buildVisualStep(2, '📦', 'Remove Packaging', 'Unwrap pad carefully'),
        SizedBox(height: 12),
        _buildVisualStep(3, '🎯', 'Position Correctly', 'Align with underwear center'),
        SizedBox(height: 12),
        _buildVisualStep(4, '🔒', 'Secure Adhesive', 'Press firmly to stick in place'),
        SizedBox(height: 12),
        _buildVisualStep(5, '👖', 'Wear Normally', 'Ready to wear comfortably'),
      ],
    );
  }
  
  Widget _buildChangeSchedule() {
    return Column(
      children: [
        _buildFlowCard(
          '💧 Light Flow',
          '6-8 Hours',
          'Use if discharge is minimal',
          Color(0xFFFFE0F0),
        ),
        SizedBox(height: 12),
        _buildFlowCard(
          '💗 Regular Flow',
          '4-6 Hours',
          'Normal menstrual flow',
          Color(0xFFFFB3D9),
        ),
        SizedBox(height: 12),
        _buildFlowCard(
          '❤️ Heavy Flow',
          '2-4 Hours',
          'Change more frequently',
          AppConstants.primaryColor,
          textColor: Colors.white,
        ),
        SizedBox(height: 12),
        _buildFlowCard(
          '⏰ Night Time',
          '8+ Hours',
          'Use overnight protection',
          Color(0xFF1A0033),
          textColor: Colors.white,
        ),
      ],
    );
  }
  
  Widget _buildFlowCard(String title, String time, String description, Color bgColor, {Color? textColor}) {
    textColor ??= AppConstants.textColor;
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppConstants.primaryColor, width: 1),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Change every: $time',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: textColor.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildHygieneSteps() {
    return Column(
      children: [
        _buildVisualStep(1, '🚿', 'Daily Bath/Shower', 'Clean yourself daily with warm water'),
        SizedBox(height: 12),
        _buildVisualStep(2, '💧', 'Wash Genitals', 'Use mild soap and water gently'),
        SizedBox(height: 12),
        _buildVisualStep(3, '🧴', 'Use Warm Water', 'Lukewarm water is gentler on skin'),
        SizedBox(height: 12),
        _buildVisualStep(4, '🧻', 'Pat Dry', 'Use clean cloth to dry'),
        SizedBox(height: 12),
        _buildVisualStep(5, '👕', 'Wear Cotton Underwear', 'Breathable fabric reduces infections'),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppConstants.lightBackground,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppConstants.primaryColor, width: 1),
          ),
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Text('⚠️', style: TextStyle(fontSize: 20)),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Avoid douching and strong scents. Never use soap inside the vagina.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppConstants.textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildDisposalSteps() {
    return Column(
      children: [
        _buildVisualStep(1, '📰', 'Get Newspaper/Paper', 'Use clean newspaper or tissue'),
        SizedBox(height: 12),
        _buildVisualStep(2, '🛡️', 'Wrap the Pad', 'Cover pad completely with paper'),
        SizedBox(height: 12),
        _buildVisualStep(3, '🚮', 'Use Trash Bin', 'Dispose in a trash can with lid'),
        SizedBox(height: 12),
        _buildVisualStep(4, '🚫', 'Never Flush', 'Do NOT throw in toilet'),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppConstants.lightBackground,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppConstants.primaryColor, width: 1),
          ),
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Text('💡', style: TextStyle(fontSize: 20)),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Proper disposal prevents plumbing issues and environmental damage.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppConstants.textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildWarningSignsInfo() {
    return Column(
      children: [
        _buildWarningCard('🩸 Heavy Bleeding', 'Soaking more than 1 pad/hour'),
        SizedBox(height: 12),
        _buildWarningCard('😣 Severe Cramps', 'Pain that doesn\'t go away with medicine'),
        SizedBox(height: 12),
        _buildWarningCard('🤢 Severe Nausea', 'Persistent vomiting or dizziness'),
        SizedBox(height: 12),
        _buildWarningCard('😠 Mood Swings', 'Extreme emotional changes'),
        SizedBox(height: 12),
        _buildWarningCard('🌡️ Fever', 'Temperature above 101°F (38.3°C)'),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFFF8C42), width: 1),
          ),
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Text('📞', style: TextStyle(fontSize: 20)),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Consult a doctor if symptoms persist for more than 2-3 days.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppConstants.textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildWarningCard(String title, String description) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFCE4EC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppConstants.primaryColor, width: 1),
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.textColor,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildNutritionTips() {
    return Column(
      children: [
        _buildNutritionCard('🥬 Iron-Rich Foods', 'Spinach, kale, red meat\nHelps prevent anemia'),
        SizedBox(height: 12),
        _buildNutritionCard('🥛 Calcium & Magnesium', 'Milk, yogurt, almonds\nReduces cramps'),
        SizedBox(height: 12),
        _buildNutritionCard('🍌 Potassium', 'Bananas, potatoes\nHelps with bloating'),
        SizedBox(height: 12),
        _buildNutritionCard('💧 Stay Hydrated', 'Drink 8-10 glasses of water\nImproves circulation'),
        SizedBox(height: 12),
        _buildNutritionCard('🍫 Dark Chocolate', 'Contains antioxidants\nImproves mood'),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFFF8C42), width: 1),
          ),
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Text('✅', style: TextStyle(fontSize: 20)),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Avoid caffeine, sugar & processed foods which worsen symptoms.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppConstants.textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildNutritionCard(String food, String benefits) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFF9C4),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFFFB800), width: 1),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            food,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppConstants.textColor,
            ),
          ),
          SizedBox(height: 6),
          Text(
            benefits,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildVisualStep(int step, String emoji, String title, String description) {
    return Container(
      decoration: BoxDecoration(
        color: AppConstants.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppConstants.lightPink, width: 1),
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppConstants.primaryColor, AppConstants.secondaryColor],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                '$step',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Text(emoji, style: TextStyle(fontSize: 28)),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.textColor,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}