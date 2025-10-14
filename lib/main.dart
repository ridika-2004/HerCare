import 'package:flutter/material.dart';
import 'week1.dart';
import 'week2.dart';
import 'week3.dart';

void main() {
  runApp(const PregnancyApp());
}

class PregnancyApp extends StatelessWidget {
  const PregnancyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pregnancy Journey',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: const Color(0xFFFFF5F7),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.pink),
        ),
      ),
      home: const PregnancyWeeksPage(),
    );
  }
}

class PregnancyWeeksPage extends StatelessWidget {
  const PregnancyWeeksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pregnancy Weeks 🩷"),
        centerTitle: true,
        backgroundColor: Colors.pink.shade100,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Select a week to view your journey details",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.6,
                  ),
                  itemCount: 40,
                  itemBuilder: (context, index) {
                    final weekNumber = index + 1;
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade50,
                        foregroundColor: Colors.pink.shade800,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (weekNumber == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const Week1Page()),
                          );
                        } else if (weekNumber == 2) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const Week2Page()),
                          );
                        } else if (weekNumber == 3) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const Week3Page()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Week $weekNumber page not created yet!')),
                          );
                        }
                      },
                      child: Text("Week $weekNumber"),
                    );
                  },
                ),
              ),
              const Text(
                "© 2025 Pregnancy Journey | Made with 💗 for moms-to-be",
                style: TextStyle(color: Colors.black54, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
