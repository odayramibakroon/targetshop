import 'package:firebase_auth/firebase_auth.dart';

class OtpServiceWeb {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ConfirmationResult? _confirmation;

   Future<void> sendOtp({required String phoneNumber}) async {
    _confirmation = await _auth.signInWithPhoneNumber(phoneNumber);
  }

   Future<UserCredential> verifyOtp({required String smsCode}) async {
    if (_confirmation == null) {
      throw Exception('لم يتم إرسال OTP بعد');
    }
    return await _confirmation!.confirm(smsCode);
  }
}
