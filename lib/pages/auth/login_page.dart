import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign/blocs/login_bloc.dart';
import 'package:wechat_redesign/pages/chatting/chat_history_page.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginBloc(),
      child: Selector<LoginBloc, bool>(
        selector: (context, bloc) => bloc.isLoading,
        builder: (context, isLoading, child) => Scaffold(
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
              Consumer<LoginBloc>(
                builder: (context, bloc, child) => Align(
                  alignment: Alignment.bottomCenter,
                  child: ContinueButton(
                    onTap: () {
                      bloc
                          .onTapLogin()
                          .then((value) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ChatHistoryPage(),
                                ),
                              ))
                          .catchError(
                            (error) =>
                                ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  error.toString(),
                                ),
                              ),
                            ),
                          );
                    },
                  ),
                ),
              ),
              Visibility(
                visible: isLoading,
                child: Container(
                  color: Colors.black12,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            ],
          ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "The information collected on this page is only used for account login.",
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
                "Accept and Login",
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
      children: [
        Text(
          "Login with Email",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_2XX,
            ),
          ),
        ),
        const SizedBox(
          height: MARGIN_LARGE_2,
        ),
        const TextFieldView()
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
    return Consumer<LoginBloc>(
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
                  "Account",
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
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    onChanged: (text) {
                      bloc.onEmailChanged(text);
                    },
                    decoration: const InputDecoration(
                      hintText: "Enter your email",
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
