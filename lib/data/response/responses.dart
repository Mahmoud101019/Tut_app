// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "messages")
  String? messages;
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numofnotifications")
  int? numofnotifications;
  CustomerResponse(
    this.id,
    this.name,
    this.numofnotifications,
  );
  //from Json
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);
  //To Json
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "link")
  String? link;
  ContactsResponse(
    this.email,
    this.phone,
    this.link,
  );

  //from Json
  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);
  //To Json
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contacts")
  ContactsResponse? contacts;
  AuthenticationResponse(
    this.contacts,
    this.customer,
  );
  //from Json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);
  //To Json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class ForgotPasswordResponse extends BaseResponse {
  @JsonKey(name: 'support')
  String? support;

  ForgotPasswordResponse(this.support);

// toJson
  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);

//fromJson
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);
}

@JsonSerializable()
class ServicesResponse {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'image')
  String? image;

  ServicesResponse({
    required this.id,
    required this.title,
    required this.image,
  });

// toJson
  Map<String, dynamic> toJson() => _$ServicesResponseToJson(this);

//fromJson
  factory ServicesResponse.fromJson(Map<String, dynamic> json) =>
      _$ServicesResponseFromJson(json);
}

@JsonSerializable()
class BannersResponse {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'link')
  String? link;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'image')
  String? image;

  BannersResponse(
      {required this.id,
      required this.link,
      required this.title,
      required this.image});

  // toJson
  Map<String, dynamic> toJson() => _$BannersResponseToJson(this);

//fromJson
  factory BannersResponse.fromJson(Map<String, dynamic> json) =>
      _$BannersResponseFromJson(json);
}

@JsonSerializable()
class StoresResponse {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'image')
  String? image;

  StoresResponse({
    required this.id,
    required this.title,
    required this.image,
  });

// toJson
  Map<String, dynamic> toJson() => _$StoresResponseToJson(this);

//fromJson
  factory StoresResponse.fromJson(Map<String, dynamic> json) =>
      _$StoresResponseFromJson(json);
}

@JsonSerializable()
class HomeDataResponse {
  @JsonKey(name: 'services')
  List<ServicesResponse>? services;

  @JsonKey(name: 'banners')
  List<BannersResponse>? banners;

  @JsonKey(name: 'stores')
  List<StoresResponse>? stores;

  HomeDataResponse({
    required this.stores,
    required this.banners,
    required this.services,
  });

  // toJson
  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);

//fromJson
  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);
}

@JsonSerializable()
class HomeResponse extends BaseResponse {
  @JsonKey(name: 'data')
  HomeDataResponse? data;

  HomeResponse({
    required this.data,
  });

  // toJson
  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);

//fromJson
  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);
}

@JsonSerializable()
class StoreDetailsResponse extends BaseResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'details')
  String? details;
  @JsonKey(name: 'services')
  String? services;
  @JsonKey(name: 'about')
  String? about;

  StoreDetailsResponse({
    required this.id,
    required this.title,
    required this.image,
    required this.details,
    required this.services,
    required this.about,
  });

  factory StoreDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoreDetailsResponseToJson(this);
}
