// ignore_for_file: depend_on_referenced_packages

import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String username, String password) = _LoginObject;
}

@freezed
class SignUpObject with _$SignUpObject {
  factory SignUpObject(String userName, String countryCode, String mobileNumber,
      String email, String password, String profilePicture) = _SignUpObject;
}
