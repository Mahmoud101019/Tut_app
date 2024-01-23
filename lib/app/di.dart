import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/data/data_source/remote_data_source.dart';
import 'package:tut_app/data/network/app_api.dart';
import 'package:tut_app/data/network/dio_factory.dart';
import 'package:tut_app/data/network/network_info.dart';
import 'package:tut_app/data/repository/repository_impl.dart';
import 'package:tut_app/domain/repositroy/repository.dart';
import 'package:tut_app/domain/usecase/forgetpassword_use_case.dart';
import 'package:tut_app/domain/usecase/login_usecase.dart';
import 'package:tut_app/presentation/forgetpassword/view_model/forgetpassword_view_model.dart';
import 'package:tut_app/presentation/login/view_model/login_viewmodel.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  //SharedPreferences instance
  final sharedPref = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPref);

  //AppPreferences instance

  instance.registerLazySingleton<AppPreferences>(
      () => AppPreferences(sharedPreferences: instance<SharedPreferences>()));

  //NetworkInfo instance

  instance.registerLazySingleton<NetworkInfo>(() =>
      NetworkInfoImpl(internetConnectionChecker: InternetConnectionChecker()));

  //DioFactory instance

  instance.registerLazySingleton<DioFactory>(
      () => DioFactory(appPreferences: instance<AppPreferences>()));

  Dio dio = await instance<DioFactory>().getdio();

  //AppServicesClient instance

  instance
      .registerLazySingleton<AppServicesClient>(() => AppServicesClient(dio));

  //RemoteDataSource instance

  instance.registerLazySingleton<RemoteDataSource>(() =>
      RemoteDataSourceImpl(appServicesClient: instance<AppServicesClient>()));

  //Repository instance

  instance.registerLazySingleton<Repository>(() => RepositoryImpl(
      remoteDataSource: instance<RemoteDataSource>(),
      networkInfo: instance<NetworkInfo>()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    //LoginUseCase instance

    instance.registerFactory<LoginUseCase>(
        () => LoginUseCase(repository: instance<Repository>()));

    //LoginViewModel instance

    instance.registerFactory<LoginViewModel>(
        () => LoginViewModel(loginUseCase: instance<LoginUseCase>()));
  }
}

initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(
        () => ForgotPasswordViewModel(forgotPasswordUseCase: instance()));
  }
}

// initForgotPasswordModule() {
//   if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
//     //ForgetPaswwordUseCase instance

//     instance.registerFactory<ForgotPasswordUseCase>(
//         () => ForgotPasswordUseCase(repository: instance<Repository>()));

//     //ForgetPasswordViewModel instance

//     instance.registerFactory<ForgotPasswordViewModel>(() =>
//         ForgotPasswordViewModel(
//             forgotPasswordUseCase: instance<ForgotPasswordUseCase>()));
//   }
// }
