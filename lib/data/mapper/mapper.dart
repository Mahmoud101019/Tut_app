import 'package:tut_app/app/constans.dart';
import 'package:tut_app/app/extension.dart';
import 'package:tut_app/data/response/responses.dart';
import 'package:tut_app/domain/models.dart';

extension CustomerResponsemapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      id: this?.id.onEmbty() ?? Constants.empty,
      name: this?.name.onEmbty() ?? Constants.empty,
      numofnotifications: this?.numofnotifications.onZero() ?? Constants.zero,
    );
  }
}

extension ContactsResponsemapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
      phone: this?.phone.onEmbty() ?? Constants.empty,
      email: this?.email.onEmbty() ?? Constants.empty,
      link: this?.link.onEmbty() ?? Constants.empty,
    );
  }
}

extension AuthenticationResponseemapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      customer: this?.customer.toDomain(),
      contacts: this?.contacts.toDomain(),
    );
  }
}
