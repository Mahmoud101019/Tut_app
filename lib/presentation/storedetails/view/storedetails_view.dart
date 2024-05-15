import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/domain/model/models.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:tut_app/presentation/resourses/color_manager.dart';
import 'package:tut_app/presentation/resourses/strings_manager.dart';
import 'package:tut_app/presentation/resourses/values_manager.dart';
import 'package:tut_app/presentation/storedetails/view_model/store_details_view_model.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({super.key});

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final StoreDetailsViewModel viewModel = instance<StoreDetailsViewModel>();

  @override
  void initState() {
    bind();
    super.initState();
  }

  bind() {
    viewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<FlowState>(
      stream: viewModel.outPutState,
      builder: (context, snapshot) {
        return Container(
          child:
              snapshot.data?.getScreenWidget(context, getContentWidget(), () {
                    viewModel.start();
                  }) ??
                  Container(),
        );
      },
    ));
  }

  Widget getContentWidget() {
    return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          title: Text(AppStrings.storeDetails.tr()),
          elevation: AppSize.s0,
          iconTheme: IconThemeData(
            //back button
            color: ColorManager.white,
          ),
          backgroundColor: ColorManager.primary,
          centerTitle: true,
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          color: ColorManager.white,
          child: SingleChildScrollView(
            child: StreamBuilder<StoreDetails>(
              stream: viewModel.outputStoreDetails,
              builder: (context, snapshot) {
                return getItems(snapshot.data);
              },
            ),
          ),
        ));
  }

  Widget getItems(StoreDetails? storeDetails) {
    if (storeDetails != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Image.network(
            storeDetails.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 250,
          )),
          getSection(AppStrings.details.tr()),
          getInfoText(storeDetails.details),
          getSection(AppStrings.services.tr()),
          getInfoText(storeDetails.services),
          getSection(AppStrings.about.tr()),
          getInfoText(storeDetails.about)
        ],
      );
    } else {
      return Container();
    }
  }

  Widget getSection(String title) {
    return Padding(
        padding: const EdgeInsets.only(
            top: AppPadding.p12,
            left: AppPadding.p12,
            right: AppPadding.p12,
            bottom: AppPadding.p2),
        child: Text(title, style: Theme.of(context).textTheme.titleMedium));
  }

  Widget getInfoText(String info) {
    return Padding(
      padding: const EdgeInsets.all(AppSize.s12),
      child: Text(info, style: Theme.of(context).textTheme.bodySmall),
    );
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }
}
