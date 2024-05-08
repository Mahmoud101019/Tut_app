import 'package:tut_app/app/constans.dart';
import 'package:tut_app/app/extension.dart';
import 'package:tut_app/data/response/responses.dart';
import 'package:tut_app/domain/model/models.dart';

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

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return this?.support?.onEmbty() ?? Constants.empty;
  }
}

extension ServicesResponseMapper on ServicesResponse? {
  Services toDomain() {
    return Services(
      id: this?.id.onZero() ?? Constants.zero,
      title: this?.title.onEmbty() ?? Constants.empty,
      image: this?.image.onEmbty() ?? Constants.empty,
    );
  }
}

extension StoresResponseMapper on StoresResponse? {
  Stores toDomain() {
    return Stores(
      id: this?.id.onZero() ?? Constants.zero,
      title: this?.title.onEmbty() ?? Constants.empty,
      image: this?.image.onEmbty() ?? Constants.empty,
    );
  }
}

extension BannersResponseMapper on BannersResponse? {
  BannersAd toDomain() {
    return BannersAd(
      id: this?.id.onZero() ?? Constants.zero,
      link: this?.link.onEmbty() ?? Constants.empty,
      title: this?.title.onEmbty() ?? Constants.empty,
      image: this?.image.onEmbty() ?? Constants.empty,
    );
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Services> services = (this
                ?.data
                ?.services
                ?.map((servicesresponse) => servicesresponse.toDomain()) ??
            const Iterable.empty())
        .cast<Services>()
        .toList();

    List<BannersAd> banners = (this
                ?.data
                ?.banners
                ?.map((bannersresponse) => bannersresponse.toDomain()) ??
            const Iterable.empty())
        .cast<BannersAd>()
        .toList();

    List<Stores> stores = (this
                ?.data
                ?.stores
                ?.map((storesresponse) => storesresponse.toDomain()) ??
            const Iterable.empty())
        .cast<Stores>()
        .toList();

    var data = HomeData(services: services, banners: banners, stores: stores);

    return HomeObject(data: data);
  }
}
