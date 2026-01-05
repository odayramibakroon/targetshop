import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../auth/data/models/models.dart';
import '../data/models/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> loadUser() async {
    emit(UserLoading());

    try {
      // محاكاة تأخير لعرض السكيلتون
      await Future.delayed(const Duration(seconds: 2));

      final uid = FirebaseAuth.instance.currentUser!.uid;

      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .snapshots()
          .listen((doc) {
        if (doc.exists) {
          final data = doc.data()!;
          final user = UserViewModel.fromMap(data);

          // إضافة حالة verified
          final isVerified = data['verifiedaccount'] ?? false;

          emit(UserLoaded(user.copyWith(isVerified: isVerified)));
        }
      });
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Stream<UserViewModel> getUserStream() {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((doc) {
      final data = doc.data()!;
      final user = UserViewModel.fromMap(data);
      final isVerified = data['verifiedaccount'] ?? false;
      return user.copyWith(isVerified: isVerified);
    });
  }
}
