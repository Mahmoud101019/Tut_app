import 'package:flutter/material.dart';
import 'package:tut_app/app/constans.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/resourses/strings_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

//Loading State (POPUP , FULL SCREEN)

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String? message;
  LoadingState({
    required this.stateRendererType,
    String message = AppStrings.loading,
  });
  @override
  String getMessage() => message ?? AppStrings.loading;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

//Error State (POPUP , FULL SCREEN)

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState({
    required this.stateRendererType,
    required this.message,
  });
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

//Content State (POPUP , FULL SCREEN)

class ContentState extends FlowState {
  ContentState();
  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

//EMPTY State (POPUP , FULL SCREEN)

class EmptyState extends FlowState {
  String message;

  EmptyState({required this.message});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;
}
//Success State (POPUP , FULL SCREEN)

class SuccessState extends FlowState {
  String message;
  SuccessState({required this.message});
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.popupSuccess;
}

extension FlowStateextension on FlowState {
  Widget getScreenWidget(
    BuildContext context,
    Widget contentScreenWidget,
    Function retryactionFunction,
  ) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.popupLoadingState) {
            //Show Popup Loading
            showPopupDialog(context, getStateRendererType(), getMessage());
            //Show Content Ui of Tha Screen
            return contentScreenWidget;
          } else {
            //Full Screen Loading State
            return StateRenderer(
              retryactionFunction: retryactionFunction,
              stateRendererType: getStateRendererType(),
              msg: getMessage(),
            );
          }
        }
      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.popupErrorState) {
            //Show Popup Error
            showPopupDialog(context, getStateRendererType(), getMessage());
            //Show Content Ui of Tha Screen
            return contentScreenWidget;
          } else {
            //Full Screen Loading State
            return StateRenderer(
              retryactionFunction: retryactionFunction,
              stateRendererType: getStateRendererType(),
              msg: getMessage(),
            );
          }
        }
      case EmptyState:
        {
          return StateRenderer(
            retryactionFunction: () {},
            stateRendererType: getStateRendererType(),
            msg: getMessage(),
          );
        }
      case ContentState:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
      case SuccessState:
        {
          dismissDialog(context);
          showPopupDialog(
            context,
            StateRendererType.popupSuccess,
            getMessage(),
            title: AppStrings.success,
          );
          return contentScreenWidget;
        }
      default:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
    }
  }

  isCurrnetDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  dismissDialog(BuildContext context) {
    if (isCurrnetDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  showPopupDialog(
      BuildContext context, StateRendererType stateRendererType, String message,
      {String title = Constants.empty}) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
            msg: message,
            retryactionFunction: () {},
            stateRendererType: stateRendererType),
      ),
    );
  }
}
