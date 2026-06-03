import 'package:flutter/material.dart';
import 'package:targetshop/src/features/auth/presentation/pages/otp_screen_page.dart';
import 'otp_service.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final _phoneCtrl = TextEditingController();
  final _service = OtpServiceWeb();

  bool _loading = false;

   String _normalizeEgyptPhone(String input) {
    var p = input.trim().replaceAll(' ', '');
    if (p.startsWith('0')) p = p.substring(1);
    if (!p.startsWith('+')) p = '+20$p';
    return p;
  }

  Future<void> _sendOtp() async {
    final phone = _normalizeEgyptPhone(_phoneCtrl.text);

     if (phone.length < 12) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('أدخل رقم صحيح')),
      );
      return;
    }

    setState(() => _loading = true);

    try {
      await _service.sendOtp(phoneNumber: phone);

      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OtpScreen(
            phoneNumber: phone,
            service:
                _service,  
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل إرسال الكود: $e')),
      );
      print(e);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تسجيل رقم الموبايل (Web)')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _phoneCtrl,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'رقم الموبايل (مثال: 010xxxxxxxx)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _loading ? null : _sendOtp,
                child: _loading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('إرسال OTP'),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'ملاحظة: على الويب سيظهر reCAPTCHA تلقائيًا قبل إرسال الكود.',
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
