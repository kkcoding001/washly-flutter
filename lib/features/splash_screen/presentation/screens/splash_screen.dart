import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _startLoading();
  }

  void _startLoading() {
    const updateInterval = Duration(milliseconds: 30);

    const totalUpdates = 100;
    var currentUpdate = 0;

    _timer = Timer.periodic(updateInterval, (timer) {
      currentUpdate++;

      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() {
        _progress = currentUpdate / totalUpdates;
      });

      if (currentUpdate >= totalUpdates) {
        timer.cancel();

        // Navigation will be
        Navigator.of(context).pushReplacementNamed('/onboarding');
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF081528),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildLogo(),
                    const SizedBox(height: 36),
                    _buildBrandName(),
                    const SizedBox(height: 12),
                    _buildSubtitle(),
                  ],
                ),
              ),
            ),
            _buildLoadingSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 128,
      height: 128,
      decoration: BoxDecoration(
        color: const Color(0xFF162235),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: Image.asset(
          'assets/images/washly_logo.png',
          width: 80,
          height: 80,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildBrandName() {
    return const Text(
      'Washly',
      style: TextStyle(
        color: Colors.white,
        fontSize: 34,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildSubtitle() {
    return const Text(
      'Premium Car Care',
      style: TextStyle(
        color: Color(0xFF8D96A8),
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _buildLoadingSection() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 32,
        right: 32,
        bottom: 24,
      ),
      child: Column(
        children: [
          _buildProgressBar(),
          const SizedBox(height: 12),
          const Text(
            'INITIALIZING',
            style: TextStyle(
              color: Color(0xFF707A8D),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return SizedBox(
      width: 200,
      height: 4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(
          value: _progress,
          backgroundColor: const Color(0xFF303845),
          valueColor: const AlwaysStoppedAnimation<Color>(
            Color(0xFFBFC5CE),
          ),
        ),
      ),
    );
  }
}