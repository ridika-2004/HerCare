import 'package:flutter/material.dart';

class PeriodTrackerPage extends StatefulWidget {
  @override
  _PeriodTrackerPageState createState() => _PeriodTrackerPageState();
}

class _PeriodTrackerPageState extends State<PeriodTrackerPage>
    with TickerProviderStateMixin {
  DateTime selectedDate = DateTime.now();
  DateTime lastPeriodDate = DateTime.now().subtract(Duration(days: 5));
  int cycleLength = 28;
  int periodDuration = 5;
  Set<String> selectedSymptoms = {};
  bool isPlaying = false;
  late TabController _tabController;

  DateTime get nextPeriodDate => lastPeriodDate.add(Duration(days: cycleLength));
  DateTime get ovulationDate =>
      lastPeriodDate.add(Duration(days: cycleLength ~/ 2));
  int get daysUntilNext => nextPeriodDate.difference(DateTime.now()).inDays;
  int get daysSinceLast => DateTime.now().difference(lastPeriodDate).inDays;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String formatDate(DateTime date, String format) {
    if (format == 'MMM dd') {
      return '${_getMonthName(date.month)} ${date.day.toString().padLeft(2, '0')}';
    } else if (format == 'MMMM yyyy') {
      return '${_getMonthName(date.month)} ${date.year}';
    }
    return '';
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color(0xFFFAF5F7),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFFF6B9D),
          title: Text(
            'HerCare',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Tracker'),
              Tab(text: 'Awareness'),
              Tab(text: 'Doctors'),
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildTrackerTab(),
            _buildAwarenessTab(),
            _buildDoctorsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackerTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCycleStatusCard(),
            SizedBox(height: 24),
            _buildQuickStats(),
            SizedBox(height: 24),
            _buildCalendarSection(),
            SizedBox(height: 24),
            _buildMusicRelaxationSection(),
            SizedBox(height: 24),
            _buildHealthTipsSection(),
            SizedBox(height: 24),
            _buildSymptomTracker(),
            SizedBox(height: 24),
            _buildCalendarActionsSection(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCycleStatusCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF6B9D), Color(0xFFC2185B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFFF6B9D).withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          )
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Current Cycle Status',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Day $daysSinceLast of Your Cycle',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Container(
                  width: (daysSinceLast / cycleLength * 100)
                      .clamp(0, 100)
                      .toDouble(),
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Next period in $daysUntilNext days',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        _buildStatCard(
            'Last Period', formatDate(lastPeriodDate, 'MMM dd'), 0),
        SizedBox(width: 12),
        _buildStatCard(
            'Next Period', formatDate(nextPeriodDate, 'MMM dd'), 1),
        SizedBox(width: 12),
        _buildStatCard('Cycle Length', '$cycleLength days', 2),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, int index) {
    List<Color> colors = [
      Color(0xFFE91E63),
      Color(0xFFC2185B),
      Color(0xFFAD1457),
    ];

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: colors[index].withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: colors[index],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cycle Calendar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              )
            ],
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                formatDate(selectedDate, 'MMMM yyyy'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: 35,
                itemBuilder: (context, index) {
                  int day = index -
                      DateTime(selectedDate.year, selectedDate.month, 1)
                          .weekday +
                      2;
                  if (day < 1 || day > 31) return SizedBox();

                  DateTime cellDate =
                  DateTime(selectedDate.year, selectedDate.month, day);
                  bool isToday = cellDate.day == DateTime.now().day &&
                      cellDate.month == DateTime.now().month &&
                      cellDate.year == DateTime.now().year;

                  bool isPeriodDay = cellDate.isAfter(lastPeriodDate) &&
                      cellDate.isBefore(
                          lastPeriodDate.add(Duration(days: periodDuration)));

                  bool isOvulationDay = cellDate
                      .difference(ovulationDate.subtract(Duration(days: 1)))
                      .inDays >=
                      0 &&
                      cellDate
                          .difference(
                          ovulationDate.add(Duration(days: 1)))
                          .inDays <=
                          0;

                  bool isFertileWindow = cellDate.isAfter(
                      nextPeriodDate.subtract(Duration(days: 5))) &&
                      cellDate.isBefore(nextPeriodDate.add(Duration(days: 1)));

                  Color bgColor = Colors.transparent;
                  if (isPeriodDay) {
                    bgColor = Color(0xFFFF6B9D); // Pink - Period
                  } else if (isOvulationDay) {
                    bgColor = Color(0xFFFF8C42); // Orange - Ovulation
                  } else if (isFertileWindow) {
                    bgColor = Color(0xFFFFB3D9); // Light Pink - Fertility
                  }

                  return Container(
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(8),
                      border: isToday
                          ? Border.all(color: Color(0xFFFF6B9D), width: 2)
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        '$day',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: (isPeriodDay || isOvulationDay)
                              ? Colors.white
                              : Color(0xFF333333),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  _buildLegendItem('Period', Color(0xFFFF6B9D)),
                  _buildLegendItem('Ovulation', Color(0xFFFF8C42)),
                  _buildLegendItem('Fertility', Color(0xFFFFB3D9)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildMusicRelaxationSection() {
    List<Map<String, String>> relaxationTracks = [
      {'title': 'Calm Meditation', 'duration': '10 min'},
      {'title': 'Nature Sounds', 'duration': '15 min'},
      {'title': 'Deep Relaxation', 'duration': '20 min'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Relaxation Music',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              )
            ],
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            children: List.generate(
              relaxationTracks.length,
                  (index) => Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isPlaying = !isPlaying;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFFF6B9D),
                                  Color(0xFFC2185B)
                                ],
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  relaxationTracks[index]['title']!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF333333),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  relaxationTracks[index]['duration']!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.favorite_border,
                            color: Color(0xFFFF6B9D),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (index < relaxationTracks.length - 1)
                    Divider(height: 1, color: Colors.grey[200]),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHealthTipsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Health Tips',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        SizedBox(height: 12),
        _buildTipCard(
          '💧',
          'Stay Hydrated',
          'Drink 8-10 glasses of water daily to ease cramps and maintain energy levels.',
        ),
        SizedBox(height: 12),
        _buildTipCard(
          '🧘‍♀️',
          'Light Exercise',
          'Gentle yoga or walking can help reduce period pain and improve mood.',
        ),
        SizedBox(height: 12),
        _buildTipCard(
          '🥗',
          'Nutrition',
          'Eat iron-rich foods like leafy greens and nuts to combat fatigue.',
        ),
      ],
    );
  }

  Widget _buildTipCard(String emoji, String title, String description) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(0xFFFFB3D9),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: TextStyle(fontSize: 24)),
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
                    color: Color(0xFF333333),
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

  Widget _buildSymptomTracker() {
    List<String> symptoms = ['Cramps', 'Headache', 'Fatigue', 'Mood', 'Bloating'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Log Your Symptoms',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: symptoms
              .map(
                (symptom) => InkWell(
              onTap: () {
                setState(() {
                  if (selectedSymptoms.contains(symptom)) {
                    selectedSymptoms.remove(symptom);
                  } else {
                    selectedSymptoms.add(symptom);
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: selectedSymptoms.contains(symptom)
                      ? Color(0xFFFF6B9D)
                      : Colors.white,
                  border: Border.all(
                    color: Color(0xFFFF6B9D),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  symptom,
                  style: TextStyle(
                    fontSize: 13,
                    color: selectedSymptoms.contains(symptom)
                        ? Colors.white
                        : Color(0xFFFF6B9D),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildCalendarActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Calendar Actions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Calendar exported to Google Calendar'),
                      backgroundColor: Color(0xFFFF6B9D),
                    ),
                  );
                },
                icon: Icon(Icons.calendar_today),
                label: Text('Export to Google'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF6B9D),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Calendar downloaded as PDF'),
                      backgroundColor: Color(0xFFC2185B),
                    ),
                  );
                },
                icon: Icon(Icons.download),
                label: Text('Download'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFC2185B),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAwarenessTab() {
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
                color: Color(0xFF333333),
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
      String title,
      String emoji,
      String subtitle,
      Widget imageWidget,
      ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xFFFFB3D9),
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
                colors: [Color(0xFFFF6B9D), Color(0xFFC2185B)],
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
            child: imageWidget,
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
        _buildVisualStep(
            4, '🔒', 'Secure Adhesive', 'Press firmly to stick in place'),
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
          Color(0xFFFF6B9D),
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

  Widget _buildFlowCard(
      String title,
      String time,
      String description,
      Color bgColor, {
        Color? textColor,
      }) {
    textColor ??= Color(0xFF333333);
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFFF6B9D), width: 1),
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
        _buildVisualStep(
            1, '🚿', 'Daily Bath/Shower', 'Clean yourself daily with warm water'),
        SizedBox(height: 12),
        _buildVisualStep(2, '💧', 'Wash Genitals', 'Use mild soap and water gently'),
        SizedBox(height: 12),
        _buildVisualStep(3, '🧴', 'Use Warm Water',
            'Lukewarm water is gentler on skin'),
        SizedBox(height: 12),
        _buildVisualStep(4, '🧻', 'Pat Dry', 'Use clean cloth to dry'),
        SizedBox(height: 12),
        _buildVisualStep(
            5, '👕', 'Wear Cotton Underwear', 'Breathable fabric reduces infections'),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFE0F0),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFFF6B9D), width: 1),
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
                    color: Color(0xFF333333),
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
        _buildVisualStep(1, '📰', 'Get Newspaper/Paper',
            'Use clean newspaper or tissue'),
        SizedBox(height: 12),
        _buildVisualStep(2, '🛡️', 'Wrap the Pad',
            'Cover pad completely with paper'),
        SizedBox(height: 12),
        _buildVisualStep(3, '🚮', 'Use Trash Bin',
            'Dispose in a trash can with lid'),
        SizedBox(height: 12),
        _buildVisualStep(4, '🚫', 'Never Flush',
            'Do NOT throw in toilet'),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFE0F0),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFFF6B9D), width: 1),
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
                    color: Color(0xFF333333),
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
        _buildWarningCard(
            '😣 Severe Cramps', 'Pain that doesn\'t go away with medicine'),
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
                    color: Color(0xFF333333),
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
        border: Border.all(color: Color(0xFFFF6B9D), width: 1),
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
                    color: Color(0xFF333333),
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
        _buildNutritionCard(
            '🥛 Calcium & Magnesium', 'Milk, yogurt, almonds\nReduces cramps'),
        SizedBox(height: 12),
        _buildNutritionCard(
            '🍌 Potassium', 'Bananas, potatoes\nHelps with bloating'),
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
                    color: Color(0xFF333333),
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
              color: Color(0xFF333333),
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

  Widget _buildVisualStep(
      int step,
      String emoji,
      String title,
      String description,
      ) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFAF5F7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFFFB3D9), width: 1),
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF6B9D), Color(0xFFC2185B)],
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
                    color: Color(0xFF333333),
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

  Widget _buildDoctorsTab() {
    List<Map<String, dynamic>> doctors = [
      {
        'name': 'Dr. Priya Sharma',
        'specialty': 'Gynecologist',
        'rating': 4.9,
        'reviews': 324,
        'phone': '+880 1711 223344',
        'experience': '15 years',
        'image': '👨‍⚕️'
      },
      {
        'name': 'Dr. Anjali Patel',
        'specialty': 'Reproductive Health',
        'rating': 4.8,
        'reviews': 287,
        'phone': '+880 1811 334455',
        'experience': '12 years',
        'image': '👩‍⚕️'
      },
      {
        'name': 'Dr. Meera Kumar',
        'specialty': 'Women\'s Health Specialist',
        'rating': 4.7,
        'reviews': 215,
        'phone': '+880 1911 445566',
        'experience': '10 years',
        'image': '👨‍⚕️'
      },
      {
        'name': 'Dr. Sana Ahmed',
        'specialty': 'Gynecologist',
        'rating': 4.9,
        'reviews': 412,
        'phone': '+880 1611 556677',
        'experience': '18 years',
        'image': '👩‍⚕️'
      },
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommended Doctors',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            SizedBox(height: 16),
            ...List.generate(
              doctors.length,
                  (index) => Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFFF6B9D),
                                    Color(0xFFC2185B)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  doctors[index]['image'],
                                  style: TextStyle(fontSize: 32),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    doctors[index]['name']!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF333333),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    doctors[index]['specialty']!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFFFF6B9D),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.star,
                                          size: 16, color: Color(0xFFFFB800)),
                                      SizedBox(width: 4),
                                      Text(
                                        '${doctors[index]['rating']} (${doctors[index]['reviews']} reviews)',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Divider(height: 1, color: Colors.grey[200]),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(Icons.work_outline,
                                size: 16, color: Colors.grey[600]),
                            SizedBox(width: 8),
                            Text(
                              '${doctors[index]['experience']} experience',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Calling ${doctors[index]['name']}...'),
                                      backgroundColor: Color(0xFFFF6B9D),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.call),
                                label: Text('Call'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFF6B9D),
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Booking appointment with ${doctors[index]['name']}...'),
                                      backgroundColor: Color(0xFFC2185B),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.calendar_today),
                                label: Text('Book'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Color(0xFFFF6B9D),
                                  side: BorderSide(
                                      color: Color(0xFFFF6B9D), width: 2),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: PeriodTrackerPage(),
      theme: ThemeData(useMaterial3: true),
    ),
  );
}

