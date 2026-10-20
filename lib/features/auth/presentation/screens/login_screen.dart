import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/services/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  bool _isLoggingIn = false;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate() || _isLoggingIn) {
      return;
    }

    setState(() => _isLoggingIn = true);

    try {
      final result = await ApiService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;

      if (result['success'] == true) {
        final data = result['data'] as Map<String, dynamic>;
        final token = data['token'] as String?;

        if (token == null || token.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login response did not contain a token.')),
          );
          return;
        }

        await _secureStorage.write(key: 'jwt_token', value: token);

        if (!mounted) return;

        Navigator.of(context).pushNamedAndRemoveUntil(
          '/home',
              (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result['message']?.toString() ?? 'Login failed. Please try again.',
            ),
          ),
        );
      }
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to sign in. Please try again.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoggingIn = false);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F12),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildHeader(),

                const SizedBox(height: 28),

                _buildWelcomeSection(),

                const SizedBox(height: 40),

                _buildLoginCard(),

                const SizedBox(height: 36),

                _buildCreateAccountLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildHeader() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Image.asset(
  //         'assets/images/washly_logo.png',
  //         width: 32,
  //         height: 32,
  //         fit: BoxFit.contain,
  //       ),
  //
  //       const SizedBox(width: 10),
  //
  //       const Text(
  //         'Washly',
  //         style: TextStyle(
  //           color: Color(0xFFB9CBFF),
  //           fontSize: 20,
  //           fontWeight: FontWeight.w700,
  //         ),
  //       ),
  //     ],
  //   );
  // }
  Widget _buildHeader() {
    return SizedBox(
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Back arrow
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
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
                size: 28,
              ),
            ),
          ),

          // Centered logo + Washly
          Row(
            mainAxisSize: MainAxisSize.min,
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
        ],
      ),
    );
  }


  Widget _buildWelcomeSection() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome back 👋',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Sign in to manage your car washes easily.',
            style: TextStyle(
              color: Color(0xFFB0B6C0),
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1F22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF30353B),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEmailField(),

          const SizedBox(height: 24),

          _buildPasswordField(),

          const SizedBox(height: 14),

          _buildForgotPassword(),

          const SizedBox(height: 32),

          _buildSignInButton(),

          const SizedBox(height: 32),

          _buildDivider(),

          const SizedBox(height: 24),

          _buildGoogleButton(),
        ],
      ),
    );
  }

  // Widget _buildEmailField() {
  //   return TextFormField(
  //     controller: _emailController,
  //     keyboardType: TextInputType.emailAddress,
  //     style: const TextStyle(
  //       color: Color(0xFFE7E9ED),
  //       fontSize: 15,
  //     ),
  //     decoration: InputDecoration(
  //       labelText: 'Email',
  //       labelStyle: const TextStyle(
  //         color: Color(0xFFD9DCE2),
  //         fontSize: 14,
  //       ),
  //       hintText: 'name@example.com',
  //       hintStyle: const TextStyle(
  //         color: Color(0xFF686F7B),
  //       ),
  //       prefixIcon: const Icon(
  //         Icons.mail_outline,
  //         color: Color(0xFFB9C0CC),
  //       ),
  //       filled: true,
  //       fillColor: const Color(0xFF101418),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12),
  //         borderSide: const BorderSide(
  //           color: Color(0xFF30363F),
  //         ),
  //       ),
  //       enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12),
  //         borderSide: const BorderSide(
  //           color: Color(0xFF30363F),
  //         ),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12),
  //         borderSide: const BorderSide(
  //           color: Color(0xFF9DBBFF),
  //           width: 2,
  //         ),
  //       ),
  //     ),
  //     validator: (value) {
  //       if (value == null || value.trim().isEmpty) {
  //         return 'Please enter your email address';
  //       }
  //
  //       final emailRegex = RegExp(
  //         r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
  //       );
  //
  //       if (!emailRegex.hasMatch(value.trim())) {
  //         return 'Please enter a valid email address';
  //       }
  //
  //       return null;
  //     },
  //   );
  // }
  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email',
          style: TextStyle(
            color: Color(0xFFD9DCE2),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 8),

        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
            color: Color(0xFFE7E9ED),
            fontSize: 15,
          ),
          decoration: InputDecoration(
            hintText: 'name@example.com',
            hintStyle: const TextStyle(
              color: Color(0xFF686F7B),
              fontSize: 15,
            ),
            prefixIcon: const Icon(
              Icons.mail_outline,
              color: Color(0xFFB9C0CC),
              size: 21,
            ),
            filled: true,
            fillColor: const Color(0xFF101418),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 13,
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFFB3261E),
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFFB3261E),
                width: 2,
              ),
            ),
            errorStyle: const TextStyle(
              color: Color(0xFFB3261E),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
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
      ],
    );
  }

  // Widget _buildPasswordField() {
  //   return TextFormField(
  //     controller: _passwordController,
  //     obscureText: _obscurePassword,
  //     style: const TextStyle(
  //       color: Color(0xFFE7E9ED),
  //       fontSize: 15,
  //     ),
  //     decoration: InputDecoration(
  //       labelText: 'Password',
  //       labelStyle: const TextStyle(
  //         color: Color(0xFFD9DCE2),
  //         fontSize: 14,
  //       ),
  //       hintText: '••••••••',
  //       hintStyle: const TextStyle(
  //         color: Color(0xFF686F7B),
  //       ),
  //       prefixIcon: const Icon(
  //         Icons.lock_outline,
  //         color: Color(0xFFB9C0CC),
  //       ),
  //       suffixIcon: IconButton(
  //         onPressed: () {
  //           setState(() {
  //             _obscurePassword = !_obscurePassword;
  //           });
  //         },
  //         icon: Icon(
  //           _obscurePassword
  //               ? Icons.visibility_outlined
  //               : Icons.visibility_off_outlined,
  //           color: const Color(0xFFB9C0CC),
  //         ),
  //       ),
  //       filled: true,
  //       fillColor: const Color(0xFF101418),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12),
  //         borderSide: const BorderSide(
  //           color: Color(0xFF30363F),
  //         ),
  //       ),
  //       enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12),
  //         borderSide: const BorderSide(
  //           color: Color(0xFF30363F),
  //         ),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12),
  //         borderSide: const BorderSide(
  //           color: Color(0xFF9DBBFF),
  //           width: 2,
  //         ),
  //       ),
  //     ),
  //     validator: (value) {
  //       if (value == null || value.isEmpty) {
  //         return 'Please enter your password';
  //       }
  //
  //       if (value.length < 8) {
  //         return 'Wrong password';
  //       }
  //
  //       return null;
  //     },
  //   );
  // }
  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(
            color: Color(0xFFD9DCE2),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 8),

        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          style: const TextStyle(
            color: Color(0xFFE7E9ED),
            fontSize: 15,
          ),
          decoration: InputDecoration(
            hintText: '••••••••',
            hintStyle: const TextStyle(
              color: Color(0xFF686F7B),
              fontSize: 15,
            ),
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: Color(0xFFB9C0CC),
              size: 21,
            ),
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
                color: const Color(0xFFB9C0CC),
                size: 21,
              ),
            ),
            filled: true,
            fillColor: const Color(0xFF101418),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 13,
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFFB3261E),
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFFB3261E),
                width: 2,
              ),
            ),
            errorStyle: const TextStyle(
              color: Color(0xFFB3261E),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }

            if (value.length < 8) {
              return 'Please enter correct password';
            }

            return null;
          },
        ),
      ],
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {
          // Forgot password screen will be connected later.
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: const Text(
          'Forgot password?',
          style: TextStyle(
            color: Color(0xFF9DBBFF),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        // onPressed: () {
        //   if (_formKey.currentState!.validate()) {
        //     // Login will be connected later.
        //     Navigator.of(context).pushNamed('/home');
        //   }
        // },
        onPressed: _isLoggingIn ? null : _signIn,
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFF2675E8),
          foregroundColor: Colors.white,
          side: const BorderSide(
            color: Color(0xFF59616D),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        // child: const Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(
        //       'Sign In',
        //       style: TextStyle(
        //         fontSize: 14,
        //         fontWeight: FontWeight.w600,
        //       ),
        //     ),
        //     SizedBox(width: 8),
        //     Icon(
        //       Icons.arrow_forward,
        //       size: 18,
        //     ),
        //   ],
        // ),
        child: _isLoggingIn
            ? const CircularProgressIndicator(color: Colors.white)
            : const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign In',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Color(0xFF292E34),
            thickness: 1,
          ),
        ),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 3,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF34383E),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'or continue with',
            style: TextStyle(
              color: Color(0xFFB8BEC8),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const Expanded(
          child: Divider(
            color: Color(0xFF292E34),
            thickness: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildGoogleButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          // Google sign-in will be connected later.
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF292D33),
          foregroundColor: const Color(0xFFE7E9ED),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'G',
              style: TextStyle(
                color: Color(0xFF4285F4),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(width: 12),

            const Text(
              'Google',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateAccountLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(
            color: Color(0xFFB8BEC8),
            fontSize: 14,
          ),
        ),

        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/registration');
          },
          child: const Text(
            'Create account',
            style: TextStyle(
              color: Color(0xFF9DBBFF),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}