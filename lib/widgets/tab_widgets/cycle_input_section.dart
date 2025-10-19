import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/cycle_data.dart';
import '../../services/date_formatter.dart';
import '../../constants/app_constants.dart';

class CycleInputSection extends StatefulWidget {
  final CycleData cycleData;
  final Function(CycleData) onCycleDataChanged;
  
  const CycleInputSection({
    Key? key,
    required this.cycleData,
    required this.onCycleDataChanged,
  }) : super(key: key);
  
  @override
  _CycleInputSectionState createState() => _CycleInputSectionState();
}

class _CycleInputSectionState extends State<CycleInputSection> {
  final TextEditingController _cycleLengthController = TextEditingController();
  final TextEditingController _periodDurationController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _cycleLengthController.text = widget.cycleData.cycleLength.toString();
    _periodDurationController.text = widget.cycleData.periodDuration.toString();
  }
  
  @override
  void dispose() {
    _cycleLengthController.dispose();
    _periodDurationController.dispose();
    super.dispose();
  }
  
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.cycleData.lastPeriodDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppConstants.primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppConstants.textColor,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null && picked != widget.cycleData.lastPeriodDate) {
      widget.onCycleDataChanged(
        widget.cycleData.copyWith(lastPeriodDate: picked)
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cycle Information',
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
              _buildDatePicker(context),
              SizedBox(height: 12),
              _buildCycleLengthInput(),
              SizedBox(height: 12),
              _buildPeriodDurationInput(),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildDatePicker(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
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
            Text(
              'Last Period: ${DateFormatter.formatDate(widget.cycleData.lastPeriodDate, 'MMM dd')}',
              style: TextStyle(
                fontSize: 14,
                color: AppConstants.textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCycleLengthInput() {
    return TextField(
      controller: _cycleLengthController,
      decoration: InputDecoration(
        labelText: 'Cycle Length (days)',
        labelStyle: TextStyle(color: AppConstants.primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppConstants.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppConstants.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppConstants.secondaryColor, width: 2),
        ),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (value) {
        int? newValue = int.tryParse(value);
        if (newValue != null && newValue >= 20 && newValue <= 40) {
          widget.onCycleDataChanged(
            widget.cycleData.copyWith(cycleLength: newValue)
          );
        } else {
          _cycleLengthController.text = widget.cycleData.cycleLength.toString();
        }
      },
    );
  }
  
  Widget _buildPeriodDurationInput() {
    return TextField(
      controller: _periodDurationController,
      decoration: InputDecoration(
        labelText: 'Period Duration (days)',
        labelStyle: TextStyle(color: AppConstants.primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppConstants.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppConstants.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppConstants.secondaryColor, width: 2),
        ),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (value) {
        int? newValue = int.tryParse(value);
        if (newValue != null && newValue >= 1 && newValue <= 10) {
          widget.onCycleDataChanged(
            widget.cycleData.copyWith(periodDuration: newValue)
          );
        } else {
          _periodDurationController.text = widget.cycleData.periodDuration.toString();
        }
      },
    );
  }
}