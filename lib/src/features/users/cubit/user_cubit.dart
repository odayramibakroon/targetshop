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
     final uid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .snapshots()
      .listen((doc) {
        final user = UserViewModel.fromMap(doc.data()!);
        emit(UserLoaded(user));
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
      .map((doc) => UserViewModel.fromMap(doc.data()!));
}

}
