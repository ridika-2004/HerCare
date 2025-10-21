import 'package:flutter/material.dart';
import '../../models/cycle_data.dart';
import '../../services/date_formatter.dart';
import '../../constants/app_constants.dart';

class CycleInputSection extends StatelessWidget {
  final CycleData cycleData;
  
  const CycleInputSection({
    super.key,
    required this.cycleData,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Current Cycle Overview',
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
              ),
            ],
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              _buildInfoRow('Last Period', 
                cycleData.lastPeriodDate != null 
                  ? DateFormatter.formatDate(cycleData.lastPeriodDate!, 'MMM dd')
                  : 'Not recorded'
              ),
              SizedBox(height: 8),
              _buildInfoRow('Next Period', 
                DateFormatter.formatDate(cycleData.nextPeriodDate, 'MMM dd')
              ),
              SizedBox(height: 8),
              _buildInfoRow('Ovulation', 
                DateFormatter.formatDate(cycleData.ovulationDate, 'MMM dd')
              ),
              SizedBox(height: 8),
              _buildInfoRow('Cycle Length', 
                '${cycleData.cycleLength} days'
              ),
              SizedBox(height: 8),
              _buildInfoRow('Period Duration', 
                '${cycleData.periodDuration} days'
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: AppConstants.textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}