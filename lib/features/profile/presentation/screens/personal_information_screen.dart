
import 'package:flutter/material.dart';
import 'package:washly/core/services/api_service.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState
    extends State<PersonalInformationScreen> {
  final TextEditingController _nameController =
  TextEditingController();

  final TextEditingController _emailController =
  TextEditingController();

  final TextEditingController _phoneController =
  TextEditingController();

  bool _isLoading = true;
  String? _errorMessage;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  // ============================================================
  // LOAD USER DATA FROM BACKEND
  // ============================================================

  Future<void> _loadProfile() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await ApiService.getProfile();

    if (!mounted) return;

    if (result['success'] == true &&
        result['data'] is Map) {
      final data = Map<String, dynamic>.from(
        result['data'] as Map,
      );

      setState(() {
        _nameController.text =
            data['name']?.toString() ?? '';

        _emailController.text =
            data['email']?.toString() ?? '';

        _phoneController.text =
            data['phone']?.toString() ?? '';

        _isLoading = false;
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



  Future<void> _saveChanges() async {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your full name.'),
        ),
      );
      return;
    }

    if (_isSaving) return;

    setState(() {
      _isSaving = true;
    });

    final result = await ApiService.updateProfile(
      name: name,
      phone: phone,
    );

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (result['success'] == true) {
      // Refresh the displayed values from the server response.
      final data = result['data'];

      if (data is Map) {
        setState(() {
          _nameController.text =
              data['name']?.toString() ?? name;

          _emailController.text =
              data['email']?.toString() ??
                  _emailController.text;

          _phoneController.text =
              data['phone']?.toString() ?? phone;
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result['message']?.toString() ??
                'Unable to update profile.',
          ),
        ),
      );
    }
  }


  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF0D1215),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  40,
                  20,
                  30,
                ),
                child: Column(
                  children: [
                    _buildProfilePhoto(),

                    const SizedBox(height: 24),

                    if (_isLoading) ...[
                      const CircularProgressIndicator(
                        color: Color(0xFF2878E8),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Loading your information...',
                        style: TextStyle(
                          color: Color(0xFFB8BEC9),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    if (_errorMessage != null) ...[
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
                          foregroundColor:
                          const Color(0xFFAFC5FF),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    _buildField(
                      label: 'Full Name',
                      controller: _nameController,
                      icon: Icons.person_outline,
                    ),

                    const SizedBox(height: 24),

                    _buildField(
                      label: 'Email Address',
                      controller: _emailController,
                      icon: Icons.mail_outline,
                      active: true,
                      readOnly: true,
                    ),

                    const SizedBox(height: 24),

                    _buildField(
                      label: 'Phone Number',
                      controller: _phoneController,
                      icon: Icons.phone_outlined,
                    ),

                    const SizedBox(height: 64),

                    _buildSaveButton(),
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
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xFFDCE1EA),
                size: 21,
              ),
            ),
          ),

          const Text(
            'Personal Information',
            style: TextStyle(
              color: Color(0xFFE7E9ED),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PROFILE PHOTO
  // ============================================================

  Widget _buildProfilePhoto() {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF2878E8),
                  width: 2,
                ),
              ),
              child: const ClipOval(
                child: Icon(
                  Icons.person,
                  size: 55,
                  color: Color(0xFF9EA7B5),
                ),
              ),
            ),

            Positioned(
              right: -1,
              bottom: -1,
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
          ],
        ),

        const SizedBox(height: 22),

        const Text(
          'Change photo',
          style: TextStyle(
            color: Color(0xFFC5CAD3),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // INPUT FIELD
  // ============================================================

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool active = false,
    bool readOnly = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111619),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          bottom: BorderSide(
            color: active
                ? const Color(0xFF2878E8)
                : const Color(0xFF252B30),
            width: active ? 2 : 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          12,
          14,
          12,
          10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: active
                    ? const Color(0xFF2878E8)
                    : const Color(0xFFB8BEC9),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Icon(
                  icon,
                  color: active
                      ? const Color(0xFF2878E8)
                      : const Color(0xFFB8BEC9),
                  size: 21,
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: TextField(
                    controller: controller,
                    readOnly: readOnly,
                    enabled: !_isLoading &&
                        _errorMessage == null,
                    style: const TextStyle(
                      color: Color(0xFFE2E5EA),
                      fontSize: 15,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SAVE BUTTON
  // ============================================================

  // Widget _buildSaveButton() {
  //   return SizedBox(
  //     width: double.infinity,
  //     height: 56,
  //     child: ElevatedButton(
  //       onPressed: _isLoading || _errorMessage != null
  //           ? null
  //           : () {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(
  //             content: Text(
  //               'Profile update is not connected yet.',
  //             ),
  //           ),
  //         );
  //       },
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: const Color(0xFF2878E8),
  //         foregroundColor: Colors.white,
  //         elevation: 8,
  //         shadowColor: const Color(0x662878E8),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(11),
  //         ),
  //       ),
  //       child: const Text(
  //         'Save Changes',
  //         style: TextStyle(
  //           fontSize: 14,
  //           fontWeight: FontWeight.w600,
  //         ),
  //       ),
  //     ),
  //   );
  // }


  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading || _isSaving || _errorMessage != null
            ? null
            : _saveChanges,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2878E8),
          foregroundColor: Colors.white,
          elevation: 8,
          shadowColor: const Color(0x662878E8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        child: _isSaving
            ? const SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        )
            : const Text(
          'Save Changes',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

}
