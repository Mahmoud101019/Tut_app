import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/app/constans.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:tut_app/presentation/resourses/app_assets_manager.dart';
import 'package:tut_app/presentation/resourses/color_manager.dart';
import 'package:tut_app/presentation/resourses/routes_manager.dart';
import 'package:tut_app/presentation/resourses/strings_manager.dart';
import 'package:tut_app/presentation/resourses/values_manager.dart';
import 'package:tut_app/presentation/signup/view_model/signup_view_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final SignUpViewModel viewmodel = instance<SignUpViewModel>();
  final ImagePicker imagePicker = instance<ImagePicker>();
  final AppPreferences appPreferences = instance<AppPreferences>();
  final formkey2 = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bind() {
    viewmodel.start();
    userNameController.addListener(() {
      viewmodel.setUserName(userNameController.text.trim());
    });
    mobileNumberController.addListener(() {
      viewmodel.setMobileNumber(mobileNumberController.text.trim());
    });
    emailController.addListener(() {
      viewmodel.setEmail(emailController.text.trim());
    });
    passwordController.addListener(() {
      viewmodel.setPassword(passwordController.text.trim());
    });
    viewmodel.isUserSignupSuccessfullyStreamController.stream
        .listen((isLoggedIn) {
      if (isLoggedIn) {
        //navigator to main screen
        SchedulerBinding.instance.addPostFrameCallback((_) {
          appPreferences.setUserLoggedIn();
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });
      }
    });
  }

  @override
  void initState() {
    bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: AppSize.s0,
          iconTheme: IconThemeData(
            color: ColorManager.primary,
          ),
        ),
        body: StreamBuilder<FlowState>(
          stream: viewmodel.outPutState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, getContentWidget(),
                    () {
                  viewmodel.signUp();
                }) ??
                getContentWidget();
          },
        ),
      ),
    );
  }

  Widget getContentWidget() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p20),
      child: SingleChildScrollView(
        child: Form(
          key: formkey2,
          child: Column(
            children: [
              const Center(
                child: Image(
                  image: AssetImage(AppAssets.signUplogo),
                ),
              ),

              const SizedBox(
                height: AppSize.s28,
              ),

////////////////////////////TextFormField UserName////////////////////////////////////////

              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p14, right: AppPadding.p14),
                child: StreamBuilder<String?>(
                  stream: viewmodel.outPutErrorUserName,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.name,
                      controller: userNameController,
                      decoration: InputDecoration(
                        hintText: AppStrings.hintusernameSignUp,
                        labelText: AppStrings.hintusernameSignUp,
                        errorText: snapshot.data,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),

////////////////////////////TextFormField MobileNumber////////////////////////////////////////

              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p14, right: AppPadding.p14),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CountryCodePicker(
                          onChanged: (country) {
                            //update view model country code
                            viewmodel.setCountryCode(
                              country.dialCode ?? Constants.token,
                            );
                          },
                          initialSelection: '+20',
                          favorite: const ['+39', 'FR', '+966'],
                          // optional. Shows only country name and flag
                          showCountryOnly: true,
                          hideMainText: true,
                          // optional. Shows only country name and flag when popup is closed.
                          showOnlyCountryWhenClosed: true,
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: AppPadding.p14, right: AppPadding.p14),
                          child: StreamBuilder<String?>(
                            stream: viewmodel.outPutErrorMobileNumber,
                            builder: (context, snapshot) {
                              return TextFormField(
                                keyboardType: TextInputType.phone,
                                controller: mobileNumberController,
                                decoration: InputDecoration(
                                  hintText: AppStrings.hintMobileNumberSignUp,
                                  labelText: AppStrings.hintMobileNumberSignUp,
                                  errorText: snapshot.data,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: AppSize.s28,
              ),

////////////////////////////TextFormField Email////////////////////////////////////////

              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p14, right: AppPadding.p14),
                child: StreamBuilder<String?>(
                  stream: viewmodel.outPutErrorEmail,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: AppStrings.hintEmailSignUp,
                        labelText: AppStrings.hintEmailSignUp,
                        errorText: snapshot.data,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),

////////////////////////////TextFormField Password////////////////////////////////////////

              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p14, right: AppPadding.p14),
                child: StreamBuilder<String?>(
                  stream: viewmodel.outPutErrorPassword,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: AppStrings.hintPasswordSignUp,
                        labelText: AppStrings.hintPasswordSignUp,
                        errorText: snapshot.data,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),

////////////////////////////Image Profle picture////////////////////////////////////////

              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p14, right: AppPadding.p14),
                child: Container(
                  height: AppSize.s50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(AppSize.s8),
                    ),
                    border: Border.all(
                      color: ColorManager.darkgrey,
                    ),
                  ),
                  child: GestureDetector(
                    child: getMediaWidget(),
                    onTap: () {
                      showPicker(context);
                    },
                  ),
                ),
              ),

////////////////////////////SignUp Button////////////////////////////////////////

              const SizedBox(
                height: AppSize.s40,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: viewmodel.outPutsAreAllInputsValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s60,
                      child: ElevatedButton(
                        onPressed: (snapshot.data ?? false)
                            ? () {
                                viewmodel.signUp();
                              }
                            : null,
                        child: const Text(AppStrings.signUp),
                      ),
                    );
                  },
                ),
              ),

////////////////////////////Text Button////////////////////////////////////////

              Padding(
                padding: const EdgeInsets.only(
                  top: AppPadding.p8,
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    AppStrings.alreadyhaveanaccount,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getMediaWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p8, right: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(
            child: Text(AppStrings.hintProflepictureSignUp),
          ),
          Flexible(
            child: StreamBuilder<File>(
              stream: viewmodel.outPutIsProfilePictureValid,
              builder: (context, snapshot) {
                return imagepickedbyuser(snapshot.data);
              },
            ),
          ),
          Flexible(
            child: SvgPicture.asset(AppAssets.photoCamera),
          ),
        ],
      ),
    );
  }

  Widget imagepickedbyuser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      //return image
      return Image.file(image);
    } else {
      //return empty Container
      return Container();
    }
  }

  showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
            child: Wrap(
          children: [
            ListTile(
              trailing: const Icon(Icons.arrow_forward),
              leading: const Icon(Icons.camera),
              title: const Text(AppStrings.photogallery),
              onTap: () {
                imageformgallery();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              trailing: const Icon(Icons.arrow_forward),
              leading: const Icon(Icons.camera_alt),
              title: const Text(AppStrings.photocamera),
              onTap: () {
                imageformCamera();
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
      },
    );
  }

  imageformgallery() async {
    var image = await imagePicker.pickImage(source: ImageSource.gallery);
    viewmodel.setProfilePicture(File(image?.path ?? Constants.empty));
  }

  imageformCamera() async {
    var image = await imagePicker.pickImage(source: ImageSource.camera);
    viewmodel.setProfilePicture(File(image?.path ?? Constants.empty));
  }

  @override
  void dispose() {
    viewmodel.dispose();
    super.dispose();
  }
}
