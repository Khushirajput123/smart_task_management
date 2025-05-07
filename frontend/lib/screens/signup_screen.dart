import 'package:flutter/material.dart';
import 'task_page.dart'; // Import TaskPage
import '../services/auth_services.dart'; // You already have this

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool agree = false;
  bool isLoading = false;

  void handleSignup() async {
    setState(() => isLoading = true);

    final success = await AuthService().signup(
      _usernameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() => isLoading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Signup successful!")),
      );
      // Navigate to TaskPage after successful signup
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TaskPage()), // Navigate to TaskPage
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Signup failed. Try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF2DE),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  "< Back",
                  style: TextStyle(
                    color: Colors.brown,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Center(
                child: Text(
                  "Create an Account",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Image.asset(
                  'assets/images/goglu.png',
                  height: 120,
                ),
              ),
              const SizedBox(height: 32),

              // Input Fields
              buildInputField("Username", _usernameController),
              const SizedBox(height: 16),
              buildInputField("Email Address", _emailController),
              const SizedBox(height: 16),
              buildInputField("Password", _passwordController, obscure: true),
              const SizedBox(height: 16),

              // Checkbox
              Row(
                children: [
                  Checkbox(
                    value: agree,
                    activeColor: Colors.brown,
                    onChanged: (value) {
                      setState(() => agree = value!);
                    },
                  ),
                  const Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: "I agree to the ",
                        children: [
                          TextSpan(
                            text: "terms and conditions",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic,
                            ),
                          )
                        ],
                      ),
                      style: TextStyle(color: Colors.brown),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 16),

              // Signup Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: agree && !isLoading ? handleSignup : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE6C89F),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "SIGN UP",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputField(String hint, TextEditingController controller,
      {bool obscure = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFD6C2A8),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
