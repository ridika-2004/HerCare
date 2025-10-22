import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? userEmail;
  final VoidCallback onLogout;
  final VoidCallback onSignIn;

  const HomeAppBar({
    super.key,
    required this.userEmail,
    required this.onLogout,
    required this.onSignIn,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Text(
        "HerCare",
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      actions: [
        TextButton(
          onPressed: userEmail != null ? onLogout : onSignIn,
          child: Text(
            userEmail != null ? 'Logout' : 'Sign In',
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(Icons.settings_rounded, color: Colors.white, size: 28),
        ),
      ],
    );
  }
}