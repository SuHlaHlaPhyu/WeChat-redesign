import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';

import 'user_profile_view.dart';

class UserProfileAndNameSectionView extends StatelessWidget {
  final bool isMe;
  final String name;
  final String profile;
  const UserProfileAndNameSectionView(
      {Key? key, this.isMe = false, required this.name, required this.profile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.center : CrossAxisAlignment.end,
      children: [
        UserProfileView(
          image: profile,
        ),
        const SizedBox(
          width: 8.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                color: Colors.black,
                fontSize: TEXT_REGULAR_2X,
                fontWeight: FontWeight.bold,
              )),
            ),
            Visibility(
              visible: isMe,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    height: 25.0,
                    width: 90.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: DIVIDER_COLOR),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 3.0,
                        ),
                        const Icon(
                          Icons.people,
                          color: ICON_COLOR,
                          size: 15.0,
                        ),
                        const SizedBox(
                          width: 3.0,
                        ),
                        Text("Friends",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0))),
                        const SizedBox(
                          width: 3.0,
                        ),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: ICON_COLOR,
                          size: 17.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
