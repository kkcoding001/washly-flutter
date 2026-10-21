import 'package:flutter/material.dart';
import 'package:washly/core/services/api_service.dart';

import 'personal_information_screen.dart';
import 'my_vehicles_screen.dart';
import 'change_password_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.onBackToHome,
    required this.vehicles,
    required this.onVehiclesChanged,
  });

  final VoidCallback onBackToHome;
  final List<Map<String, String>> vehicles;
  final ValueChanged<List<Map<String, String>>> onVehiclesChanged;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? _profile;

  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  // ============================================================
  // LOAD PROFILE FROM BACKEND
  // ============================================================

  Future<void> _loadProfile() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await ApiService.getProfile();

    if (!mounted) return;

    if (result['success'] == true) {
      final data = result['data'];

      setState(() {
        _profile = data is Map
            ? Map<String, dynamic>.from(data)
            : null;

        _isLoading = false;

        if (_profile == null) {
          _errorMessage = 'Invalid profile response from server.';
        }
      });
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage =
            result['message']?.toString() ??
                'Unable to load your profile.';
      });
    }
  }

  String _profileValue(String key, String fallback) {
    final value = _profile?[key]?.toString().trim();

    if (value == null || value.isEmpty || value == 'null') {
      return fallback;
    }

    return value;
  }

  // ============================================================
  // MAIN SCREEN
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1215),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  30,
                  20,
                  35,
                ),
                child: Column(
                  children: [
                    _buildProfileHeader(context),

                    const SizedBox(height: 40),

                    _buildProfileOption(
                      icon: Icons.person_outline,
                      title: 'Personal Information',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const PersonalInformationScreen(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    _buildProfileOption(
                      icon: Icons.directions_car_outlined,
                      title: 'My Vehicles',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MyVehiclesScreen(
                              vehicles: widget.vehicles,
                              onVehiclesChanged:
                              widget.onVehiclesChanged,
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    _buildProfileOption(
                      icon: Icons.lock_outline,
                      title: 'Change Password',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const ChangePasswordScreen(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    _buildProfileOption(
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                      onTap: () {
                        // Help & Support functionality can be
                        // connected later.
                      },
                    ),

                    const SizedBox(height: 84),

                    _buildLogoutButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF20262B),
          ),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: widget.onBackToHome,
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xFFDCE1EA),
                size: 21,
              ),
            ),
          ),

          const Text(
            'Profile',
            style: TextStyle(
              color: Color(0xFFE7E9ED),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PROFILE HEADER
  // ============================================================

  Widget _buildProfileHeader(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 96,
              height: 96,
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                border: Border.fromBorderSide(
                  BorderSide(
                    color: Color(0xFF2878E8),
                    width: 2,
                  ),
                ),
              ),
              child: ClipOval(
                child: Container(
                  color: const Color(0xFF20272D),
                  child: const Icon(
                    Icons.person,
                    size: 55,
                    color: Color(0xFF9EA7B5),
                  ),
                ),
              ),
            ),

            Positioned(
              right: -1,
              bottom: -1,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                      const PersonalInformationScreen(),
                    ),
                  );
                },
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2878E8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 17,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        if (_isLoading) ...[
          const SizedBox(
            width: 25,
            height: 25,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: Color(0xFF2878E8),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Loading profile...',
            style: TextStyle(
              color: Color(0xFFB5BBC5),
              fontSize: 14,
            ),
          ),
        ] else if (_errorMessage != null) ...[
          Text(
            _errorMessage!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFFF9B9B),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: _loadProfile,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFAFC5FF),
            ),
          ),
        ] else ...[
          Text(
            _profileValue('name', 'Name not available'),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFE7E9ED),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            _profileValue('email', 'Email not available'),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFB5BBC5),
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            _profileValue('phone', 'Phone not available'),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFAFC5FF),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  // ============================================================
  // PROFILE OPTIONS
  // ============================================================

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        height: 75,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF1B2024),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF30363B),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Color(0xFF242A30),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: const Color(0xFFAFC5FF),
                size: 22,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFFDCE0E6),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const Icon(
              Icons.chevron_right,
              color: Color(0xFFB8BEC9),
              size: 25,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // LOGOUT
  // ============================================================

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      height: 53,
      child: OutlinedButton(
        onPressed: () {
          // Logout functionality is not connected yet.
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFFFF9B9B),
          side: const BorderSide(
            color: Color(0xFF583B3B),
          ),
          backgroundColor: const Color(0xFF191E22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.logout,
              size: 21,
            ),
            SizedBox(width: 9),
            Text(
              'Logout',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
