import 'dart:async';

import 'package:tut_app/app/finc.dart';
import 'package:tut_app/domain/usecase/forgetpassword_use_case.dart';
import 'package:tut_app/presentation/base/baseviewmodel.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';

class ForgotPasswordViewModel extends BaseViewModel
    implements ForgotPasswordViewModelInput, ForgotPasswordViewModelOutput {
  final StreamController emailStreamController =
      StreamController<String>.broadcast();
  final StreamController isAllInputValidStreamController =
      StreamController<void>.broadcast();

  final ForgotPasswordUseCase forgotPasswordUseCase;

  ForgotPasswordViewModel({required this.forgotPasswordUseCase});

  var email = "";

  // input
  @override
  void start() {
    inPutState.add(ContentState());
  }

  @override
  forgotPassword() async {
    inPutState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await forgotPasswordUseCase.execute(email)).fold((failure) {
      inPutState.add(ErrorState(
          stateRendererType: StateRendererType.popupErrorState,
          message: failure.msg));
    }, (supportMessage) {
      inPutState.add(SuccessState(message: supportMessage));
    });
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    _validate();
  }

  @override
  Sink get inputEmail => emailStreamController.sink;

  @override
  Sink get inputIsAllInputValid => isAllInputValidStreamController.sink;

  // output
  @override
  void dispose() {
    emailStreamController.close();
    isAllInputValidStreamController.close();
  }

  @override
  Stream<bool> get outputIsEmailValid =>
      emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outputIsAllInputValid =>
      isAllInputValidStreamController.stream
          .map((isAllInputValid) => _isAllInputValid());

  _isAllInputValid() {
    return isEmailValid(email);
  }

  _validate() {
    inputIsAllInputValid.add(null);
  }
}

abstract class ForgotPasswordViewModelInput {
  forgotPassword();

  setEmail(String email);

  Sink get inputEmail;

  Sink get inputIsAllInputValid;
}

abstract class ForgotPasswordViewModelOutput {
  Stream<bool> get outputIsEmailValid;

  Stream<bool> get outputIsAllInputValid;
}
