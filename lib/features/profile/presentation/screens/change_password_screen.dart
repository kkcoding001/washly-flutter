import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState
    extends State<ChangePasswordScreen> {
  final TextEditingController _currentController =
  TextEditingController();

  final TextEditingController _newController =
  TextEditingController();

  final TextEditingController _confirmController =
  TextEditingController();

  bool _showCurrent = false;
  bool _showNew = false;
  bool _showConfirm = true;

  bool _passwordMismatch = false;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
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
                padding: const EdgeInsets.fromLTRB(
                  58,
                  22,
                  58,
                  30,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Update your password',
                      style: TextStyle(
                        color: Color(0xFFE5E8ED),
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Keep your account secure by using a strong password.',
                      style: TextStyle(
                        color: Color(0xFFB7BDC7),
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 18),

                    _buildPasswordField(
                      label: 'Current Password',
                      hint: 'Enter current password',
                      controller: _currentController,
                      visible: _showCurrent,
                      onToggle: () {
                        setState(() {
                          _showCurrent = !_showCurrent;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    _buildPasswordField(
                      label: 'New Password',
                      hint: 'Enter new password',
                      controller: _newController,
                      visible: _showNew,
                      onToggle: () {
                        setState(() {
                          _showNew = !_showNew;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    // _buildPasswordField(
                    //   label: 'Confirm New Password',
                    //   hint: 'Confirm new password',
                    //   controller: _confirmController,
                    //   visible: _showConfirm,
                    //   error: true,
                    //   onToggle: () {
                    //     setState(() {
                    //       _showConfirm = !_showConfirm;
                    //     });
                    //   },
                    // ),
                    _buildPasswordField(
                      label: 'Confirm New Password',
                      hint: 'Confirm new password',
                      controller: _confirmController,
                      visible: _showConfirm,
                      error: _passwordMismatch,
                      onToggle: () {
                        setState(() {
                          _showConfirm = !_showConfirm;
                        });
                      },
                    ),

                    const SizedBox(height: 8),

                    if (_passwordMismatch) ...[
                      const SizedBox(height: 8),

                      const Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Color(0xFFFF9B9B),
                            size: 14,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Passwords do not match',
                            style: TextStyle(
                              color: Color(0xFFFF9B9B),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],

                    const SizedBox(height: 42),

                    SizedBox(
                      width: double.infinity,
                      height: 53,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _passwordMismatch =
                                _newController.text.isNotEmpty &&
                                    _confirmController.text.isNotEmpty &&
                                    _newController.text !=
                                        _confirmController.text;
                          });

                          if (!_passwordMismatch) {
                            // Later we'll call the Spring Boot API here.
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          const Color(0xFF2878E8),
                          foregroundColor: Colors.white,
                          elevation: 8,
                          shadowColor:
                          const Color(0x662878E8),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Update Password',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
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
            'Change Password',
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

  Widget _buildPasswordField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool visible,
    required VoidCallback onToggle,
    bool error = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: error
                ? const Color(0xFFFFA4A4)
                : const Color(0xFFBFC5CE),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 7),

        TextField(
          controller: controller,
          obscureText: !visible,
          style: const TextStyle(
            color: Color(0xFFE1E5EA),
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xFF626A75),
            ),
            suffixIcon: IconButton(
              onPressed: onToggle,
              icon: Icon(
                visible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: error
                    ? const Color(0xFFFFA4A4)
                    : const Color(0xFF929AA7),
                size: 20,
              ),
            ),
            filled: true,
            fillColor: const Color(0xFF1B2024),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: error
                    ? const Color(0xFF985858)
                    : const Color(0xFF2D3338),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: error
                    ? const Color(0xFFFF7B7B)
                    : const Color(0xFF2878E8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}