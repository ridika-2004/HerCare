import 'package:flutter/material.dart';
import 'step1.dart';
import 'step2.dart';
import 'step3.dart';
import 'step4.dart';
import 'step5.dart';



class BreastCancerCheckApp extends StatelessWidget {
  const BreastCancerCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Breast Cancer Self-Check",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFFF6F91),
        scaffoldBackgroundColor: const Color(0xFFFFF5F7),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Arial'),
        ),
      ),
      home: const BreastCheckHomePage(),
    );
  }
}

class BreastCheckHomePage extends StatelessWidget {
  const BreastCheckHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      const Step1Page(),
      const Step2Page(),
      const Step3Page(),
      const Step4Page(),
      const Step5Page(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Breast Cancer Self-Check 💗",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFF6F91),
        elevation: 2,
        shadowColor: Colors.pink.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              "Follow each step carefully for your monthly self-exam 👩‍⚕️",
              style: TextStyle(
                fontSize: 16,
                color: Colors.pink.shade700,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // 💗 Steps Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 18,
                  childAspectRatio: 1.1,
                ),
                itemCount: steps.length,
                itemBuilder: (context, index) {
                  final stepNumber = index + 1;
                  final List<String> emojis = [
                    "🪞",
                    "🙆‍♀️",
                    "🛏️",
                    "🚿",
                    "📝"
                  ];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => steps[index]),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.pink.shade100.withOpacity(0.9),
                            Colors.pink.shade50,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pink.shade200.withOpacity(0.4),
                            blurRadius: 8,
                            offset: const Offset(2, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            emojis[index],
                            style: const TextStyle(fontSize: 28),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Step $stepNumber",
                            style: const TextStyle(
                              color: Color(0xFFAD1457),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Tap to view details",
                            style: TextStyle(
                              color: Colors.pink.shade700.withOpacity(0.7),
                              fontSize: 13,
                            ),
                          ),
                        ],
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
                "© 2025 Self-Check Guide\nMade with 💗 for women's health",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}