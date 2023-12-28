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
