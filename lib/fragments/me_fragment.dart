import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';

class MeFragment extends StatelessWidget {
  const MeFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ME_BACKGROUND_COLOR,
      body: Stack(
        children: const [
          BodySectionView(),
          Positioned(
            top: 130,
            left: 130,
            child: ProfileImageView(),
          ),
          LogoutSectionView(),
        ],
      ),
    );
  }
}

class LogoutSectionView extends StatelessWidget {
  const LogoutSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        height: 40,
        width: 160,
        decoration: BoxDecoration(
          color: BACKGROUND_WHITE_COLOR,
          borderRadius: BorderRadius.circular(
            18.0,
          ),
          border: Border.all(
            color: DIVIDER_COLOR,
          ),
        ),
        child: Center(
          child: Text(
            "Log Out",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: LOGOUT_TEXT_COLOR,
                fontSize: MARGIN_MEDIUM_2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileImageView extends StatelessWidget {
  const ProfileImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: PROFILE_IMAGE_BORDER_SIZE,
      backgroundColor: PROFILE_BORDER_COLOR,
      child: CircleAvatar(
        backgroundImage: NetworkImage(
          "https://i.pinimg.com/originals/e2/01/68/e20168a4340f439462017456d2e0b8d2.jpg",
        ),
        radius: PROFILE_IMAGE_SIZE,
      ),
    );
  }
}

class BodySectionView extends StatelessWidget {
  const BodySectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        HeaderSectionView(),
        BioSectionView(),
        SizedBox(
          height: MARGIN_SMALL,
        ),
        IconsListSectionView(),
        Divider(
          height: 3.0,
          thickness: 5.0,
        ),
      ],
    );
  }
}

class IconsListSectionView extends StatelessWidget {
  const IconsListSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: const [
            IconAndTitleItem(
              icon: Icons.photo_outlined,
              title: "Photos",
            ),
            IconAndTitleItem(
              icon: Icons.favorite_outline,
              title: "Favorites",
            ),
            IconAndTitleItem(
              icon: Icons.account_balance_wallet_outlined,
              title: "Wallet",
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: const [
            IconAndTitleItem(
              icon: Icons.credit_card_outlined,
              title: "Cards",
            ),
            IconAndTitleItem(
              icon: Icons.tag_faces_outlined,
              title: "Stickers",
            ),
            IconAndTitleItem(
              icon: Icons.settings,
              title: "Settings",
            ),
          ],
        ),
      ],
    );
  }
}

class BioSectionView extends StatelessWidget {
  const BioSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(244, 244, 244, 1),
      padding: const EdgeInsets.symmetric(
        horizontal: MARGIN_LARGE,
      ),
      height: 145,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 100.0,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text:
                  "The worst of all possible universe and the best of all possible earths. ",
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: TEXT_COLOR_BOLD,
                  fontSize: TEXT_SMALL,
                ),
              ),
              children: [
                TextSpan(
                  text: "EDIT",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: MILD_BLUE,
                      fontSize: TEXT_REGULAR,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderSectionView extends StatelessWidget {
  const HeaderSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [PRIMARY_GRADIENT_COLOR, PRIMARY_COLOR],
        ),
      ),
      child: Row(
        children: const [
          SizedBox(),
          Spacer(),
          Spacer(),
          NameAndIDView(),
          Spacer(),
          QRcode_View(),
        ],
      ),
    );
  }
}

class QRcode_View extends StatelessWidget {
  const QRcode_View({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.qr_code,
            color: BACKGROUND_COLOR,
            size: 20.0,
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            color: BACKGROUND_COLOR,
            size: 20.0,
          ),
        ],
      ),
    );
  }
}

class NameAndIDView extends StatelessWidget {
  const NameAndIDView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Amie Deane",
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_3X,
          )),
        ),
        Text(
          "Alberto203",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: BACKGROUND_COLOR,
              fontSize: TEXT_SMALL,
            ),
          ),
        ),
      ],
    );
  }
}

class IconAndTitleItem extends StatelessWidget {
  final IconData icon;
  final String title;
  const IconAndTitleItem({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: BACKGROUND_WHITE_COLOR,
          border: Border.all(color: ICON_COLOR, width: 0.1),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              title == "Wallet"
                  ? Badge(
                      position: BadgePosition.topStart(),
                      toAnimate: false,
                      badgeColor: VIVID_RED,
                      badgeContent: const Text(
                        "2",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                      elevation: 0.0,
                      child: Icon(
                        icon,
                        color: ICON_COLOR,
                        size: 35,
                      ),
                    )
                  : Icon(
                      icon,
                      color: ICON_COLOR,
                      size: 35.0,
                    ),
              const SizedBox(
                height: MARGIN_MEDIUM,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: TEXT_COLOR_BOLD,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
