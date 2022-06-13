

import 'package:wechat_redesign/dummy/message.dart';
import 'package:wechat_redesign/dummy/user.dart';

final User currentUser = User(
  id: 0,
  name: 'Current User',
  imageUrl: 'assets/images/greg.jpg',
);

final User amie = User(
  id: 4,
  name: 'Amie Deane',
  imageUrl: 'assets/images/olivia.jpg',
);

List<Message> messages = [
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: 'Are you near the local station ?',
  ),
  Message(
    sender: amie,
    time: '2:30 PM',
    text: 'I love that too. But where can I find you right now ?',
  ),
  Message(
    sender: amie,
    time: '5:30 PM',
    text: 'It was really great!',
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: 'Walking in the rain. Eating chicken fired! And how about u ?',
  ),
  Message(
    sender: amie,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
  ),
  Message(
    sender: currentUser,
    time: '4:30 PM',
    text: 'Just walked my doge. She was super duper cute. The best pupper!!',

  ),
  Message(
    sender: amie,
    time: '3:45 PM',
    text: 'How\'s the doggo?',
  ),
  Message(
    sender: amie,
    time: '3:15 PM',
    text: 'All the food',
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: 'Nice! What kind of food did you eat?',
  ),
  Message(
    sender: amie,
    time: '2:00 PM',
    text: 'I ate so much food today.',
  ),
];