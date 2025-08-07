// Login screen for email/password and Google authentication.
// Handles user input, validation, and navigation to home on success.
// Provides error feedback and links to sign up and password reset.
import 'package:ecommerse_app/features/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ecommerse_app/core/theme/app_colors.dart';
import 'package:ecommerse_app/core/app_strings.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;

  // Handles email/password sign-in
  Future<void> _signInWithEmail() async {
    setState(() => _loading = true);
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
    } on FirebaseAuthException catch (e) {
      _showError(e.message);
    }
    setState(() => _loading = false);
  }

  // Handles Google sign-in
  Future<void> _signInWithGoogle() async {
    setState(() => _loading = true);
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // Canceled
        setState(() => _loading = false);
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
    } on FirebaseAuthException catch (e) {
      _showError(e.message);
    }
    setState(() => _loading = false);
  }

  // Shows error message in a SnackBar
  void _showError(String? message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message ?? 'An error occurred')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome text
                const Text(
                  AppStrings.welcomeBack,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                // Login to account subtitle
                const Text(
                  AppStrings.loginToAccount,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.grey54,
                  ),
                ),
                const SizedBox(height: 32),
                // Login form card
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.grey12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: Column(
                      children: [
                        // Email input
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: AppStrings.email,
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Password input
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: AppStrings.password,
                            prefixIcon: Icon(Icons.lock_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Forgot password link
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Forgot Password Logic
                            },
                            child: const Text(
                              AppStrings.forgotPassword,
                              style: TextStyle(
                                color: AppColors.grey54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Login button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _loading ? null : _signInWithEmail,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.amber600,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: _loading
                                ? const CircularProgressIndicator(color: AppColors.card)
                                : const Text(
                                    AppStrings.login,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.card,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 16),
                        // Google sign-in button
                       OutlinedButton(
                          onPressed: _signInWithGoogle,
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.card,
                            side: BorderSide(color: AppColors.greyShade300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            minimumSize: Size(double.infinity, 50),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/png/google_logo.png', width: 24, height: 24),
                              SizedBox(width: 12),
                              Text(AppStrings.signInWithGoogle, style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Sign up link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              AppStrings.dontHaveAccount,
                              style: TextStyle(
                                color: AppColors.grey54,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Navigate to Sign Up
                              },
                              child: const Text(
                                AppStrings.signUp,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
