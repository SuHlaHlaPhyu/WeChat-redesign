import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign/blocs/verify_email_bloc.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';
import 'package:wechat_redesign/pages/chatting/chat_history_page.dart';
import 'package:wechat_redesign/resources/colors.dart';

import '../../resources/dimens.dart';

class EmailVerifyPage extends StatelessWidget {
  final UserVO? userVO;
  final File? imageFile;
  const EmailVerifyPage(
      {Key? key, required this.userVO, required this.imageFile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VerifyEmailBloc(userVO, imageFile),
      child: Selector<VerifyEmailBloc, bool>(
        selector: (context, bloc) => bloc.isLoading,
        builder: (context, isLoading, child) => Scaffold(
          backgroundColor: AUTH_BACKGROUND_COLOR,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: AUTH_BACKGROUND_COLOR,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close,
                color: CROSS_ICON_COLOR,
              ),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.more_horiz_outlined,
                  color: CROSS_ICON_COLOR,
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              const EmailVerifyView(),
              Consumer<VerifyEmailBloc>(
                builder: (context, bloc, child) => Align(
                  alignment: Alignment.bottomCenter,
                  child: OkButtonView(
                    onTap: () {
                      bloc
                          .onTapRegister()
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

class OkButtonView extends StatelessWidget {
  final Function onTap;
  const OkButtonView({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //
        onTap();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            height: 45.0,
            width: 200.0,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(43, 43, 43, 1),
              borderRadius: BorderRadius.circular(
                8.0,
              ),
            ),
            child: Center(
              child: Text(
                "OK",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: SUBTEXT_COLOR,
                    fontSize: MARGIN_MEDIUM_2,
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

class EmailVerifyView extends StatelessWidget {
  const EmailVerifyView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<VerifyEmailBloc>(
      builder: (context, bloc, child) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Email Verification",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAR_2XX,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 15.0,
              left: 25.0,
              top: 40.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter email verification",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: SUBTEXT_COLOR,
                    ),
                  ),
                ),
                const SizedBox(
                  height: MARGIN_MEDIUM,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Email",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 270.0,
                      child: TextField(
                        //controller: TextEditingController(text: ""),
                        onChanged: (text) {
                          //
                          bloc.onEmailChanged(text);
                        },
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: const InputDecoration(
                          hintText: "Enter email address",
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
          )
        ],
      ),
    );
  }
}
