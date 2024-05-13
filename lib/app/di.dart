import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/data/data_source/local_data_source.dart';
import 'package:tut_app/data/data_source/remote_data_source.dart';
import 'package:tut_app/data/network/app_api.dart';
import 'package:tut_app/data/network/dio_factory.dart';
import 'package:tut_app/data/network/network_info.dart';
import 'package:tut_app/data/repository/repository_impl.dart';
import 'package:tut_app/domain/repositroy/repository.dart';
import 'package:tut_app/domain/usecase/forgetpassword_use_case.dart';
import 'package:tut_app/domain/usecase/home_use_case.dart';
import 'package:tut_app/domain/usecase/login_usecase.dart';
import 'package:tut_app/domain/usecase/signup_use_case.dart';
import 'package:tut_app/domain/usecase/store_details_usecase.dart';
import 'package:tut_app/presentation/forgetpassword/view_model/forgetpassword_view_model.dart';
import 'package:tut_app/presentation/login/view_model/login_viewmodel.dart';
import 'package:tut_app/presentation/main/pages/home/view_model/home_view_model.dart';
import 'package:tut_app/presentation/signup/view_model/signup_view_model.dart';
import 'package:tut_app/presentation/storedetails/view_model/store_details_view_model.dart';

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

  //LocalDataSource instance

  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  //Repository instance

  instance.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      remoteDataSource: instance<RemoteDataSource>(),
      networkInfo: instance<NetworkInfo>(),
      localDataSource: instance<LocalDataSource>(),
    ),
  );
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

initSignUpModule() {
  if (!GetIt.I.isRegistered<SignUpUseCase>()) {
    instance.registerFactory<SignUpUseCase>(
        () => SignUpUseCase(repository: instance()));
    instance.registerFactory<SignUpViewModel>(
        () => SignUpViewModel(signUpUseCase: instance()));
    instance.registerFactory<ImagePicker>(
      () => ImagePicker(),
    );
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(
        () => HomeUseCase(repository: instance()));
    instance.registerFactory<HomeViewModel>(
        () => HomeViewModel(homeUseCase: instance()));
  }
}

initStoreDetailsModule() {
  if (!GetIt.I.isRegistered<StoreDetailsUseCase>()) {
    instance.registerFactory<StoreDetailsUseCase>(
        () => StoreDetailsUseCase(repository: instance()));
    instance.registerFactory<StoreDetailsViewModel>(
        () => StoreDetailsViewModel(storeDetailsUseCase: instance()));
  }
}
