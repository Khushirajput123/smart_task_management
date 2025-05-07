import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),

            // Header
            const Text(
              "Hi There!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // Googlu Image
            Center(
              child: Image.asset(
                'assets/images/goglu.png',
                height: 180,
              ),
            ),

            const SizedBox(height: 12),

            // const Text(
            //   "Goglu",
            //   style: TextStyle(
            //     fontSize: 22,
            //     fontWeight: FontWeight.w500,
            //     color: Colors.brown,
            //   ),
            // ),

            const SizedBox(height: 100), //distance between image and buttons

            // "I have an account" Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                // onPressed: () {
                //   // Navigate to login screen
                // },
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text("I have an account"),
              ),
            ),

            const SizedBox(height: 12),

            // "Create an account" Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: OutlinedButton(
                // onPressed: () {
                //   // Navigate to signup screen
                // },
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignupPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  side: const BorderSide(color: Colors.brown),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  "Create an account",
                  style: TextStyle(color: Colors.brown),
                ),
              ),
            ),

            const Spacer(),

            // Bottom Decor
            // Bottom left cloud
            // Align(
            //   alignment: Alignment.bottomLeft,
            //   child: Image.asset(
            //     'assets/images/bottom_clouds.png',
            //     width: MediaQuery.of(context).size.width * 0.5,
            //     fit: BoxFit.contain,
            //   ),
            // ),
            // // Image.asset(
            //   'assets/images/bottom_clouds.png',
            //   fit: BoxFit.cover,
            // ),

            // Bottom right mirrored cloud
            // Align(
            //   alignment: Alignment.bottomRight,
            //   child: Transform(
            //     alignment: Alignment.center,
            //     transform: Matrix4.identity()..scale(-1.0, 1.0),
            //     child: Image.asset(
            //       'assets/images/bottom_clouds.png',
            //       width: MediaQuery.of(context).size.width * 0.5,
            //       fit: BoxFit.contain,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
