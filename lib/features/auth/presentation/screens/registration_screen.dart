import 'package:flutter/material.dart';

import '../../../../core/services/api_service.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  static const Color _errorColor = Color(0xFFB3261E);

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;

  bool _isRegistering = false;

  String? _phoneError;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }


  // void _createAccount() {
  //   final isFormValid = _formKey.currentState!.validate();
  //
  //   final phone = _phoneController.text.trim();
  //
  //   setState(() {
  //     if (phone.isEmpty) {
  //       _phoneError = 'Please enter your phone number';
  //     } else if (phone.length != 10) {
  //       _phoneError = 'Please enter a valid phone number';
  //     } else {
  //       _phoneError = null;
  //     }
  //   });
  //
  //   if (!isFormValid || _phoneError != null) {
  //     return;
  //   }
  //
  //   if (!_agreeToTerms) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text(
  //           'Please agree to the Terms & Privacy Policy.',
  //         ),
  //       ),
  //     );
  //
  //     return;
  //   }
  //
  //   // Account creation will be connected later.
  // }

  Future<void> _createAccount() async {
    final isFormValid = _formKey.currentState!.validate();
    final phone = _phoneController.text.trim();

    setState(() {
      if (phone.isEmpty) {
        _phoneError = 'Please enter your phone number';
      } else if (!RegExp(r'^[0-9]{10}$').hasMatch(phone)) {
        _phoneError = 'Please enter a valid phone number';
      } else {
        _phoneError = null;
      }
    });

    if (!isFormValid || _phoneError != null) return;

    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the Terms & Privacy Policy.'),
        ),
      );
      return;
    }

    if (_isRegistering) return;

    setState(() => _isRegistering = true);

    try {
      final result = await ApiService.register(
        name: _fullNameController.text,
        email: _emailController.text,
        phone: phone,
        password: _passwordController.text,
      );

      if (!mounted) return;

      if (result['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully. Please sign in.'),
          ),
        );

        Navigator.of(context).pushNamed('/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result['message']?.toString() ?? 'Registration failed.',
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isRegistering = false);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F12),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            child: Column(
              children: [
                _buildHeader(),

                const SizedBox(height: 24),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(
                    24,
                    26,
                    24,
                    24,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B1F22),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF252A2F),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitleSection(),

                      const SizedBox(height: 36),

                      _buildForm(),

                      const SizedBox(height: 18),

                      _buildTermsCheckbox(),

                      const SizedBox(height: 26),

                      _buildCreateAccountButton(),

                      const SizedBox(height: 28),

                      _buildLoginLink(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 40,
          ),
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFFD7DCE5),
          ),
        ),

        const Spacer(),

        Row(
          children: [
            Image.asset(
              'assets/images/washly_logo.png',
              width: 32,
              height: 32,
              fit: BoxFit.contain,
            ),

            const SizedBox(width: 10),

            const Text(
              'Washly',
              style: TextStyle(
                color: Color(0xFFB9CBFF),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),

        const Spacer(),

        const SizedBox(width: 40),
      ],
    );
  }

  Widget _buildTitleSection() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Create your\naccount',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              height: 1.15,
              letterSpacing: -0.5,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Join Washly and make car wash effortless.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFB0B6C0),
              fontSize: 15,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildPhoneField() {
    final hasError = _phoneError != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Phone Number',
          style: TextStyle(
            color: Color(0xFFD9DCE2),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 8),

        Container(
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF101418),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: hasError
                  ? const Color(0xFFB3261E)
                  : const Color(0xFF30363F),
              width: hasError ? 2 : 1,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: [
              // Country code
              Container(
                width: 48,
                height: double.infinity,
                alignment: Alignment.center,
                color: const Color(0xFF30353D),
                child: const Text(
                  '+91',
                  style: TextStyle(
                    color: Color(0xFFB9BEC8),
                    fontSize: 14,
                  ),
                ),
              ),

              // Phone number
              Expanded(
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  onChanged: (value) {
                    if (_phoneError != null) {
                      setState(() {
                        _phoneError = null;
                      });
                    }
                  },
                  style: const TextStyle(
                    color: Color(0xFFE7E9ED),
                    fontSize: 15,
                  ),
                  decoration: const InputDecoration(
                    hintText: '9876543210',
                    hintStyle: TextStyle(
                      color: Color(0xFF686F7B),
                    ),
                    border: InputBorder.none,
                    counterText: '',
                    contentPadding: EdgeInsets.only(
                      left: 10,
                      right: 14,
                      top: 13,
                      bottom: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Error message

        if (hasError) ...[
          const SizedBox(height: 6),

          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              _phoneError!,
              style: const TextStyle(
                color: Color(0xFFB3261E),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],


      ],
    );
  }


  Widget _buildForm() {
    return Column(
      children: [
        // Full Name
        _buildTextField(
          label: 'Full Name',
          hintText: 'John Doe',
          controller: _fullNameController,
          icon: Icons.person_outline,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your full name';
            }

            return null;
          },
        ),

        const SizedBox(height: 20),

        // Email Address
        _buildTextField(
          label: 'Email Address',
          hintText: 'john.doe@example.com',
          controller: _emailController,
          icon: Icons.mail_outline,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your email address';
            }

            final emailRegex = RegExp(
              r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
            );

            if (!emailRegex.hasMatch(value.trim())) {
              return 'Please enter a valid email address';
            }

            return null;
          },
        ),

        const SizedBox(height: 20),

        // Phone Number
        _buildPhoneField(),

        const SizedBox(height: 20),

        // Password
        _buildTextField(
          label: 'Password',
          hintText: '••••••••',
          controller: _passwordController,
          icon: Icons.lock_outline,
          obscureText: _obscurePassword,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a password';
            }

            if (value.length < 8) {
              return 'Password must be at least 8 characters';
            }

            return null;
          },
        ),

        const SizedBox(height: 20),

        // Confirm Password
        _buildTextField(
          label: 'Confirm Password',
          hintText: '••••••••',
          controller: _confirmPasswordController,
          icon: Icons.lock_outline,
          obscureText: _obscureConfirmPassword,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _obscureConfirmPassword =
                !_obscureConfirmPassword;
              });
            },
            icon: Icon(
              _obscureConfirmPassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please confirm your password';
            }

            if (value != _passwordController.text) {
              return 'Passwords do not match';
            }

            return null;
          },
        ),
      ],
    );
  }


  Widget _buildTextField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFD9DCE2),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 8),

        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          style: const TextStyle(
            color: Color(0xFFE7E9ED),
            fontSize: 15,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Color(0xFF686F7B),
            ),
            prefixIcon: Icon(
              icon,
              color: Color(0xFF9BA4B4),
            ),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: const Color(0xFF101418),
            contentPadding: const EdgeInsets.only(
              left: 12,
              right: 14,
              top: 15,
              bottom: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF30363F),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF30363F),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF9DBBFF),
                width: 2,
              ),
            ),
            // errorBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(8),
            //   borderSide: const BorderSide(
            //     color: Color(0xFFFF9A93),
            //     width: 2,
            //   ),
            // ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFFB3261E),
                width: 2,
              ),
            ),
            // focusedErrorBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(8),
            //   borderSide: const BorderSide(
            //     color: Color(0xFFFF9A93),
            //     width: 2,
            //   ),
            // ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFFB3261E),
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: _agreeToTerms,
            onChanged: (value) {
              setState(() {
                _agreeToTerms = value ?? false;
              });
            },
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            side: const BorderSide(
              color: Color(0xFF667080),
              width: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                color: Color(0xFFB8BEC8),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.3,
              ),
              children: [
                TextSpan(
                  text: 'I agree to the ',
                ),
                TextSpan(
                  text: 'Terms & Privacy Policy.',
                  style: TextStyle(
                    color: Color(0xFF9DBBFF),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCreateAccountButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        // onPressed: _createAccount,
        onPressed: _isRegistering ? null : _createAccount,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2675E8),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        // child: const Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(
        //       'Create Account',
        //       style: TextStyle(
        //         fontSize: 14,
        //         fontWeight: FontWeight.w600,
        //       ),
        //     ),
        //     SizedBox(width: 10),
        //     Icon(Icons.arrow_forward),
        //   ],
        // ),
        child: _isRegistering
            ? const SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        )
            : const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create Account',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 10),
            Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/login');
        },
        child: const Text.rich(
          TextSpan(
            text: 'Already have an account? ',
            style: TextStyle(
              color: Color(0xFFB7BDC8),
              fontSize: 14,
            ),
            children: [
              TextSpan(
                text: 'Sign In',
                style: TextStyle(
                  color: Color(0xFF9DBBFF),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}