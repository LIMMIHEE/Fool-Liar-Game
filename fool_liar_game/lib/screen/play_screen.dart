import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fool_liar_game/topic/topic.dart';

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

    List<String> topicList = topicMap[widget.type]!;
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
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  widget.type,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w600),
                )
              ],
            ),
            const Divider(),
            SizedBox(
              height: 300,
              child: (isOpen && nowPlayer < widget.playerCount)
                  ? SizedBox(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                          GestureDetector(
                              onTap: () {
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
                                margin: const EdgeInsets.only(top: 40),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 24),
                                child: const Text(
                                  "확인완료",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ))
                        ],
                      ),
                    )
                  : keyWordOpen
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            KeywordOpenTextColumn(
                                title: "시민 키워드", subTitle: topicWord),
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
                            width: 300,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: isGameDone
                                    ? Colors.black87
                                    : Colors.transparent,
                                border:
                                    Border.all(width: 1, color: Colors.black87),
                                borderRadius: BorderRadius.circular(16)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 120, horizontal: 80),
                            child: Text(
                              isGameDone ? "각 키워드\n확인하기" : "2초 이상\n화면을 눌러주세요.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: isGameDone
                                      ? Colors.white
                                      : Colors.black87),
                            ),
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
