import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/coming_soon_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  void navigateToComingSoon(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ComingSoonView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'My account',
          style: GoogleFonts.amaranth(fontWeight: FontWeight.bold, fontSize: 20),
          
        ),
      
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF670977),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 32, color: Colors.black),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ARSANY MORCOS',
                          style: GoogleFonts.amaranth(
                              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                        ),
                        Text(
                          'arsantimorcos88@gmail.com',
                          style: GoogleFonts.amaranth(fontSize: 17, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () => navigateToComingSoon(context),
                    child: Text(
                      'Edit',
                      style: GoogleFonts.amaranth(fontSize: 17, color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
            buildSectionTitle('General Settings'),
            buildMenuItem(Icons.notifications, 'Notifications', context),
            buildMenuItem(Icons.person, 'Personal Informations', context),
            buildMenuItem(Icons.people, 'Invite Friends', context),
            buildMenuItem(Icons.language, 'Language', context),
            buildSectionTitle('Security & Privacy'),
            buildMenuItem(Icons.security, 'Security', context),
            buildMenuItem(Icons.help, 'Help Center', context),
            buildSectionTitle('Log Out'),
            buildMenuItem(Icons.logout, 'Log Out', context),
            SizedBox(height: 50,),
          ],
          
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: GoogleFonts.amaranth(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Widget buildMenuItem(IconData icon, String title, BuildContext context) {
    return InkWell(
      onTap: () => navigateToComingSoon(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.amaranth(fontSize: 17),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
          ],
        ),
      ),

    );
  }
}
