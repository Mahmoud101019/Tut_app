import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tut_app/domain/model/models.dart';
import 'package:tut_app/domain/usecase/home_use_case.dart';
import 'package:tut_app/presentation/base/baseviewmodel.dart';

class HomeViewModel extends BaseViewModel
    implements HomeViewModelInputs, HomeViewModelOutputs {
  StreamController bannersStreamController = BehaviorSubject<List<BannersAd>>();
  StreamController servicesStreamController = BehaviorSubject<List<Services>>();
  StreamController storesStreamController = BehaviorSubject<List<Stores>>();

  final HomeUseCase homeUseCase;

  HomeViewModel({
    required this.homeUseCase,
  });

  //-- Inputs -- //

  @override
  void start() {}

  @override
  void dispose() {
    bannersStreamController.close();
    servicesStreamController.close();
    storesStreamController.close();
  }

  @override
  Sink get inputBanners => bannersStreamController.sink;

  @override
  Sink get inputServices => servicesStreamController.sink;

  @override
  Sink get inputStores => storesStreamController.sink;

  //-- OutPuts -- //

  @override
  Stream<List<BannersAd>> get outputBanners =>
      bannersStreamController.stream.map((banners) => banners);

  @override
  Stream<List<Services>> get outputServices =>
      servicesStreamController.stream.map((services) => services);

  @override
  Stream<List<Stores>> get outputStores =>
      storesStreamController.stream.map((store) => store);
}

abstract class HomeViewModelInputs {
  Sink get inputStores;
  Sink get inputServices;
  Sink get inputBanners;
}

abstract class HomeViewModelOutputs {
  Stream<List<Stores>> get outputStores;
  Stream<List<Services>> get outputServices;
  Stream<List<BannersAd>> get outputBanners;
}
