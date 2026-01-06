import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetshop/src/core/routes/names.dart';
import 'package:targetshop/src/core/utils/user_image_service.dart';
import 'package:targetshop/src/features/users/cubit/user_cubit.dart';
 
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // 🔑 ضع مفتاح imgBB هنا
  final String imgbbApiKey = 'e83fe0aadc3559783d52a821deff056c';

  bool _uploading = false;

  Future<void> _changePhoto(BuildContext context) async {
    if (_uploading) return;

    setState(() => _uploading = true);
    try {
      final url = await UserImageService.pickUploadAndSave(imgbbApiKey: imgbbApiKey);
      if (!mounted) return;

      if (url != null) {
        // ✅ حدّث بيانات اليوزر من Firestore
        // عدّل اسم الدالة حسب UserCubit عندك
        context.read<UserCubit>().loadUser();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ تم تحديث الصورة بنجاح')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ فشل تحديث الصورة: $e')),
      );
      print('Error updating profile photo: $e');
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }
     void logout(){
     FirebaseAuth.instance.signOut().then((_) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RoutesName.login, (route) => false);
                 }).catchError((error) {
                 });
     }
  Future<void> _sendResetPasswordEmail(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    final email = auth.currentUser?.email;

    if (email == null || email.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ لا يوجد بريد إلكتروني لهذا الحساب')),
      );
      return;
    }

    try {
      await auth.sendPasswordResetEmail(email: email);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('📩 تم إرسال رابط إعادة تعيين كلمة المرور')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ فشل إرسال الرابط: $e')),
      );
    }
  }

  void _showThemeSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(title: Text('المظهر')),
              ListTile(
                leading: const Icon(Icons.light_mode),
                title: const Text('فاتح'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: اربطها بـ ThemeCubit/SharedPreferences
                },
              ),
              ListTile(
                leading: const Icon(Icons.dark_mode),
                title: const Text('داكن'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: اربطها بـ ThemeCubit/SharedPreferences
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLanguageSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(title: Text('اللغة')),
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text('العربية'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: اربطها بـ LocaleCubit / easy_localization
                },
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text('English'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: اربطها بـ LocaleCubit / easy_localization
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('الإعدادات')),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is! UserLoaded) {
              return const Center(child: Text('لم يتم تحميل بيانات المستخدم'));
            }

            final user = state.user;
            final email = auth.currentUser?.email ?? '';

            final imageUrl = user.image.trim();
            final hasImage = imageUrl.isNotEmpty &&
                (imageUrl.startsWith('http://') || imageUrl.startsWith('https://'));

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // ===== Profile Card =====
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 10,
                        color: Color(0x14000000),
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 36,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: hasImage ? NetworkImage(imageUrl) : null,
                            child: hasImage
                                ? null
                                : const Icon(Icons.person, size: 32, color: Colors.black54),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: InkWell(
                              onTap: _uploading ? null : () => _changePhoto(context),
                              borderRadius: BorderRadius.circular(999),
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: _uploading
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Icon(Icons.camera_alt, size: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${user.firstname} ${user.lastname}'.trim(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (user.isVerified)
                                  const Padding(
                                    padding: EdgeInsets.only(right: 6),
                                    child: Icon(Icons.verified, size: 18, color: Color(0xFF4A82FF)),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              email,
                              style: const TextStyle(color: Colors.black54),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // ===== Preferences =====
                const Text('التفضيلات', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),

                _SettingsTile(
                  icon: Icons.dark_mode,
                  title: 'المظهر',
                  subtitle: 'فاتح / داكن',
                  onTap: () => _showThemeSheet(context),
                ),

                _SettingsTile(
                  icon: Icons.language,
                  title: 'اللغة',
                  subtitle: 'العربية / English',
                  onTap: () => _showLanguageSheet(context),
                ),

                const SizedBox(height: 18),
                const Divider(),

                // ===== Security =====
                const SizedBox(height: 8),
                const Text('الأمان', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),

                _SettingsTile(
                  icon: Icons.lock,
                  title: 'تغيير كلمة المرور',
                  subtitle: 'إرسال رابط إعادة تعيين',
                  onTap: () => _sendResetPasswordEmail(context),
                ),
                _SettingsTile(
                  icon: Icons.lock,
                  title: 'تسجيل الخروج',
                  subtitle: 'تسجيل الخروج من الحساب',
                  onTap: () => logout(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_left),
        onTap: onTap,
      ),
    );
  }
}
