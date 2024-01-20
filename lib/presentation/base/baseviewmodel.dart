import 'dart:async';

import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInput
    implements BaseViewModelOutput {
  final StreamController inputStreamController =
      StreamController<FlowState>.broadcast();

  @override
  Sink get inPutState => inputStreamController.sink;

  @override
  Stream<FlowState> get outPutState =>
      inputStreamController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    inputStreamController.close();
  }
}

abstract class BaseViewModelInput {
  void start();

  void dispose();

  Sink get inPutState;
}

abstract class BaseViewModelOutput {
  Stream<FlowState> get outPutState;
}
