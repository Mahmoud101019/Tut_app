// ignore_for_file: void_checks

import 'dart:async';
import 'dart:ffi';

import 'package:rxdart/rxdart.dart';
import 'package:tut_app/domain/model/models.dart';
import 'package:tut_app/domain/usecase/home_use_case.dart';
import 'package:tut_app/presentation/base/baseviewmodel.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';

class HomeViewModel extends BaseViewModel
    implements HomeViewModelInputs, HomeViewModelOutputs {
  final dataStreamController = BehaviorSubject<HomeViewObject>();

  final HomeUseCase homeUseCase;

  HomeViewModel({
    required this.homeUseCase,
  });

  //-- Inputs -- //

  @override
  void start() {
    getHomeData();
  }

  getHomeData() async {
    inPutState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await homeUseCase.execute(Void)).fold((failure) {
      //left failure
      inPutState.add(ErrorState(
          stateRendererType: StateRendererType.fullScreenErrorState,
          message: failure.msg));
    }, (homeObject) {
      //right content State
      inPutState.add(ContentState());
      inputHomeData.add(HomeViewObject(
        homeObject.data.stores,
        homeObject.data.services,
        homeObject.data.banners,
      ));
    });
  }

  @override
  void dispose() {
    dataStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputHomeData => dataStreamController.sink;

  //-- OutPuts -- //

  @override
  Stream<HomeViewObject> get outputHomeData =>
      dataStreamController.stream.map((data) => data);
}

abstract class HomeViewModelInputs {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutputs {
  Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject {
  List<Stores> stores;
  List<Services> services;
  List<BannersAd> banners;
  HomeViewObject(this.stores, this.services, this.banners);
}
