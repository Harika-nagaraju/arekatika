// lib/screens/auth/signup_screen.dart
import 'package:flutter/material.dart';
import 'package:arekatika/services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _mobileController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _referralController = TextEditingController();
  String _gender = 'male';
  bool _isLoading = false;

  @override
  void dispose() {
    _mobileController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _referralController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // 1. First, complete the signup process
      // ... your existing signup code ...

      // 2. After successful signup, update KYC
      final kycResult = await AuthService.updateKyc(
        mobileNumber: _mobileController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        gender: _gender,
        referral: _referralController.text.trim(),
      );

      if (!mounted) return;

      if (kycResult['success'] == true) {
        // Save the token if needed
        final token = kycResult['token'];
        // await _saveToken(token);
        
        // Navigate to home screen
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(kycResult['message'] ?? 'Failed to update KYC')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occurred. Please try again.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Your existing form fields
              TextFormField(
                controller: _mobileController,
                decoration: const InputDecoration(labelText: 'Mobile Number'),
                keyboardType: TextInputType.phone,
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              // Add other form fields...
              
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _handleSignup,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Sign Up & Complete KYC'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}