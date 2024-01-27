import 'dart:async';
import 'dart:io';

import 'package:tut_app/app/constans.dart';
import 'package:tut_app/app/finc.dart';
import 'package:tut_app/domain/usecase/signup_use_case.dart';
import 'package:tut_app/presentation/base/baseviewmodel.dart';
import 'package:tut_app/presentation/common/freezed_data_classes.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:tut_app/presentation/resourses/strings_manager.dart';

class SignUpViewModel extends BaseViewModel
    implements SignUpViewModelInPut, SignUpViewModelOutPut {
  StreamController userNamestreamController =
      StreamController<String>.broadcast();
  StreamController mobileNumberstreamController =
      StreamController<String>.broadcast();
  StreamController emailstreamController = StreamController<String>.broadcast();
  StreamController passwordstreamController =
      StreamController<String>.broadcast();
  StreamController profilePicturetreamController =
      StreamController<File>.broadcast();
  StreamController areAllInPutValidstreamController =
      StreamController<void>.broadcast();

  final StreamController isUserSignupSuccessfullyStreamController =
      StreamController<bool>();

  final SignUpUseCase signUpUseCase;

  var signUpObject = SignUpObject("", "", "", "", "", "");

  SignUpViewModel({
    required this.signUpUseCase,
  });

  //inputs

  @override
  void start() {
    inPutState.add(ContentState());
  }

  @override
  void dispose() {
    userNamestreamController.close();
    mobileNumberstreamController.close();
    emailstreamController.close();
    passwordstreamController.close();
    profilePicturetreamController.close();
    areAllInPutValidstreamController.close();
    isUserSignupSuccessfullyStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputEmail => emailstreamController.sink;

  @override
  Sink get inputMobileNumber => mobileNumberstreamController.sink;

  @override
  Sink get inputPassword => passwordstreamController.sink;

  @override
  Sink get inputProfilePicture => profilePicturetreamController.sink;

  @override
  Sink get inputUsername => userNamestreamController.sink;

  @override
  Sink get inputsAllInPutsValid => areAllInPutValidstreamController.sink;

  ////////////////////////////Set All Inputs/////////////////////////////////////

  @override
  setUserName(String userName) {
    inputUsername.add(userName);
    if (isUserNameValid(userName)) {
      // update SignUp View Object
      signUpObject = signUpObject.copyWith(userName: userName);
    } else {
      // Reste username value in signup view object
      signUpObject = signUpObject.copyWith(userName: Constants.empty);
    }
    validate();
  }

  @override
  setCountryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      // update SignUp View Object
      signUpObject = signUpObject.copyWith(countryCode: countryCode);
    } else {
      // Reste countryCode value in signup view object
      signUpObject = signUpObject.copyWith(countryCode: Constants.empty);
    }
    validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (isEmailValid(email)) {
      // update SignUp View Object
      signUpObject = signUpObject.copyWith(email: email);
    } else {
      // Reste email value in signup view object
      signUpObject = signUpObject.copyWith(email: Constants.empty);
    }
    validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if (isMobileValidValid(mobileNumber)) {
      // update SignUp View Object
      signUpObject = signUpObject.copyWith(mobileNumber: mobileNumber);
    } else {
      // Reste mobileNumber value in signup view object
      signUpObject = signUpObject.copyWith(mobileNumber: Constants.empty);
    }
    validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (isPasswordValidValid(password)) {
      // update SignUp View Object
      signUpObject = signUpObject.copyWith(password: password);
    } else {
      // Reste password value in signup view object
      signUpObject = signUpObject.copyWith(password: Constants.empty);
    }
    validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    if (profilePicture.path.isNotEmpty) {
      // update SignUp View Object
      signUpObject = signUpObject.copyWith(profilePicture: profilePicture.path);
    } else {
      // Reste profilePicture value in signup view object
      signUpObject = signUpObject.copyWith(profilePicture: Constants.empty);
    }
    validate();
  }

  ////////////////////////////Sign Up Function/////////////////////////////////////

  @override
  signUp() async {
    inPutState.add(
      LoadingState(stateRendererType: StateRendererType.popupLoadingState),
    );
    (await signUpUseCase.execute(
      SignUpUseCaseInPut(
        userName: signUpObject.userName,
        countryCode: signUpObject.countryCode,
        mobileNumber: signUpObject.mobileNumber,
        email: signUpObject.email,
        password: signUpObject.password,
        profilePicture: signUpObject.profilePicture,
      ),
    ))
        .fold((failure) {
      //left failure
      inPutState.add(
        ErrorState(
            stateRendererType: StateRendererType.popupErrorState,
            message: failure.msg),
      );
    }, (data) {
      //right content State
      inPutState.add(ContentState());
      //navigator to Main Screen
      isUserSignupSuccessfullyStreamController.add(true);
    });
  }

  //Outputs

  ////////////////////////////UserName Output/////////////////////////////////////

  @override
  Stream<bool> get outPutIsUserNameValid => userNamestreamController.stream
      .map((userName) => isUserNameValid(userName));

  @override
  Stream<String?> get outPutErrorUserName => outPutIsUserNameValid.map(
      (isUserNameValid) => isUserNameValid ? null : AppStrings.userNameValid);

  ////////////////////////////Email Output/////////////////////////////////////

  @override
  Stream<bool> get outPutIsEmailValid =>
      emailstreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<String?> get outPutErrorEmail => outPutIsEmailValid
      .map((isEmailvalid) => isEmailvalid ? null : AppStrings.emailValid);

  ////////////////////////////Mobile Output/////////////////////////////////////

  @override
  Stream<bool> get outPutIsMobileNumberValid =>
      mobileNumberstreamController.stream
          .map((mobileNumber) => isMobileValidValid(mobileNumber));

  @override
  Stream<String?> get outPutErrorMobileNumber =>
      outPutIsMobileNumberValid.map((isMobileValidValid) =>
          isMobileValidValid ? null : AppStrings.mobileNumberValid);

  ////////////////////////////Password Output/////////////////////////////////////

  @override
  Stream<bool> get outPutIsPasswordValid => passwordstreamController.stream
      .map((password) => isPasswordValidValid(password));

  @override
  Stream<String?> get outPutErrorPassword =>
      outPutIsPasswordValid.map((isPasswordValidValid) =>
          isPasswordValidValid ? null : AppStrings.passwordValid);

  ////////////////////////////Profile Picture Output/////////////////////////////////////

  @override
  Stream<File> get outPutIsProfilePictureValid =>
      profilePicturetreamController.stream.map((file) => file);

  ////////////////////////////Enable And Disable Buttom Output/////////////////////////////////////

  @override
  Stream<bool> get outPutsAreAllInputsValid =>
      areAllInPutValidstreamController.stream.map((_) => areAllinputsvalid());

  ////////////////////////////Functions Output/////////////////////////////////////

  bool isUserNameValid(String userName) {
    return userName.length >= 8;
  }

  bool isMobileValidValid(String mobileNumber) {
    return mobileNumber.length >= 10;
  }

  bool isPasswordValidValid(String password) {
    return password.length >= 6;
  }

  bool areAllinputsvalid() {
    return signUpObject.userName.isNotEmpty &&
        signUpObject.countryCode.isNotEmpty &&
        signUpObject.mobileNumber.isNotEmpty &&
        signUpObject.email.isNotEmpty &&
        signUpObject.password.isNotEmpty &&
        signUpObject.profilePicture.isNotEmpty;
  }

  validate() {
    inputsAllInPutsValid.add(null);
  }
}

abstract class SignUpViewModelInPut {
  Sink get inputUsername;

  Sink get inputMobileNumber;

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputProfilePicture;

  Sink get inputsAllInPutsValid;

  signUp();

  setUserName(String userName);

  setCountryCode(String countryCode);

  setMobileNumber(String mobileNumber);

  setEmail(String email);

  setPassword(String password);

  setProfilePicture(File profilePicture);
}

abstract class SignUpViewModelOutPut {
  Stream<bool> get outPutIsUserNameValid;
  Stream<String?> get outPutErrorUserName;
  //
  Stream<bool> get outPutIsMobileNumberValid;
  Stream<String?> get outPutErrorMobileNumber;
  //
  Stream<bool> get outPutIsEmailValid;
  Stream<String?> get outPutErrorEmail;
  //
  Stream<bool> get outPutIsPasswordValid;
  Stream<String?> get outPutErrorPassword;
  //
  Stream<File> get outPutIsProfilePictureValid;
  //
  Stream<bool> get outPutsAreAllInputsValid;
}
