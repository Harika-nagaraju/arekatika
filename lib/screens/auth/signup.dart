import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';
import 'package:arekatika/widgets/custom_textfield.dart';
import 'package:arekatika/widgets/custom_button.dart';
import 'package:arekatika/screens/dashboard/dashboard.dart';

enum Gender { male, female, other }

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _referral = TextEditingController();
  Gender? _gender = Gender.male;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _firstName.addListener(_onFieldChanged);
    _lastName.addListener(_onFieldChanged);
    _email.addListener(_onFieldChanged);
    _referral.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _referral.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      _firstName.text.trim().isNotEmpty && _lastName.text.trim().isNotEmpty;

  Future<void> _submit() async {
    if (!_canSubmit) return;
    setState(() => _submitting = true);
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() => _submitting = false);
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const Dashboard()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome', style: FontUtils.bold(size: 28, color: AppColors.textPrimary)),
              const SizedBox(height: 6),
              Text('Tell Us a Little About Yourself',
                  style: FontUtils.regular(size: 15, color: Colors.black54)),
              const SizedBox(height: 28),

              // Full Name
              Text('Full Name', style: FontUtils.regular(size: 13, color: Colors.black54)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _firstName,
                      hintText: 'First Name',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomTextField(
                      controller: _lastName,
                      hintText: 'Last Name',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),
              // Email
              Text('Email (optional)',
                  style: FontUtils.regular(size: 13, color: Colors.black54)),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _email,
                hintText: 'Enter Email Address',
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 22),
              // Gender
              Text('Gender (optional)',
                  style: FontUtils.regular(size: 13, color: Colors.black54)),
              const SizedBox(height: 10),
              Row(
                children: [
                  _GenderRadio<Gender>(
                    value: Gender.male,
                    groupValue: _gender,
                    label: 'Male',
                    onChanged: (v) => setState(() => _gender = v as Gender?),
                  ),
                  const SizedBox(width: 18),
                  _GenderRadio<Gender>(
                    value: Gender.female,
                    groupValue: _gender,
                    label: 'Female',
                    onChanged: (v) => setState(() => _gender = v as Gender?),
                  ),
                  const SizedBox(width: 18),
                  _GenderRadio<Gender>(
                    value: Gender.other,
                    groupValue: _gender,
                    label: 'Other',
                    onChanged: (v) => setState(() => _gender = v as Gender?),
                  ),
                ],
              ),

              const SizedBox(height: 22),
              // Referral
              Text('Referral Code (optional)',
                  style: FontUtils.regular(size: 13, color: Colors.black54)),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _referral,
                hintText: 'Enter Referral Code',
              ),

              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: (_canSubmit && !_submitting) ? _submit : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brandGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _submitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        )
                      : Text('SUBMIT', style: FontUtils.semiBold(size: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GenderRadio<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final String label;
  final ValueChanged<T?> onChanged;
  const _GenderRadio({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: AppColors.brandGreen,
            visualDensity: VisualDensity.compact,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: FontUtils.regular(size: 13, color: AppColors.textPrimary),
        ),
      ],
    );
  }
}
