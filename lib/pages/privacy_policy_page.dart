import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wechat_redesign/pages/email_verify_page.dart';
import 'package:wechat_redesign/resources/colors.dart';

import '../resources/dimens.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AUTH_BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.close,
            color: CROSS_ICON_COLOR,
          ),
        ),
        title: Text(
          "Privacy Policy",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_2XX,
            ),
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
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: MARGIN_LARGE,
              ),
              Center(
                child: Text(
                  "WECHAT PRIVACY POLICY",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: TEXT_REGULAR_2XX,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: MARGIN_LARGE,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Last Updated : 20.2.2022",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: SUBTEXT_COLOR,
                          fontSize: TEXT_REGULAR,
                        ),
                      ),
                    ),
                    const SizedBox(height: MARGIN_MEDIUM,),
                    Text(
                      "The Service provided by the Owner allows Users to run a series of technological tools in a self-service manner, allowing them to generate legal documents based on Users' input for their online activities (eg. website, mobile app, etc.). As part of its Service, the Owner allows Users to generate, host and keep one or more document templates up to date online. Under no circumstance will iubenda's staff or any counsel assist Users in making the correct choice or in drafting the correct custom clauses .It is therefore the Users’ sole responsibility to pick the correct choices for their respective scenario or activity, to verify compatibility of the generated documents with applicable law and to ensure that their activity complies with all applicable legal provisions.In light of the above, the Service offered by iubenda cannot be regarded as, nor does it substitute any legal advice given by a professional or expert.",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: SUBTEXT_COLOR,
                          fontSize: TEXT_REGULAR,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: NextButtonView(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EmailVerifyPage(),
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

class NextButtonView extends StatelessWidget {
  final Function onTap;
  const NextButtonView({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
            width: 180.0,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(43, 43, 43, 1),
              borderRadius: BorderRadius.circular(
                8.0,
              ),
            ),
            child: Center(
              child: Text(
                "Next",
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
          height: MARGIN_LARGE_2,
        ),
      ],
    );
  }
}
