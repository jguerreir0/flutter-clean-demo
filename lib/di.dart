import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mydemo/home/domain/repositories/abstract_product_repository.dart';
import 'package:mydemo/home/domain/usecases/products_use_case.dart';
import 'package:mydemo/login/data/data_sources/abstract_auth_api.dart';
import 'package:mydemo/login/data/data_sources/auth_api_impl.dart';
import 'package:mydemo/login/data/repositories/auth_repository_impl.dart';
import 'package:mydemo/login/domain/repositories/abstract_auth_repository.dart';
import 'package:mydemo/login/domain/usecases/login_use_case.dart';
import 'package:mydemo/login/presentation/storage/auth_storage.dart';

import 'home/data/data_sources/abstract_product_api.dart';
import 'home/data/data_sources/product_api_impl.dart';
import 'home/data/repositories/product_repository_impl.dart';
import 'home/presentation/bloc/products_bloc/products_bloc.dart';
import 'login/presentation/bloc/auth_bloc/auth_bloc.dart';

final sl = GetIt.instance;

void setupDI() {
  // Dio
  sl.registerFactory<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: 'https://dummyjson.com/',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    ),
  );

  // Storage
  sl.registerFactory<AuthStorage>(() => AuthStorage());

  // APIs
  sl.registerSingleton<AbstractAuthApi>(AuthApiImpl(sl()));
  sl.registerSingleton<AbstractProductApi>(ProductApiImpl(sl()));

  // Repositories
  sl.registerSingleton<AbstractAuthRepository>(AuthRepositoryImpl(sl()));
  sl.registerSingleton<AbstractProductRepository>(ProductRepositoryImpl(sl()));

  // Use cases
  sl.registerSingleton<LoginUseCase>(LoginUseCase(sl()));
  sl.registerSingleton<ProductsUseCase>(ProductsUseCase(sl()));

  // Blocs
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl()));
  sl.registerFactory<ProductsBloc>(() => ProductsBloc(sl()));
}

Widget withAuthBloc({required Widget child}) => BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: child,
    );

Widget withAuthAndProductsBloc({required Widget child}) => MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<ProductsBloc>()),
      ],
      child: child,
    );
