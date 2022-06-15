import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wechat_redesign/pages/auth/login_page.dart';
import 'package:wechat_redesign/pages/chatting/chat_history_page.dart';
import 'package:wechat_redesign/pages/auth/sign_up_page.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Image.asset(
            "assets/images/wechat.jpeg",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AuthButtonView(
              onLogin: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              onSignUp: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpPage(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class AuthButtonView extends StatelessWidget {
  final Function onSignUp;
  final Function onLogin;
  const AuthButtonView({
    Key? key,
    required this.onLogin,
    required this.onSignUp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: (){
                  onLogin();
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    color: SIGN_UP_COLOR,
                    borderRadius: BorderRadius.circular(
                      5.0,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Log In",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: MARGIN_MEDIUM_2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
             const Spacer(),
              GestureDetector(
                onTap: (){
                  onSignUp();
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    color: LOGIN_COLOR,
                    borderRadius: BorderRadius.circular(
                      5.0,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: MARGIN_MEDIUM_2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
