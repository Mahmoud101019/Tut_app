import 'package:tut_app/app/constans.dart';

extension NonNullString on String? {
  String onEmbty() {
    if (this == null) {
      return Constants.empty;
    } else {
      return this!;
    }
  }
}

extension NonNullint on int? {
  int onZero() {
    if (this == null) {
      return Constants.zero;
    } else {
      return this!;
    }
  }
}
