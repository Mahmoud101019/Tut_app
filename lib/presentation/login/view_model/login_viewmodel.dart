import 'dart:async';

import 'package:tut_app/domain/usecase/login_usecase.dart';
import 'package:tut_app/presentation/base/baseviewmodel.dart';
import 'package:tut_app/presentation/common/freezed_data_classes.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel
    implements LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController usernameStreamController =
      StreamController<String>.broadcast();
  final StreamController passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController areAllInputsValid = StreamController<void>.broadcast();

  var loginObject = LoginObject("", "");

  final LoginUseCase loginUseCase;

  LoginViewModel({required this.loginUseCase});
  //inputs

  @override
  void dispose() {
    super.dispose();
    usernameStreamController.close();
    passwordStreamController.close();
    areAllInputsValid.close();
  }

  @override
  void start() {
    //view model should tell view please show content state

    inPutState.add(ContentState());
  }

  @override
  Sink get inputusername => usernameStreamController.sink;

  @override
  Sink get iputpassword => passwordStreamController.sink;

  @override
  Sink get inPutAreAllInputsValid => areAllInputsValid.sink;

  @override
  setpaswword(String password) {
    iputpassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inPutAreAllInputsValid.add(null);
  }

  @override
  setusername(String username) {
    inputusername.add(username);
    loginObject = loginObject.copyWith(username: username);
    inPutAreAllInputsValid.add(null);
  }

  @override
  login() async {
    inPutState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await loginUseCase.execute(LoginUseCaseInput(
            email: loginObject.username, password: loginObject.password)))
        .fold(
            (failure) => {
                  //left failure
                  inPutState.add(ErrorState(
                      stateRendererType: StateRendererType.popupErrorState,
                      message: failure.msg))
                },
            (data) => {
                  //right content State
                  inPutState.add(ContentState())
                  //navigator to Main Screen
                });
  }

  //Outputs

  @override
  Stream<bool> get outIsPasswordValid => passwordStreamController.stream
      .map((paswword) => ispasswordvalid(paswword));

  @override
  Stream<bool> get outIsUserNameValid => usernameStreamController.stream
      .map((username) => isusernamevalid(username));

  @override
  Stream<bool> get outPutAreAllInputValid =>
      areAllInputsValid.stream.map((_) => areAllInputsvalid());

  bool ispasswordvalid(String paswword) {
    return paswword.isNotEmpty;
  }

  bool isusernamevalid(String username) {
    return username.isNotEmpty;
  }

  bool areAllInputsvalid() {
    return isusernamevalid(loginObject.username) &&
        ispasswordvalid(loginObject.password);
  }
}

abstract class LoginViewModelInputs {
  setusername(String username);
  setpaswword(String password);
  login();

  Sink get inputusername;
  Sink get iputpassword;
  Sink get inPutAreAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsUserNameValid;
  Stream<bool> get outIsPasswordValid;
  Stream<bool> get outPutAreAllInputValid;
}
