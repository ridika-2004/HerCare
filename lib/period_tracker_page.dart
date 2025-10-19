import 'package:flutter/material.dart';
import './models/cycle_data.dart';
import './models/symptom_tracker.dart';
import './widgets/tracker_tab.dart';
import './widgets/awareness_tab.dart';
import './widgets/doctors_tab.dart';
import './constants/app_constants.dart';

class PeriodTrackerPage extends StatefulWidget {
  const PeriodTrackerPage({super.key});

  @override
  _PeriodTrackerPageState createState() => _PeriodTrackerPageState();
}

class _PeriodTrackerPageState extends State<PeriodTrackerPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  CycleData _cycleData = CycleData(
    lastPeriodDate: DateTime.now().subtract(Duration(days: 5)),
  );
  SymptomTracker _symptomTracker = SymptomTracker();

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

  void _updateCycleData(CycleData newCycleData) {
    setState(() {
      _cycleData = newCycleData;
    });
  }

  void _updateSymptomTracker(SymptomTracker newSymptomTracker) {
    setState(() {
      _symptomTracker = newSymptomTracker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppConstants.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppConstants.primaryColor,
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
            TrackerTab(
              cycleData: _cycleData,
              symptomTracker: _symptomTracker,
              onCycleDataChanged: _updateCycleData,
              onSymptomTrackerChanged: _updateSymptomTracker,
            ),
            AwarenessTab(),
            DoctorsTab(),
          ],
        ),
      ),
    );
  }
}