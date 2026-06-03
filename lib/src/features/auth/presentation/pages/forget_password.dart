import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:targetshop/src/core/utils/AppValidators.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendReset() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إرسال رابط إعادة تعيين كلمة المرور ✅')),
      );

       Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String msg = 'حصل خطأ، حاول تاني.';
      if (e.code == 'user-not-found') msg = 'الإيميل ده مش موجود.';
      if (e.code == 'invalid-email') msg = 'الإيميل غير صحيح.';
      if (e.code == 'too-many-requests') msg = 'محاولات كثيرة، جرّب بعد شوية.';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حصل خطأ غير متوقع.')),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نسيت كلمة المرور'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(Icons.lock_reset, size: 70),
                    const SizedBox(height: 16),

                    const Text(
                      'أدخل بريدك الإلكتروني وسنرسل لك رابط لإعادة تعيين كلمة المرور.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),

                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        labelText: 'البريد الإلكتروني',
                        hintText: 'example@email.com',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        final v = (value ?? '').trim();
                        if (v.isEmpty){ return 'اكتب الإيميل';}
                     
                        return AppValidators.email(v);
           
                      },
                      onFieldSubmitted: (_) => _sendReset(),
                    ),

                    const SizedBox(height: 16),

                    ElevatedButton(
                      onPressed: _loading ? null : _sendReset,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: _loading
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text(
                              'إرسال رابط الاسترجاع',
                              style: TextStyle(fontSize: 16),
                            ),
                    ),

                    const SizedBox(height: 12),

                    TextButton(
                      onPressed: _loading ? null : () => Navigator.pop(context),
                      child: const Text('رجوع لتسجيل الدخول'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
