// ignore_for_file: void_checks

import 'dart:async';
import 'dart:ffi';

import 'package:rxdart/rxdart.dart';
import 'package:tut_app/domain/model/models.dart';
import 'package:tut_app/domain/usecase/store_details_usecase.dart';
import 'package:tut_app/presentation/base/baseviewmodel.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';

class StoreDetailsViewModel extends BaseViewModel
    implements StoreDetailsViewModelInput, StoreDetailsViewModelOutput {
  final _storeDetailsStreamController = BehaviorSubject<StoreDetails>();

  final StoreDetailsUseCase storeDetailsUseCase;

  StoreDetailsViewModel({required this.storeDetailsUseCase});

  @override
  start() async {
    _loadData();
  }

  _loadData() async {
    inPutState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await storeDetailsUseCase.execute(Void)).fold(
      (failure) {
        inPutState.add(ErrorState(
          stateRendererType: StateRendererType.fullScreenErrorState,
          message: failure.msg,
        ));
      },
      (storeDetails) async {
        inPutState.add(ContentState());
        inputStoreDetails.add(storeDetails);
      },
    );
  }

  @override
  void dispose() {
    _storeDetailsStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputStoreDetails => _storeDetailsStreamController.sink;

  //output
  @override
  Stream<StoreDetails> get outputStoreDetails =>
      _storeDetailsStreamController.stream.map((stores) => stores);
}

abstract class StoreDetailsViewModelInput {
  Sink get inputStoreDetails;
}

abstract class StoreDetailsViewModelOutput {
  Stream<StoreDetails> get outputStoreDetails;
}
