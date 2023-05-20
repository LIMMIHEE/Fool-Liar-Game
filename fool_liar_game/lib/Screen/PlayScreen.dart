import 'package:flutter/material.dart';

class PlayScreen extends StatefulWidget {
  final String type;
  final int playerCount;

  PlayScreen({required this.type, required this.playerCount});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  bool isOpen = false;
  bool isGameDone = false;

  int nowPlayer = 0;
  int foolPlayerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("주제"),
            Text(widget.type),
            isOpen
                ? Text("주제는 ${nowPlayer == foolPlayerIndex ? 1 : 0} 입니다!")
                : GestureDetector(
                    onSecondaryLongPress: () {},
                    child: Container(
                      child: Text("화면을 눌러주세요."),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
