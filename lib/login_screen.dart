import 'dart:ui';
import 'package:flutter/material.dart';

import 'sign_in.dart';
import 'sign_up.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Latar belakang gradien dengan animasi
          AnimatedContainer(
            duration: const Duration(seconds: 3),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1C1C1E), Color(0xFF2E2E2E)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Efek blur
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0.25),
              ),
            ),
          ),
          // Konten utama
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo dengan animasi muncul
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(seconds: 2),
                    child: Image.asset(
                      'images/maternal.png',
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Teks sambutan dengan animasi fade-in
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(seconds: 2),
                    child: const Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Sign in or create an account to continue',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Tombol "Create Account" dengan animasi
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignUp(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: const Color(0xFF3B82F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 6,
                      shadowColor: Colors.black26,
                    ),
                    icon: const Icon(Icons.person_add, color: Colors.white),
                    label: const Text(
                      'Create Account',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Tombol "Sign In" dengan animasi
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignIn(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      side: const BorderSide(
                        color: Color(0xFF3B82F6),
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 6,
                      shadowColor: Colors.black26,
                    ),
                    icon: const Icon(Icons.login, color: Color(0xFF3B82F6)),
                    label: const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 16, color: Color(0xFF3B82F6)),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Footer dengan animasi fade-in
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(seconds: 3),
                    child: const Text(
                      '© 2024 DarkWorld Inc.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white38,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
