import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';

import 'privacy_policy_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AUTH_BACKGROUND_COLOR,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child:const Padding(
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
          Align(
            alignment: Alignment.bottomCenter,
            child: ContinueButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyPage(),
                  ),
                );
              },
            ),
          ),
        ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.circle_outlined, color: SUBTEXT_COLOR),
            //Icon(Icons.check_circle),
            SizedBox(
              width: 5.0,
            ),
            Text(
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
            //
            onTap();
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            height: 45.0,
            width: 220.0,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(43, 43, 43, 1),
              borderRadius: BorderRadius.circular(
                8.0,
              ),
            ),
            child: Center(
              child: Text(
                "Accept and Continue",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: SUBTEXT_COLOR,
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
    return Padding(
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
                  controller: TextEditingController(text: ""),
                  onChanged: (text) {
                    //
                  },
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
                child: TextField(
                  controller: TextEditingController(text: ""),
                  onChanged: (text) {
                    //
                  },
                  decoration: const InputDecoration(
                    hintText: "What's your region?",
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
                  controller: TextEditingController(text: ""),
                  onChanged: (text) {
                    //
                  },
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
                  controller: TextEditingController(text: ""),
                  onChanged: (text) {
                    //
                  },
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
    );
  }
}

class ProfileChooseView extends StatelessWidget {
  const ProfileChooseView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Container(
          padding: const EdgeInsets.all(20.0),
          color: CAMERA_BACKGROUND_COLOR,
          child: const Icon(
            Icons.camera_alt,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
