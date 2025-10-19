import 'package:flutter/material.dart';
import '../../models/cycle_data.dart';
import '../../services/date_formatter.dart';
import '../../services/calendar_calculator.dart';
import '../../constants/app_constants.dart';
import '../common_widgets.dart';

class CalendarSection extends StatefulWidget {
  final CycleData cycleData;
  
  const CalendarSection({
    Key? key,
    required this.cycleData,
  }) : super(key: key);
  
  @override
  _CalendarSectionState createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSection> {
  DateTime selectedDate = DateTime.now();
  
  @override
  Widget build(BuildContext context) {
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
              Text(
                DateFormatter.formatDate(selectedDate, 'MMMM yyyy'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.textColor,
                ),
              ),
              SizedBox(height: 16),
              _buildCalendarGrid(),
              SizedBox(height: 16),
              _buildLegend(),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildCalendarGrid() {
    return GridView.builder(
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
            DateTime(selectedDate.year, selectedDate.month, 1).weekday +
            2;
        if (day < 1 || day > 31) return SizedBox();

        DateTime cellDate = DateTime(selectedDate.year, selectedDate.month, day);
        bool isToday = cellDate.day == DateTime.now().day &&
            cellDate.month == DateTime.now().month &&
            cellDate.year == DateTime.now().year;

        bool isPeriodDay = CalendarCalculator.isPeriodDay(
          cellDate, 
          widget.cycleData.lastPeriodDate, 
          widget.cycleData.periodDuration
        );

        bool isOvulationDay = CalendarCalculator.isOvulationDay(
          cellDate, 
          widget.cycleData.ovulationDate
        );

        bool isFertileWindow = CalendarCalculator.isFertileWindow(
          cellDate, 
          widget.cycleData.nextPeriodDate
        );

        Color bgColor = Colors.transparent;
        if (isPeriodDay) {
          bgColor = AppConstants.primaryColor;
        } else if (isOvulationDay) {
          bgColor = Color(0xFFFF8C42);
        } else if (isFertileWindow) {
          bgColor = AppConstants.lightPink;
        }

        return Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
            border: isToday
                ? Border.all(color: AppConstants.primaryColor, width: 2)
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
                    : AppConstants.textColor,
              ),
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildLegend() {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [
        CommonWidgets.buildLegendItem('Period', AppConstants.primaryColor),
        CommonWidgets.buildLegendItem('Ovulation', Color(0xFFFF8C42)),
        CommonWidgets.buildLegendItem('Fertility', AppConstants.lightPink),
      ],
    );
  }
}