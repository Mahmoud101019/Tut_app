// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'dart:async';
import 'package:tut_app/domain/model/models.dart';
import 'package:tut_app/presentation/base/baseviewmodel.dart';
import 'package:tut_app/presentation/resourses/app_assets_manager.dart';
import 'package:tut_app/presentation/resourses/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    implements OnBoardingViewModelInput, OnBoardingViewModelOutput {
  final StreamController _streamController =
      StreamController<SliderViewObject>();
  late final List<Sliderobject> _list;
  int _curntpageindex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getsliderdata();
    _postdatatoview();
  }

  @override
  int goback() {
    int priviousindex = --_curntpageindex;
    if (priviousindex == -1) {
      priviousindex = _list.length - 1;
    }
    return priviousindex;
  }

  @override
  int gonext() {
    int nextindex = ++_curntpageindex;
    if (nextindex == _list.length) {
      nextindex = 0;
    }
    return nextindex;
  }

  @override
  void onchangepage(int index) {
    _curntpageindex = index;
    _postdatatoview();
  }

  @override
  Sink get inputsliderviewobject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputsliderviewobject =>
      _streamController.stream.map((SliderViewObject) => SliderViewObject);

  void _postdatatoview() {
    inputsliderviewobject.add(SliderViewObject(
      sliderobject: _list[_curntpageindex],
      currentindex: _curntpageindex,
      numberofslid: _list.length,
    ));
  }

  List<Sliderobject> _getsliderdata() => [
        Sliderobject(
          title: AppStrings.onBoardingTitle1,
          subtitle: AppStrings.onBoardingSubTitle1,
          image: AppAssets.onboarding1,
        ),
        Sliderobject(
          title: AppStrings.onBoardingTitle2,
          subtitle: AppStrings.onBoardingSubTitle2,
          image: AppAssets.onboarding2,
        ),
        Sliderobject(
          title: AppStrings.onBoardingTitle3,
          subtitle: AppStrings.onBoardingSubTitle3,
          image: AppAssets.onboarding3,
        ),
        Sliderobject(
          title: AppStrings.onBoardingTitle4,
          subtitle: AppStrings.onBoardingSubTitle4,
          image: AppAssets.onboarding4,
        ),
      ];
}

abstract class OnBoardingViewModelInput {
  int gonext();
  int goback();
  void onchangepage(int index);
  Sink get inputsliderviewobject;
}

abstract class OnBoardingViewModelOutput {
  Stream<SliderViewObject> get outputsliderviewobject;
}
