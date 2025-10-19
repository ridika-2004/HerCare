import 'package:flutter/material.dart';
import '../../models/cycle_data.dart';
import '../../services/date_formatter.dart';
import '../../services/calendar_calculator.dart';
import '../../constants/app_constants.dart';
import '../common_widgets.dart';

class CalendarSection extends StatefulWidget {
  final CycleData cycleData;
  
  const CalendarSection({
    super.key,
    required this.cycleData,
  });
  
  @override
  _CalendarSectionState createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSection> {
  DateTime _selectedDate = DateTime.now();
  
  void _goToPreviousMonth() {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1);
    });
  }
  
  void _goToNextMonth() {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1);
    });
  }
  
  void _goToToday() {
    setState(() {
      _selectedDate = DateTime.now();
    });
  }
  
  List<DateTime> _getMonthDays() {
    final firstDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
    final lastDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month + 1, 0);
    
    // Start from the first day of the week that contains the first day of month
    final firstDayOfCalendar = firstDayOfMonth.subtract(
      Duration(days: firstDayOfMonth.weekday - 1)
    );
    
    // End at the last day of the week that contains the last day of month
    final lastDayOfCalendar = lastDayOfMonth.add(
      Duration(days: DateTime.daysPerWeek - lastDayOfMonth.weekday)
    );
    
    List<DateTime> days = [];
    DateTime currentDay = firstDayOfCalendar;
    
    while (currentDay.isBefore(lastDayOfCalendar) || currentDay.isAtSameMomentAs(lastDayOfCalendar)) {
      days.add(currentDay);
      currentDay = currentDay.add(Duration(days: 1));
    }
    
    return days;
  }

Color _getDateColor(DateTime date) {
  // CRITICAL: Only show cycle data if user has actually recorded periods
  if (widget.cycleData.periodHistory.isEmpty) {
    return Colors.transparent;
  }
  
  final lastRecord = widget.cycleData.lastPeriod!;
  
  // DEBUG: Print period history count
  print('=== PERIOD HISTORY COUNT: ${widget.cycleData.periodHistory.length} ===');
  
  // Period Days - ALWAYS show if we have period data
  if (CalendarCalculator.isPeriodDay(
    date, 
    lastRecord.startDate, 
    lastRecord.periodDuration
  )) {
    print('✅ Period day: $date');
    return AppConstants.primaryColor;
  }
  
  // 🎯 CHANGE: Show ovulation/fertility even with 1 period (using default calculations)
  final hasEnoughData = widget.cycleData.periodHistory.length >= 2;
  
  if (hasEnoughData) {
    print('✅ Using PERSONAL cycle data for predictions (${widget.cycleData.periodHistory.length} records)');
  } else {
    print('✅ Using DEFAULT cycle calculations (28-day cycle)');
  }
  
  print('✅ Ovulation date: ${widget.cycleData.ovulationDate}');
  print('✅ Next period date: ${widget.cycleData.nextPeriodDate}');
  
  // Ovulation Days (3-day window) - Show even with 1 period
  if (CalendarCalculator.isOvulationDay(date, widget.cycleData.ovulationDate)) {
    print('🥚 OVULATION DAY: $date');
    return Color(0xFFFF8C42);
  }
  
  // Fertile Window (6-day window before next period) - Show even with 1 period
  if (CalendarCalculator.isFertileWindow(date, widget.cycleData.nextPeriodDate)) {
    print('💖 FERTILE DAY: $date');
    return Color(0xFFFFB3D9);
  }
  
  return Colors.transparent;
}

  String _getDateTooltip(DateTime date) {
    // Only show tooltips if we have period data
    if (widget.cycleData.periodHistory.isNotEmpty) {
      final lastRecord = widget.cycleData.lastPeriod!;
      
      if (CalendarCalculator.isPeriodDay(
        date, 
        lastRecord.startDate, 
        lastRecord.periodDuration
      )) {
        return 'Period Day';
      }
      
      // Only show ovulation/fertility tooltips if we have enough data
      if (widget.cycleData.periodHistory.length >= 2) {
        if (CalendarCalculator.isOvulationDay(date, widget.cycleData.ovulationDate)) {
          return 'Ovulation Day';
        }
        
        if (CalendarCalculator.isFertileWindow(date, widget.cycleData.nextPeriodDate)) {
          return 'Fertile Window';
        }
      }
    }
    
    return 'Normal Day';
  }
  
  @override
  Widget build(BuildContext context) {
    final monthDays = _getMonthDays();
    final today = DateTime.now();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cycle Calendar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppConstants.textColor,
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
              // Month Navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _goToPreviousMonth,
                    icon: Icon(Icons.chevron_left, color: AppConstants.primaryColor),
                    tooltip: 'Previous month',
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormatter.formatDate(_selectedDate, 'MMMM yyyy'),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.textColor,
                          ),
                        ),
                        if (_selectedDate.month != today.month || _selectedDate.year != today.year)
                          TextButton(
                            onPressed: _goToToday,
                            child: Text(
                              'Today',
                              style: TextStyle(
                                color: AppConstants.primaryColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: _goToNextMonth,
                    icon: Icon(Icons.chevron_right, color: AppConstants.primaryColor),
                    tooltip: 'Next month',
                  ),
                ],
              ),
              SizedBox(height: 16),
              
              // Weekday Headers
              Row(
                children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                    .map((day) => Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              day,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
              
              // Calendar Grid
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemCount: monthDays.length,
                itemBuilder: (context, index) {
                  final date = monthDays[index];
                  final isCurrentMonth = date.month == _selectedDate.month;
                  final isToday = date.day == today.day && 
                                 date.month == today.month && 
                                 date.year == today.year;
                  
                  final bgColor = _getDateColor(date);
                  final tooltip = _getDateTooltip(date);
                  
                  return Tooltip(
                    message: tooltip,
                    child: Container(
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(8),
                        border: isToday
                            ? Border.all(color: AppConstants.primaryColor, width: 2)
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          '${date.day}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isCurrentMonth 
                                ? (bgColor != Colors.transparent ? Colors.white : AppConstants.textColor)
                                : Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              _buildLegend(),
              SizedBox(height: 8),
              _buildCycleInfo(),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildLegend() {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [
        CommonWidgets.buildLegendItem('Period', AppConstants.primaryColor),
        CommonWidgets.buildLegendItem('Ovulation', Color(0xFFFF8C42)),
        CommonWidgets.buildLegendItem('Fertility', Color(0xFFFFB3D9)),
      ],
    );
  }
  
Widget _buildCycleInfo() {
  final hasPeriodData = widget.cycleData.periodHistory.isNotEmpty;
  final hasPersonalData = widget.cycleData.periodHistory.length >= 2;
  
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppConstants.lightBackground,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppConstants.primaryColor, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cycle Information:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppConstants.textColor,
          ),
        ),
        SizedBox(height: 4),
        
        if (!hasPeriodData) ...[
          Text(
            '• No period data recorded yet',
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
          Text(
            '• Record your first period to see predictions',
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
        ] else ...[
          // Safe access to lastPeriodDate using null check
          Text(
            '• Last Period: ${DateFormatter.formatDate(widget.cycleData.lastPeriodDate!, 'MMM dd')}',
            style: TextStyle(fontSize: 12),
          ),
          
          // 🎯 CHANGE: Show predictions even with 1 period
          Text(
            '• Next Period: ${DateFormatter.formatDate(widget.cycleData.nextPeriodDate, 'MMM dd')}',
            style: TextStyle(fontSize: 12),
          ),
          Text(
            '• Ovulation: ${DateFormatter.formatDate(widget.cycleData.ovulationDate, 'MMM dd')}',
            style: TextStyle(fontSize: 12),
          ),
          
          if (hasPersonalData) ...[
            Text(
              '• Your Cycle: ${widget.cycleData.cycleLength} days (based on ${widget.cycleData.periodHistory.length} records)',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.green),
            ),
          ] else ...[
            Text(
              '• Cycle: ${widget.cycleData.cycleLength} days (default - record more periods for personal accuracy)',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.orange),
            ),
          ],
        ],
      ],
    ),
  );
}
}