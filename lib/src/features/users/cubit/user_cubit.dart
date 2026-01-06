import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../data/models/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _userSubscription;

  Future<void> loadUser() async {
    emit(UserLoading());

    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;

       await _userSubscription?.cancel();

       _userSubscription = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .snapshots()
          .listen((doc) {
        if (!doc.exists) return;

        final data = doc.data()!;
        final user = UserViewModel.fromMap(data);

        final isVerified = data['verifiedaccount'] ?? false;

        emit(UserLoaded(user.copyWith(isVerified: isVerified)));
      });
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
    
   Future<void> clearUser() async {

    await _userSubscription?.cancel();
    _userSubscription = null;
    emit(UserInitial());
  }

  @override
  Future<void> close() async {
    await _userSubscription?.cancel();
    return super.close();
  }
}
