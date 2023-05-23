import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fool_liar_game/Topic/Topic.dart';

class PlayScreen extends StatefulWidget {
  final String type;
  final int playerCount;
  final int foolCount;

  const PlayScreen(
      {super.key,
      required this.type,
      required this.playerCount,
      required this.foolCount});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  bool isOpen = false;
  bool isGameDone = false;
  bool keyWordOpen = false;

  int nowPlayer = 0;
  List<int> foolIndexList = [];

  String topicWord = "";
  String foolTopicWord = "";

  @override
  void initState() {
    super.initState();

    for (int index = 0; index < widget.foolCount; index++) {
      var foolIndex = Random().nextInt(widget.playerCount);
      if (!foolIndexList.contains(foolIndex)) foolIndexList.add(foolIndex);
    }

    List<String> topicList = mapList[widget.type]!;
    topicWord = topicList.elementAt(Random().nextInt(topicList.length));
    setFoolWord(topicList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black45,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: [
                const Text(
                  "주제",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.type,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w600),
                )
              ],
            ),
            const Divider(),
            (isOpen && nowPlayer < widget.playerCount)
                ? SizedBox(
                    height: 200,
                    child: Column(
                      children: [
                        const Text("제시어",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24)),
                        Text(
                            foolIndexList.contains(nowPlayer)
                                ? foolTopicWord
                                : topicWord,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 28)),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                isOpen = false;
                                nowPlayer++;
                                if (nowPlayer == widget.playerCount) {
                                  isGameDone = true;
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(36)),
                              margin: const EdgeInsets.only(top: 26),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 24),
                              child: const Text(
                                "확인완료!",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ))
                      ],
                    ),
                  )
                : keyWordOpen
                    ? Column(
                        children: [
                          KeywordOpenTextColumn(
                              title: "진짜 키워드", subTitle: topicWord),
                          KeywordOpenTextColumn(
                              title: "라이어 키워드", subTitle: foolTopicWord),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: KeywordOpenTextColumn(
                                title: "라이어 키워드", subTitle: foolTopicWord),
                          ),
                        ],
                      )
                    : GestureDetector(
                        onLongPress: () {
                          setState(() {
                            if (!isGameDone) {
                              isOpen = true;
                            } else {
                              keyWordOpen = true;
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 120, horizontal: 80),
                          child: Text(
                            isGameDone ? "각 키워드\n확인하기" : "2초 이상\n화면을 눌러주세요.",
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                        ),
                      )
          ],
        ),
      ),
    );
  }

  void setFoolWord(List<String> topicList) {
    foolTopicWord = topicList.elementAt(Random().nextInt(topicList.length));

    if (foolTopicWord == topicWord) setFoolWord(topicList);
  }
}

class KeywordOpenTextColumn extends StatelessWidget {
  const KeywordOpenTextColumn({
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        Text(
          subTitle,
          style: const TextStyle(fontSize: 24, color: Colors.black),
        ),
      ],
    );
  }
}
