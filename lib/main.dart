import 'package:flutter/material.dart';
import 'month1.dart';
import 'month2.dart';
import 'month3.dart';
import 'month4.dart';
import 'month5.dart';
import 'month6.dart';
import 'month7.dart';
import 'month8.dart';
import 'month9.dart';

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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
          background: const Color(0xFFFFF5F7),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.pink,
          ),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const PregnancyMonthsPage(),
    );
  }
}

class PregnancyMonthsPage extends StatelessWidget {
  const PregnancyMonthsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> monthPages = const [
      Month1Page(),
      Month2Page(),
      Month3Page(),
      Month4Page(),
      Month5Page(),
      Month6Page(),
      Month7Page(),
      Month8Page(),
      Month9Page(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
                  "Pregnancy Journey 🤰",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF6F61),
                  ),
                  textAlign: TextAlign.center,
                ),
        centerTitle: true,
        backgroundColor: Colors.pink.shade100,
        elevation: 1,
        shadowColor: Colors.pink.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              "Select a month to view your journey details",
              style: TextStyle(
                fontSize: 16,
                color: Colors.pink.shade700,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // 🌸 Smooth grid buttons
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 18,
                  childAspectRatio: 1.2,
                ),
                itemCount: monthPages.length,
                itemBuilder: (context, index) {
                  final monthNumber = index + 1;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => monthPages[index]),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.pink.shade50,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pink.shade100.withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(2, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Month $monthNumber",
                              style: TextStyle(
                                color: Colors.pink.shade800,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Tap to view 💗",
                              style: TextStyle(
                                color: Colors.pink.shade400,
                                fontSize: 13,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // 🌷 Footer
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "© 2025 Pregnancy Journey\nMade with 💗 for moms-to-be",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}
