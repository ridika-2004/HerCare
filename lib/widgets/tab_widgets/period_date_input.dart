import 'package:flutter/material.dart';
import '../../models/cycle_data.dart';
import '../../services/date_formatter.dart';
import '../../constants/app_constants.dart';
import '../../services/storage_service.dart';

class PeriodDateInput extends StatefulWidget {
  final CycleData cycleData;
  final Function(CycleData) onCycleDataChanged;
  
  const PeriodDateInput({
    super.key,
    required this.cycleData,
    required this.onCycleDataChanged,
  });
  
  @override
  _PeriodDateInputState createState() => _PeriodDateInputState();
}

class _PeriodDateInputState extends State<PeriodDateInput> {
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  bool _isFirstPeriod = true;
  String? _cycleInfoText;

  @override
  void initState() {
    super.initState();
    _checkIfFirstPeriod();
  }

  void _checkIfFirstPeriod() {
    _isFirstPeriod = widget.cycleData.periodHistory.isEmpty;
    if (!_isFirstPeriod && widget.cycleData.lastPeriod != null) {
      final lastRecord = widget.cycleData.lastPeriod!;
      final daysBetween = _selectedStartDate?.difference(lastRecord.startDate).inDays;
      if (daysBetween != null && daysBetween > 0) {
        setState(() {
          _cycleInfoText = 'Your cycle was $daysBetween days long';
        });
      }
    }
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppConstants.primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppConstants.textColor,
            ), dialogTheme: DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      setState(() {
        _selectedStartDate = picked;
        // Auto-set end date to 5 days after start if not set
        if (_selectedEndDate == null || _selectedEndDate!.isBefore(picked)) {
          _selectedEndDate = picked.add(Duration(days: 4));
        }
      });
      _updateCycleInfo();
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    if (_selectedStartDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select start date first'),
          backgroundColor: AppConstants.primaryColor,
        ),
      );
      return;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate ?? _selectedStartDate!.add(Duration(days: 4)),
      firstDate: _selectedStartDate!,
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppConstants.primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppConstants.textColor,
            ), dialogTheme: DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      setState(() {
        _selectedEndDate = picked;
      });
      _updateCycleInfo();
    }
  }

void _updateCycleInfo() {
  if (_selectedStartDate != null && widget.cycleData.periodHistory.isNotEmpty) {
    final lastRecord = widget.cycleData.lastPeriod!;
    final daysBetween = _selectedStartDate!.difference(lastRecord.startDate).inDays;
    
    setState(() {
      if (daysBetween > 0) {
        _cycleInfoText = 'Your cycle was $daysBetween days long';
        _isFirstPeriod = false;
      } else {
        _cycleInfoText = null;
      }
    });
  } else {
    setState(() {
      _cycleInfoText = null;
    });
  }
}

void _savePeriod() async {
  if (_selectedStartDate == null || _selectedEndDate == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please select both start and end dates'),
        backgroundColor: Colors.orange,
      ),
    );
    return;
  }

  if (_selectedEndDate!.isBefore(_selectedStartDate!)) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('End date cannot be before start date'),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  // Show loading indicator
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          CircularProgressIndicator(color: Colors.white),
          SizedBox(width: 12),
          Text('Saving period...'),
        ],
      ),
      backgroundColor: AppConstants.primaryColor,
    ),
  );

  try {
    // Create new CycleData instance
    final newCycleData = CycleData(
      periodHistory: List.from(widget.cycleData.periodHistory),
      predictedNextPeriod: widget.cycleData.predictedNextPeriod,
      predictedCycleLength: widget.cycleData.predictedCycleLength,
    );
    
    // Add the new period record
    newCycleData.addPeriodRecord(_selectedStartDate!, _selectedEndDate!);

    // Save to storage (which will sync with backend)
    await StorageService.saveCycleData(newCycleData);

    // Update UI
    widget.onCycleDataChanged(newCycleData);

    // Show success message
    String message = 'Period saved successfully!';
    if (_cycleInfoText != null) {
      message += '\n$_cycleInfoText';
    } else if (_isFirstPeriod) {
      message += '\nThis is your first recorded period. Cycle length will be calculated after your next period.';
    }

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppConstants.primaryColor,
        duration: Duration(seconds: 3),
      ),
    );

    // Reset form
    setState(() {
      _selectedStartDate = null;
      _selectedEndDate = null;
      _cycleInfoText = null;
    });

  } catch (e) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to save period: $e'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Track Your Period',
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
              // Start Date Input
              GestureDetector(
                onTap: () => _selectStartDate(context),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppConstants.primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: AppConstants.primaryColor),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _selectedStartDate != null
                              ? 'Period Start: ${DateFormatter.formatDate(_selectedStartDate!, 'MMM dd, yyyy')}'
                              : 'Select Period Start Date',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppConstants.textColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12),
              
              // End Date Input
              GestureDetector(
                onTap: () => _selectEndDate(context),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppConstants.primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: AppConstants.primaryColor),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _selectedEndDate != null
                              ? 'Period End: ${DateFormatter.formatDate(_selectedEndDate!, 'MMM dd, yyyy')}'
                              : 'Select Period End Date',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppConstants.textColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Cycle Information
              if (_cycleInfoText != null) ...[
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppConstants.lightBackground,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppConstants.primaryColor, width: 1),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info, color: AppConstants.primaryColor),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _cycleInfoText!,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppConstants.textColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ] else if (_isFirstPeriod && _selectedStartDate != null) ...[
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF3E0),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFFFF8C42), width: 1),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.lightbulb_outline, color: Color(0xFFFF8C42)),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'This is your first period record. Cycle length will be calculated after your next period.',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppConstants.textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              
              SizedBox(height: 16),
              
              // Save Button
              ElevatedButton.icon(
                onPressed: _savePeriod,
                icon: Icon(Icons.save),
                label: Text('Save Period'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.primaryColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
        
        // Period History
        if (widget.cycleData.periodHistory.isNotEmpty) ...[
          SizedBox(height: 16),
          Text(
            'Period History',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppConstants.textColor,
            ),
          ),
          SizedBox(height: 8),
          ...widget.cycleData.periodHistory.reversed.take(3).map((record) => 
            Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.circle, color: AppConstants.primaryColor, size: 8),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '${DateFormatter.formatDate(record.startDate, 'MMM dd')} - ${DateFormatter.formatDate(record.endDate, 'MMM dd, yyyy')}',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  if (record.cycleLength > 0)
                    Text(
                      '${record.cycleLength} days',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}