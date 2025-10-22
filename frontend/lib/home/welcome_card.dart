import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class WelcomeCard extends StatelessWidget {
  final String? userEmail;

  const WelcomeCard({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
          color: kWhiteCardColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15,
                offset: const Offset(0, 5)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome to HerCare 💖",
                style: GoogleFonts.poppins(
                    color: kAppBarTextColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(
                userEmail != null
                    ? "Logged in as $userEmail"
                    : "Your companion for complete wellness.",
                style: GoogleFonts.poppins(
                    color: Colors.grey[600], fontSize: 16)),
          ],
        ),
      ),
    );
  }
}