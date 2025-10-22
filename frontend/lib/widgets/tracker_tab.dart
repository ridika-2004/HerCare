import 'package:flutter/material.dart';
import '../models/cycle_data.dart';
import '../models/symptom_tracker.dart';
import 'tab_widgets/period_date_input.dart';
import './tab_widgets/cycle_status_card.dart';
import './tab_widgets/calendar_section.dart';
import './tab_widgets/symptom_tracker.dart';
import '../services/date_formatter.dart';
import '../models/relaxation_track.dart';
import 'common_widgets.dart';
import '../constants/app_constants.dart';

class TrackerTab extends StatefulWidget {
  final CycleData cycleData;
  final SymptomTracker symptomTracker;
  final Function(CycleData) onCycleDataChanged;
  final Function(SymptomTracker) onSymptomTrackerChanged;
  
  const TrackerTab({
    super.key,
    required this.cycleData,
    required this.symptomTracker,
    required this.onCycleDataChanged,
    required this.onSymptomTrackerChanged,
  });
  
  @override
  _TrackerTabState createState() => _TrackerTabState();
}

class _TrackerTabState extends State<TrackerTab> {
  bool isPlaying = false;
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PeriodDateInput(
  cycleData: widget.cycleData,
  onCycleDataChanged: widget.onCycleDataChanged,
),
            SizedBox(height: 24),
            CycleStatusCard(cycleData: widget.cycleData),
            SizedBox(height: 24),
            _buildQuickStats(),
            SizedBox(height: 24),
            CalendarSection(cycleData: widget.cycleData),
            SizedBox(height: 24),
            _buildMusicRelaxationSection(),
            SizedBox(height: 24),
            _buildHealthTipsSection(),
            SizedBox(height: 24),
            SymptomTrackerWidget(
              symptomTracker: widget.symptomTracker,
              onSymptomTrackerChanged: widget.onSymptomTrackerChanged,
            ),
            SizedBox(height: 24),
            _buildCalendarActionsSection(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  
Widget _buildQuickStats() {
  return Row(
    children: [
      CommonWidgets.buildStatCard(
        'Last Period', 
        widget.cycleData.lastPeriodDate != null 
            ? DateFormatter.formatDate(widget.cycleData.lastPeriodDate!, 'MMM dd')
            : 'Not set', 
        Color(0xFFE91E63),
      ),
      SizedBox(width: 12),
      CommonWidgets.buildStatCard(
        'Next Period', 
        DateFormatter.formatDate(widget.cycleData.nextPeriodDate, 'MMM dd'), 
        Color(0xFFC2185B),
      ),
      SizedBox(width: 12),
      CommonWidgets.buildStatCard(
        'Cycle Length', 
        '${widget.cycleData.cycleLength} days', 
        Color(0xFFAD1457),
      ),
    ],
  );
}

Widget _buildMusicRelaxationSection() {
  List<RelaxationTrack> relaxationTracks = [
    RelaxationTrack(title: 'Calm Meditation', duration: '10 min'),
    RelaxationTrack(title: 'Nature Sounds', duration: '15 min'),
    RelaxationTrack(title: 'Deep Relaxation', duration: '20 min'),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Relaxation Music',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppConstants.textColor,
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
                                AppConstants.primaryColor,
                                AppConstants.secondaryColor
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
                                relaxationTracks[index].title,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppConstants.textColor,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                relaxationTracks[index].duration,
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
                          color: AppConstants.primaryColor,
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
            color: AppConstants.textColor,
          ),
        ),
        SizedBox(height: 12),
        CommonWidgets.buildTipCard(
          '💧',
          'Stay Hydrated',
          'Drink 8-10 glasses of water daily to ease cramps and maintain energy levels.',
        ),
        SizedBox(height: 12),
        CommonWidgets.buildTipCard(
          '🧘‍♀️',
          'Light Exercise',
          'Gentle yoga or walking can help reduce period pain and improve mood.',
        ),
        SizedBox(height: 12),
        CommonWidgets.buildTipCard(
          '🥗',
          'Nutrition',
          'Eat iron-rich foods like leafy greens and nuts to combat fatigue.',
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
          color: AppConstants.textColor,
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
                    backgroundColor: AppConstants.primaryColor,
                  ),
                );
              },
              icon: Icon(Icons.calendar_today),
              label: Text('Export to Google'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.primaryColor,
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
                    backgroundColor: AppConstants.secondaryColor,
                  ),
                );
              },
              icon: Icon(Icons.download),
              label: Text('Download'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.secondaryColor,
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
}