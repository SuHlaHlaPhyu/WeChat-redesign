import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:wechat_redesign/fragments/contacts_fragment.dart';
import 'package:wechat_redesign/fragments/discover_fragment.dart';
import 'package:wechat_redesign/fragments/me_fragment.dart';
import 'package:wechat_redesign/fragments/wechat_fragment.dart';
import 'package:wechat_redesign/resources/colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  List<BottomNavigationBarItem> buildBottomNavigationBarItems() {
    return [
      BottomNavigationBarItem(
        label: "Wechat",
        icon: Badge(
            padding: const EdgeInsets.all(4.0),
            toAnimate: false,
            badgeColor: VIVID_RED,
            elevation: 0.0,
            child: const Icon(
              Icons.chat_bubble_outline,
              key: ValueKey("home"),
            )),
      ),
      BottomNavigationBarItem(
        label: "Contacts",
        icon: Badge(
          toAnimate: false,
          badgeColor: VIVID_RED,
          padding: const EdgeInsets.all(4.0),
          elevation: 0.0,
          child: const Icon(
            Icons.contact_page_outlined,
            key: ValueKey("library"),
          ),
        ),
      ),
      const BottomNavigationBarItem(
        label: "Discover",
        icon: Icon(
          Icons.blur_circular_sharp,
          key: ValueKey("home"),
        ),
      ),
      const BottomNavigationBarItem(
        label: "Me",
        icon: Icon(
          Icons.person_outline,
          key: ValueKey("library"),
        ),
      ),
    ];
  }

  List<Widget> widgetOptions() {
    return const [
      WeChatFragment(),
      ContactsFragment(),
      DiscoverFragment(),
      MeFragment()
    ];
  }

  void _selectedTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions()[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: ICON_COLOR,
              width: 0.5,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: BOTTOM_NAVIGATION_COLOR,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: PRIMARY_COLOR,
          unselectedItemColor: ICON_COLOR,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: _selectedIndex,
          onTap: (index) {
            _selectedTab(index);
          },
          items: buildBottomNavigationBarItems(),
        ),
      ),
    );
  }
}
