import 'package:flutter/material.dart';

class PeriodTrackerPage extends StatefulWidget {
  @override
  _PeriodTrackerPageState createState() => _PeriodTrackerPageState();
}

class _PeriodTrackerPageState extends State<PeriodTrackerPage> {
  DateTime selectedDate = DateTime.now();
  DateTime lastPeriodDate = DateTime.now().subtract(Duration(days: 5));
  int cycleLength = 28;
  int periodDuration = 5;

  DateTime get nextPeriodDate => lastPeriodDate.add(Duration(days: cycleLength));
  int get daysUntilNext => nextPeriodDate.difference(DateTime.now()).inDays;
  int get daysSinceLast => DateTime.now().difference(lastPeriodDate).inDays;

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
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF5F7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFFF6B9D),
        title: Text(
          'Period Tracker',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
              _buildHealthTipsSection(),
              SizedBox(height: 24),
              _buildSymptomTracker(),
            ],
          ),
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
                  width: (daysSinceLast / cycleLength * 100).clamp(0, 100).toDouble(),
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
        _buildStatCard('Last Period', formatDate(lastPeriodDate, 'MMM dd'), 0),
        SizedBox(width: 12),
        _buildStatCard('Next Period', formatDate(nextPeriodDate, 'MMM dd'), 1),
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
                  int day = index - DateTime(selectedDate.year, selectedDate.month, 1).weekday + 2;
                  if (day < 1 || day > 31) return SizedBox();

                  DateTime cellDate = DateTime(selectedDate.year, selectedDate.month, day);
                  bool isToday = cellDate.day == DateTime.now().day &&
                      cellDate.month == DateTime.now().month &&
                      cellDate.year == DateTime.now().year;
                  bool isPeriodDay = cellDate.isAfter(lastPeriodDate) &&
                      cellDate.isBefore(lastPeriodDate.add(Duration(days: periodDuration)));
                  bool isFertileWindow =
                      cellDate.isAfter(nextPeriodDate.subtract(Duration(days: 5))) &&
                          cellDate.isBefore(nextPeriodDate.add(Duration(days: 1)));

                  Color bgColor = Colors.transparent;
                  if (isPeriodDay) {
                    bgColor = Color(0xFFFF6B9D);
                  } else if (isFertileWindow) {
                    bgColor = Color(0xFFFFB3D9);
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
                          color: isPeriodDay ? Colors.white : Color(0xFF333333),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildLegendItem('Period', Color(0xFFFF6B9D)),
                  _buildLegendItem('Fertile Window', Color(0xFFFFB3D9)),
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
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color(0xFFFF6B9D),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  symptom,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFFFF6B9D),
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
}

void main() {
  runApp(
    MaterialApp(
      home: PeriodTrackerPage(),
      theme: ThemeData(useMaterial3: true),
    ),
  );
}
