import 'package:flutter/material.dart';
import './models/cycle_data.dart';
import './models/symptom_tracker.dart';
import './services/storage_service.dart';
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
  CycleData _cycleData = CycleData();
  SymptomTracker _symptomTracker = SymptomTracker();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });
    
    final cycleData = await StorageService.loadCycleData();
    setState(() {
      _cycleData = cycleData;
      _isLoading = false;
    });
  }

void _updateCycleData(CycleData newCycleData) async {
  setState(() {
    _cycleData = newCycleData; // Replace the entire instance
  });
  await StorageService.saveCycleData(newCycleData);
}

  void _updateSymptomTracker(SymptomTracker newSymptomTracker) {
    setState(() {
      _symptomTracker = newSymptomTracker;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppConstants.backgroundColor,
        body: Center(
          child: CircularProgressIndicator(
            color: AppConstants.primaryColor,
          ),
        ),
      );
    }

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