import 'dart:io';
import 'dart:typed_data';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign/blocs/sign_up_bloc.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';

import 'privacy_policy_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AUTH_BACKGROUND_COLOR,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.only(
                    left: 8.0,
                    top: kToolbarHeight,
                  ),
                  child: Icon(
                    Icons.close,
                    color: CROSS_ICON_COLOR,
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 130.0,
              right: 12.0,
              left: 12.0,
              child: InputSectionView(),
            ),
            Consumer<SignUpBloc>(
              builder: (context, bloc, child) => Align(
                alignment: Alignment.bottomCenter,
                child: ContinueButton(
                  onTap: () {
                    bloc.getUserInfo().then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrivacyPolicyPage(
                            userVO: value,
                            imageFile: bloc.chosenImage,
                          ),
                        ),
                      );
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContinueButton extends StatelessWidget {
  final Function onTap;
  const ContinueButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpBloc>(
      builder: (context, bloc, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  bloc.onTapAccepted();
                },
                child: Icon(
                  bloc.isAccepted ? Icons.check_circle : Icons.circle_outlined,
                  color: bloc.isAccepted ? SIGN_UP_COLOR : SUBTEXT_COLOR,
                ),
              ),
              const SizedBox(
                width: 5.0,
              ),
              const Text(
                "I have read and accept the Terms of Service. ",
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                style: TextStyle(color: SUBTEXT_COLOR),
              ),
              //
            ],
          ),
          const Text(
            "The information collected on this page is only used for account registration.",
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
            style: TextStyle(color: SUBTEXT_COLOR),
          ),
          const SizedBox(
            height: MARGIN_LARGE,
          ),
          GestureDetector(
            onTap: () {
              if (bloc.isAccepted) {
                onTap();
              } else {
                //
              }
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              height: 45.0,
              width: 220.0,
              decoration: BoxDecoration(
                color: bloc.isAccepted ? SIGN_UP_COLOR : DISABLE_COLOR,
                borderRadius: BorderRadius.circular(
                  8.0,
                ),
              ),
              child: Center(
                child: Text(
                  "Accept and Continue",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: bloc.isAccepted
                          ? BACKGROUND_WHITE_COLOR
                          : SUBTEXT_COLOR,
                      fontSize: MARGIN_MEDIUM_2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: kToolbarHeight,
          ),
        ],
      ),
    );
  }
}

class InputSectionView extends StatelessWidget {
  const InputSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        ProfileChooseView(),
        SizedBox(
          height: MARGIN_LARGE_2,
        ),
        TextFieldView()
      ],
    );
  }
}

class TextFieldView extends StatelessWidget {
  const TextFieldView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpBloc>(
      builder: (context, bloc, child) => Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Name",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 250.0,
                  child: TextField(
                    // controller: TextEditingController(text: bloc.userName),
                    onChanged: (text) {
                      //
                      bloc.onUserNameChanged(text);
                    },
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      hintText: "John Appleseed",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: SUBTEXT_COLOR,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Region",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 250.0,
                  child: CountryCodePicker(
                    onChanged: (code){
                      bloc.selectRegion(code.name.toString());
                    },
                    initialSelection: 'IT',
                    favorite: ['+39','FR'],
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    alignLeft: true,
                    textStyle:const TextStyle(
                      color: Colors.white
                    ),
                    // dialogBackgroundColor: AUTH_BACKGROUND_COLOR,
                    // dialogTextStyle: const TextStyle(
                    //     color: Colors.white
                    // ),
                  ),
                  // TextField(
                  //   // controller: TextEditingController(text: bloc.region),
                  //   onChanged: (text) {
                  //     //
                  //     bloc.selectRegion(text);
                  //   },
                  //   style: const TextStyle(
                  //     color: Colors.white,
                  //   ),
                  //   decoration: const InputDecoration(
                  //     hintText: "What's your region?",
                  //     border: InputBorder.none,
                  //     hintStyle: TextStyle(
                  //       color: SUBTEXT_COLOR,
                  //     ),
                  //   ),
                  // ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Phone",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 250.0,
                  child: TextField(
                    // controller: TextEditingController(text: bloc.phone),
                    onChanged: (text) {
                      //
                      bloc.onPhoneChanged(text);
                    },
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      hintText: "Enter your phone number",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: SUBTEXT_COLOR,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Password",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 250.0,
                  child: TextField(
                    // controller: TextEditingController(text: bloc.password),
                    onChanged: (text) {
                      //
                      bloc.onPasswordChanged(text);
                    },
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      hintText: "Enter Password",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: SUBTEXT_COLOR,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileChooseView extends StatelessWidget {
  const ProfileChooseView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpBloc>(
      builder: (context, bloc, child) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Sign up by phone number",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAR_2XX,
              ),
            ),
          ),
          const SizedBox(
            height: MARGIN_LARGE,
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  backgroundColor: BOTTOM_SHEET_COLOR,
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 180.0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: MARGIN_MEDIUM,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              ImagePicker()
                                  .pickImage(source: ImageSource.camera)
                                  .then((value) async {
                                var bytes = await value?.readAsBytes();
                                bloc.onImageChosen(File(value?.path ?? ""),
                                    bytes ?? Uint8List(0));
                              }).catchError((error) {
                                print("error");
                              });
                            },
                            child: SizedBox(
                              height: 60.0,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  "Take a photo",
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      color: MOMENT_SUBTEXT_COLOR,
                                      fontSize: TEXT_REGULAR_2XX,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              ImagePicker()
                                  .pickImage(source: ImageSource.gallery)
                                  .then((value) async {
                                var bytes = await value?.readAsBytes();
                                bloc.onImageChosen(File(value?.path ?? ""),
                                    bytes ?? Uint8List(0));
                              }).catchError((error) {
                                print("error");
                              });
                            },
                            child: SizedBox(
                              height: 60.0,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  "Choose from Gallery",
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      color: MOMENT_SUBTEXT_COLOR,
                                      fontSize: TEXT_REGULAR_2XX,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: MARGIN_SMALL_2,
                            color: AUTH_BACKGROUND_COLOR,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SizedBox(
                              height: 30.0,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  "Cancel",
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      color: MOMENT_SUBTEXT_COLOR,
                                      fontSize: TEXT_REGULAR_2XX,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: (bloc.chosenImage == File("") || bloc.chosenImage == null)
                ? Container(
                    padding: const EdgeInsets.all(20.0),
                    color: CAMERA_BACKGROUND_COLOR,
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                  )
                : SizedBox(
                    height: 80.0,
                    width: 80.0,
                    child: Image.file(
                      bloc.chosenImage ?? File("path"),
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
