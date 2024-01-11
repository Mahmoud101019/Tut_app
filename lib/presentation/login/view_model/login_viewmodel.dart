import 'dart:async';

import 'package:tut_app/domain/usecase/login_usecase.dart';
import 'package:tut_app/presentation/base/baseviewmodel.dart';
import 'package:tut_app/presentation/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    implements LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController usernameStreamController =
      StreamController<String>.broadcast();
  final StreamController passwordStreamController =
      StreamController<String>.broadcast();

  var loginObject = LoginObject("", "");

  final LoginUseCase loginUseCase;

  LoginViewModel({required this.loginUseCase});
  //inputs

  @override
  void dispose() {
    usernameStreamController.close();
    passwordStreamController.close();
  }

  @override
  void start() {}

  @override
  Sink get inputusername => usernameStreamController.sink;

  @override
  Sink get iputpassword => passwordStreamController.sink;

  @override
  setpaswword(String password) {
    inputusername.add(password);
    loginObject = loginObject.copyWith(password: password);
  }

  @override
  setusername(String username) {
    inputusername.add(username);
    loginObject = loginObject.copyWith(username: username);
  }

  @override
  login() async {
    (await loginUseCase.execute(LoginUseCaseInput(
            email: loginObject.username, password: loginObject.password)))
        .fold(
            (failure) => {
                  //left
                  print(failure.msg)
                },
            (data) => {
                  //right
                  print(data.customer?.name)
                });
  }

  //Outputs

  @override
  Stream<bool> get outIsPasswordValid => passwordStreamController.stream
      .map((paswword) => ispasswordvalid(paswword));

  @override
  Stream<bool> get outIsUserNameValid => usernameStreamController.stream
      .map((username) => isusernamevalid(username));

  bool ispasswordvalid(String paswword) {
    return paswword.isNotEmpty;
  }

  bool isusernamevalid(String username) {
    return username.isNotEmpty;
  }
}

abstract class LoginViewModelInputs {
  setusername(String username);
  setpaswword(String password);
  login();

  Sink get inputusername;
  Sink get iputpassword;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsUserNameValid;
  Stream<bool> get outIsPasswordValid;
}
