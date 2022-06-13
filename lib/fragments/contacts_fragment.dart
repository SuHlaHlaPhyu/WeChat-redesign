import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';

import '../viewitems/profile_image_view.dart';

class ContactsFragment extends StatelessWidget {
  const ContactsFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_WHITE_COLOR,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Contacts",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: APP_TITLE_COLOR,
              fontSize: TEXT_REGULAR_2XX,
            ),
          ),
        ),
        backgroundColor: PRIMARY_COLOR,
        actions: const [
          Padding(
            padding: EdgeInsets.only(
              right: 10.0,
            ),
            child: Icon(
              Icons.person_add_alt,
              size: 28.0,
              color: ADD_ICON_COLOR,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            SearchSectionView(),
            Divider(
              thickness: 1,
              color: BACKGROUND_COLOR,
            ),
            CategorySectionView(),
            DividerSectionView(),
            ContactsListSectionView(),
          ],
        ),
      ),
    );
  }
}

class ContactsListSectionView extends StatefulWidget {
  const ContactsListSectionView({
    Key? key,
  }) : super(key: key);

  @override
  State<ContactsListSectionView> createState() => _ContactsListSectionViewState();
}

class _ContactsListSectionViewState extends State<ContactsListSectionView> {

  TextEditingController searchController = TextEditingController();
  List<String> strList = ["#","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];
  List<Widget> favouriteList = [];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const ContactItem();
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: 7,
    );
  }
}

class ContactItem extends StatelessWidget {
  const ContactItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: MARGIN_CARD_MEDIUM_2, vertical: 2.0),
      child: Row(
        children: const [
          ProfileImageView(),
          SizedBox(
            width: MARGIN_SMALL_2,
          ),
          ContactNameView(),
        ],
      ),
    );
  }
}

class ContactNameView extends StatelessWidget {
  const ContactNameView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Any Diamond",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
                color: TEXT_COLOR_BOLD,
                fontWeight: FontWeight.bold,
                fontSize: TEXT_REGULAR_2X),
          ),
        ),
        Text(
          "Fair Isaac Corporation",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: SUBTEXT_COLOR,
              fontSize: TEXT_SMALL,
            ),
          ),
        ),
      ],
    );
  }
}

class DividerSectionView extends StatelessWidget {
  const DividerSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BACKGROUND_COLOR,
      child: Column(
        children: [
          const Divider(
            height: 3.0,
            thickness: 5.0,
          ),
          Container(
            height: MARGIN_XXLARGE,
            padding: const EdgeInsets.fromLTRB(80, 17, 15, 3),
            child: Row(
              children: [
                Text(
                  "A",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: SUBTEXT_COLOR,
                        fontSize: TEXT_REGULAR_3X,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                Text(
                  "15 FRIENDS",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: ICON_COLOR,
                      fontSize: TEXT_SMALL,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 2.0,
          ),
        ],
      ),
    );
  }
}

class CategorySectionView extends StatelessWidget {
  const CategorySectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,
      height: ICON_CATEGORY_HIEGHT,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          IconAndTitleView(
            icon: Icons.person_add_alt,
            title: "New\nFriends",
          ),
          DividerView(),
          IconAndTitleView(
            icon: Icons.group_outlined,
            title: "Group\nChats",
          ),
          DividerView(),
          IconAndTitleView(
            icon: Icons.local_offer_outlined,
            title: "Tags",
          ),
          DividerView(),
          IconAndTitleView(
            icon: Icons.tap_and_play_outlined,
            title: "Official\nAccounts",
          ),
        ],
      ),
    );
  }
}

class IconAndTitleView extends StatelessWidget {
  final IconData? icon;
  final String title;
  const IconAndTitleView({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        title == "New\nFriends"
            ? Badge(
                toAnimate: false,
                badgeColor: VIVID_RED,
                badgeContent: const Text(
                  "1",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
                elevation: 0.0,
                child: Icon(
                  icon,
                  color: ICON_COLOR,
                  size: 25,
                ),
              )
            : Icon(
                icon,
                color: ICON_COLOR,
                size: 25,
              ),
        const SizedBox(
          height: MARGIN_SMALL,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: SUBTEXT_COLOR,
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    );
  }
}

class DividerView extends StatelessWidget {
  const DividerView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ICON_DIVIDER_HIEGHT,
      width: 1.0,
      color: DIVIDER_COLOR,
    );
  }
}

class SearchSectionView extends StatelessWidget {
  const SearchSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: MARGIN_MEDIUM,
        right: MARGIN_MEDIUM,
        top: MARGIN_MEDIUM,
      ),
      height: MARGIN_LARGE_2,
      decoration: const BoxDecoration(
        color: SEARCH_BACKGROUND_COLOR,
        borderRadius: BorderRadius.all(
          Radius.circular(
            5,
          ),
        ),
      ),
      width: double.infinity,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.search,
              color: ICON_COLOR,
              size: 20.0,
            ),
            Text(
              "Search",
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: SUBTEXT_COLOR,
                  fontSize: TEXT_REGULAR,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}