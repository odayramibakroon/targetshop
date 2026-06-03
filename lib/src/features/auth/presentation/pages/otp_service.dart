import 'package:firebase_auth/firebase_auth.dart';

class OtpServiceWeb {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ConfirmationResult? _confirmation;

  /// Send OTP (Web): triggers reCAPTCHA automatically
  Future<void> sendOtp({required String phoneNumber}) async {
    _confirmation = await _auth.signInWithPhoneNumber(phoneNumber);
  }

  /// Verify OTP (Web)
  Future<UserCredential> verifyOtp({required String smsCode}) async {
    if (_confirmation == null) {
      throw Exception('لم يتم إرسال OTP بعد');
    }
    return await _confirmation!.confirm(smsCode);
  }
}
