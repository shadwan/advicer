import 'package:advicer/application/pages/advice/bloc/advicer_bloc.dart';
import 'package:advicer/data/datasources/advice_remote_datasource.dart';
import 'package:advicer/data/repositories/advice_repo_impl.dart';
import 'package:advicer/domain/usecases/advice_usecases.dart';
import 'package:get_it/get_it.dart';

import 'domain/repositories/advice_repo.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.I; // sl == Service Locator

Future<void> init() async {
  // ! Application Layer
  // Factory = every time a new/fresh instance of that class
  sl.registerFactory(() => AdvicerBloc(adviceUseCases: sl()));

  // ! Domain Layer
  sl.registerFactory(() => AdviceUseCases(adviceRepo: sl()));

  // ! Data Layer
  sl.registerFactory<AdviceRepo>(
      () => AdviceRepoImpl(adviceRemoteDataSource: sl()));
  sl.registerFactory<AdviceRemoteDataSource>(
      () => AdviceRemoteDataSourceImpl(client: sl()));

  // ! External
  sl.registerFactory(() => http.Client());
}
