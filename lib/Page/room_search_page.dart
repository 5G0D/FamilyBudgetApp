import 'package:flutter/material.dart';

class RoomSearchPage extends StatefulWidget {
  const RoomSearchPage({Key? key}) : super(key: key);

  @override
  _RoomSearchPageState createState() => _RoomSearchPageState();
}

class _RoomSearchPageState extends State<RoomSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Поиск комнаты'
          ),
        ),
        backgroundColor: const Color(0xff5537a1),
      ),
    );
  }
}
