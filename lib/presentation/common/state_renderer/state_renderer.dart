// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tut_app/presentation/resourses/app_assets_manager.dart';
import 'package:tut_app/presentation/resourses/color_manager.dart';
import 'package:tut_app/presentation/resourses/fonts_manager.dart';
import 'package:tut_app/presentation/resourses/strings_manager.dart';
import 'package:tut_app/presentation/resourses/style_manager.dart';
import 'package:tut_app/presentation/resourses/values_manager.dart';

enum StateRendererType {
  // POPUP STATES (DIALOG)
  popupLoadingState,
  popupErrorState,
  popupSuccess,
  // FULL SCREEN STATED (FULL SCREEN)
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,
  // general
  contentState
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String msg;
  String title;
  Function retryactionFunction;

  StateRenderer({
    super.key,
    this.msg = AppStrings.loading,
    required this.retryactionFunction,
    required this.stateRendererType,
    this.title = "",
  });
  @override
  Widget build(BuildContext context) {
    return getStateWidget(context);
  }

  Widget getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return getPopUpDilalog(
          context,
          [
            getAnimatedImage(JsonAssets.loading),
          ],
        );
      case StateRendererType.popupErrorState:
        return getPopUpDilalog(
          context,
          [
            getAnimatedImage(JsonAssets.error),
            getMsg(msg),
            getRetryButton(AppStrings.ok, context),
          ],
        );
      case StateRendererType.popupSuccess:
        return getPopUpDilalog(context, [
          getAnimatedImage(JsonAssets.success),
          getMsg(title),
          getMsg(msg),
          getRetryButton(AppStrings.ok, context),
        ]);
      case StateRendererType.fullScreenLoadingState:
        return getItemsColumn(
          [
            getAnimatedImage(JsonAssets.loading),
            getMsg(msg),
          ],
        );
      case StateRendererType.fullScreenErrorState:
        return getItemsColumn(
          [
            getAnimatedImage(JsonAssets.error),
            getMsg(msg),
            getRetryButton(AppStrings.retryAgain, context),
          ],
        );
      case StateRendererType.fullScreenEmptyState:
        return getItemsColumn(
          [
            getAnimatedImage(JsonAssets.empty),
            getMsg(msg),
          ],
        );
      case StateRendererType.contentState:
        return Container();
      default:
        return Container();
    }
  }

  Widget getPopUpDilalog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
            ),
          ],
        ),
        child: getdialogcontent(context, children),
      ),
    );
  }

  Widget getdialogcontent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget getItemsColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget getAnimatedImage(String animationname) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationname),
    );
  }

  Widget getMsg(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          message,
          style: getRegularStyle(
            color: ColorManager.black,
            fontsize: FontSize.s18,
          ),
        ),
      ),
    );
  }

  Widget getRetryButton(String buttontitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (stateRendererType == StateRendererType.fullScreenErrorState) {
                //call retry Function
                retryactionFunction.call();
              } else {
                // popup error state
                Navigator.of(context).pop();
              }
            },
            child: Text(buttontitle),
          ),
        ),
      ),
    );
  }
}
