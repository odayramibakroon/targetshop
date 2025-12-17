 
 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/cubit/auth_cubit.dart';
import '../../features/auth/data/implements/implements.dart';
import '../../features/auth/data/sources/sources.dart';
import '../../features/auth/domain/repositories/repositories.dart';
import '../../features/auth/domain/usecases/adduserusecase.dart';
import '../../features/auth/domain/usecases/usecases.dart'; 
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../localization/language_cubit.dart';
import '../localization/language_data_source.dart';
final getIt = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {
     final sharedPrefs = await SharedPreferences.getInstance();

     getIt.registerLazySingleton<LanguageDataSource>(
      () => LanguageDataSource(sharedPrefs),
    );
    // Firebas e
    getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
     getIt.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(getIt(),getIt()));

 getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt()));
 
    // UseCase
    getIt.registerLazySingleton(() => SignUpUseCase(getIt()));

    // Cubit
  // UseCases
   //getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => AddUserUseCase(getIt()));

  // Cubit
  getIt.registerLazySingleton(() => AuthCubit(
        getIt(),
       // loginUseCase: getIt(),
       // addUserUseCase: getIt(),
        //firebaseAuth: getIt(),
      ));    
       getIt.registerLazySingleton<LanguageCubit>(
      () => LanguageCubit(
        getIt<LanguageDataSource>(),
        Locale('en'),  
      ),
    );
  }

   
}
