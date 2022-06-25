import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wechat_redesign/data/models/data_model.dart';
import 'package:wechat_redesign/data/models/data_model_impl.dart';
import 'package:wechat_redesign/fcm/fcm_service.dart';
import 'package:wechat_redesign/pages/chatting/chat_history_page.dart';

import 'pages/auth/start_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FCMService().listenForMessages();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final DataModel _model = DataModelImpl();
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: _model.isLoggedIn() ? const ChatHistoryPage() : const StartPage(),
    );
  }
}

/// fvm flutter packages run build_runner build --delete-conflicting-outputs
// import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
//
// void main() => runApp(MainApp());
//
// String getRandomName() {
//   final List<String> preFix = ['Aa', 'bo', 'Ce', 'Do', 'Ha', 'Tu', 'Zu'];
//   final List<String> surFix = ['sad', 'bad', 'lad', 'nad', 'kat', 'pat', 'my'];
//   preFix.shuffle();
//   surFix.shuffle();
//   return '${preFix.first}${surFix.first}';
// }
//
// class User {
//   final String name;
//   final String company;
//   final bool favourite;
//
//   User(this.name, this.company, this.favourite);
// }
//
// class MainApp extends StatefulWidget {
//   @override
//   _MainAppState createState() => _MainAppState();
// }
//
// class _MainAppState extends State<MainApp> {
//   List<User> userList = [];
//   List<String> strList = [];
//   List<Widget> favouriteList = [];
//   List<Widget> normalList = [];
//   TextEditingController searchController = TextEditingController();
//
//   @override
//   void initState() {
//     for (var i = 0; i < 26; i++) {
//       userList.add(User(getRandomName(), getRandomName(), false));
//     }
//     for (var i = 0; i < 4; i++) {
//       userList.add(User(getRandomName(), getRandomName(), true));
//     }
//     userList
//         .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
//     filterList();
//     searchController.addListener(() {
//       filterList();
//     });
//     super.initState();
//   }
//
//   filterList() {
//     List<User> users = [];
//     users.addAll(userList);
//     favouriteList = [];
//     normalList = [];
//     strList = [];
//     if (searchController.text.isNotEmpty) {
//       users.retainWhere((user) => user.name
//           .toLowerCase()
//           .contains(searchController.text.toLowerCase()));
//     }
//     users.forEach((user) {
//       if (user.favourite) {
//         favouriteList.add(
//           ListTile(
//             leading: Stack(
//               children: <Widget>[
//                 CircleAvatar(
//                   backgroundImage:
//                   NetworkImage("https://placeimg.com/200/200/people"),
//                 ),
//                 Container(
//                     height: 40,
//                     width: 40,
//                     child: Center(
//                       child: Icon(
//                         Icons.star,
//                         color: Colors.yellow[100],
//                       ),
//                     ))
//               ],
//             ),
//             title: Text(user.name),
//             subtitle: Text(user.company),
//           ),
//         );
//       } else {
//         normalList.add(
//           ListTile(
//             leading: CircleAvatar(
//               backgroundImage:
//               NetworkImage("https://placeimg.com/200/200/people"),
//             ),
//             title: Text(user.name),
//             subtitle: Text(user.company),
//           ),
//         );
//         strList.add(user.name);
//       }
//     });
//
//     setState(() {});
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//           appBar: AppBar(
//             title: const Text('Plugin example app'),
//           ),
//           body: AlphabetListScrollView(
//             strList: strList,
//             highlightTextStyle: TextStyle(
//               color: Colors.yellow,
//             ),
//             showPreview: true,
//             itemBuilder: (context, index) {
//               return normalList[index];
//             },
//             indexedHeight: (i) {
//               return 80;
//             },
//             keyboardUsage: true,
//
//           ),
//         ));
//   }
// }