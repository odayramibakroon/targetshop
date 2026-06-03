import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/cubit/auth_cubit.dart';
import '../../features/auth/cubit/auth_register_cubit.dart';
import '../../features/auth/data/implements/implements.dart';
import '../../features/auth/data/sources/sources.dart';
import '../../features/auth/domain/repositories/repositories.dart';
import '../../features/auth/domain/usecases/adduserusecase.dart';
import '../../features/auth/domain/usecases/login_use_case.dart';
import '../../features/auth/domain/usecases/usecases.dart';

import '../../features/cart/cubit/cart_cubit.dart';
import '../../features/cart/data/implements/implements.dart';
import '../../features/cart/data/sources/sources.dart';
import '../../features/cart/domain/repositories/repositories.dart';
import '../../features/cart/domain/usecases/stream_user_products_use_case.dart';

import '../../features/favorites/cubit/favorite_products_cubit.dart';
import '../../features/favorites/data/implements/implements.dart';
import '../../features/favorites/data/sources/sources.dart';
import '../../features/favorites/domain/repositories/repositories.dart';
import '../../features/favorites/domain/usecases/favorite_products_usecase.dart';

import '../../features/home/cubit/categories_cubit.dart';
import '../../features/home/data/implements/implements.dart';
import '../../features/home/data/sources/sources.dart';
import '../../features/home/domain/repositories/repositories.dart';
import '../../features/home/domain/usecases/addcategory.dart';
import '../../features/home/domain/usecases/getproducts.dart';
import '../../features/home/domain/usecases/usecases.dart';

import '../../features/users/cubit/user_cubit.dart';

import '../localization/language_cubit.dart';
import '../localization/language_data_source.dart';

final getIt = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {
    final sharedPrefs = await SharedPreferences.getInstance();

    // ==================== Core / External
    getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

    getIt.registerLazySingleton<FirebaseAuth>(
      () => FirebaseAuth.instance,
    );

    getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );

    // ==================== Localization
    getIt.registerLazySingleton<LanguageDataSource>(
      () => LanguageDataSource(getIt<SharedPreferences>()),
    );

    getIt.registerLazySingleton<LanguageCubit>(
      () => LanguageCubit(
        getIt<LanguageDataSource>(),
        const Locale('en'),
      ),
    );

    // ==================== Auth Data Source
    getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        getIt<FirebaseAuth>(),
        getIt<FirebaseFirestore>(),
      ),
    );

    // ==================== Auth Repository
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        getIt<AuthRemoteDataSource>(),
      ),
    );

    // ==================== Auth Use Cases
    getIt.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(
        getIt<AuthRepository>(),
      ),
    );

    getIt.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(
        getIt<AuthRepository>(),
      ),
    );

    getIt.registerLazySingleton<AddUserUseCase>(
      () => AddUserUseCase(
        getIt<AuthRepository>(),
      ),
    );

    // ==================== Auth Cubits
    getIt.registerFactory<AuthCubit>(
      () => AuthCubit(
        getIt<LoginUseCase>(),
      ),
    );

    getIt.registerFactory<AuthRegisterCubit>(
      () => AuthRegisterCubit(
        getIt<RegisterUseCase>(),
      ),
    );

    getIt.registerFactory<UserCubit>(
      () => UserCubit(),
    );

    // ==================== Home Data Source
    getIt.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(
        firestore: getIt<FirebaseFirestore>(),
      ),
    );

    // ==================== Home Repository
    getIt.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImp(
        remoteDataSource: getIt<HomeRemoteDataSource>(),
      ),
    );

    // ==================== Home Use Cases
    getIt.registerLazySingleton<GetHomeUseCase>(
      () => GetHomeUseCase(
        repository: getIt<HomeRepository>(),
      ),
    );

    getIt.registerLazySingleton<AddCategoryUseCase>(
      () => AddCategoryUseCase(
          getIt<HomeRepository>(),
      ),
    );

    getIt.registerLazySingleton<GetProductsByCategoryUseCase>(
      () => GetProductsByCategoryUseCase(
        repository: getIt<HomeRepository>(),
      ),
    );

    // ==================== Home Cubit
    getIt.registerFactory<CategoriesCubit>(
      () => CategoriesCubit(
        getIt<GetHomeUseCase>(),
        getIt<AddCategoryUseCase>(),
      ),
    );

    // ==================== Favorites Data Source
    getIt.registerLazySingleton<FavoriteProductRemoteDataSource>(
      () => FavoriteProductRemoteDataSourceImpl(
        firestore: getIt<FirebaseFirestore>(),
      ),
    );

    // ==================== Favorites Repository
    getIt.registerLazySingleton<FavoritesRepository>(
      () => FavoritesRepositoryImpl(
        getIt<FavoriteProductRemoteDataSource>(),
      ),
    );

    // ==================== Favorites Use Cases
    getIt.registerLazySingleton<GetFavoriteProductsUseCase>(
      () => GetFavoriteProductsUseCase(
        getIt<FavoritesRepository>(),
      ),
    );

    // ==================== Favorites Cubit
    getIt.registerFactory<FavoriteProductsCubit>(
      () => FavoriteProductsCubit(
        getIt<GetFavoriteProductsUseCase>(),
      ),
    );

    // ==================== Cart Data Source
    getIt.registerLazySingleton<CartRemoteDataSource>(
      () => CartRemoteDataSourceImp(),
    );

    // ==================== Cart Repository
    getIt.registerLazySingleton<CartRepository>(
      () => CartRepositoryImp(
        remoteDataSource: getIt<CartRemoteDataSource>(),
      ),
    );

    // ==================== Cart Use Cases
    getIt.registerLazySingleton<StreamUserProductsUseCase>(
      () => StreamUserProductsUseCase(
        repository: getIt<CartRepository>(),
      ),
    );

    // ==================== Cart Cubit
    getIt.registerFactory<CartCubit>(
      () => CartCubit(
        getIt<StreamUserProductsUseCase>(),
      ),
    );
  }
}