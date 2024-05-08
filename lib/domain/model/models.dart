class Sliderobject {
  String title;
  String subtitle;
  String image;

  Sliderobject({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

class SliderViewObject {
  Sliderobject sliderobject;
  int numberofslid;
  int currentindex;

  SliderViewObject({
    required this.sliderobject,
    required this.currentindex,
    required this.numberofslid,
  });
}

class Customer {
  String id;
  String name;
  int numofnotifications;

  Customer({
    required this.id,
    required this.name,
    required this.numofnotifications,
  });
}

class Contacts {
  String phone;
  String email;
  String link;

  Contacts({
    required this.phone,
    required this.email,
    required this.link,
  });
}

class Authentication {
  Customer? customer;
  Contacts? contacts;

  Authentication({
    required this.customer,
    required this.contacts,
  });
}

class Services {
  int id;
  String title;
  String image;

  Services({
    required this.id,
    required this.title,
    required this.image,
  });
}

class BannersAd {
  int id;
  String link;
  String title;
  String image;

  BannersAd({
    required this.id,
    required this.link,
    required this.title,
    required this.image,
  });
}

class Stores {
  int id;
  String title;
  String image;

  Stores({
    required this.id,
    required this.title,
    required this.image,
  });
}

class HomeData {
  List<Services> services;
  List<BannersAd> banners;
  List<Stores> stores;

  HomeData({
    required this.services,
    required this.banners,
    required this.stores,
  });
}

class HomeObject {
  HomeData data;

  HomeObject({
    required this.data,
  });
}
