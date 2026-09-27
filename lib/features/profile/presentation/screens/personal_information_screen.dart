import 'package:flutter/material.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState
    extends State<PersonalInformationScreen> {
  final TextEditingController _nameController =
  TextEditingController(text: 'Rahul Patel');

  final TextEditingController _emailController =
  TextEditingController(text: 'rahul@gmail.com');

  final TextEditingController _phoneController =
  TextEditingController(text: '+91 11223 44556');

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
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF0D1215),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
                child: Column(
                  children: [
                    _buildProfilePhoto(),

                    const SizedBox(height: 28),

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

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool active = false,
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
        padding: const EdgeInsets.fromLTRB(12, 14, 12, 10),
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

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2878E8),
          foregroundColor: Colors.white,
          elevation: 8,
          shadowColor: const Color(0x662878E8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        child: const Text(
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