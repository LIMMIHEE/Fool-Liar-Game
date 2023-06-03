import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fool_liar_game/Screen/PlayScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final menuType = ["음식", "영화", "직업", "동물", "장소", "나라"];
  String? selectedValue;
  int personCount = 3;
  int foolCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('게임 인원', style: TextStyle(fontSize: 20)),
            UpDownContainer(
              count: personCount,
              upAction: () {
                setState(() {
                  personCount++;
                });
              },
              downAction: () {
                setState(() {
                  if (personCount > 3) personCount--;
                });
              },
            ),
            const Text('라이어 인원', style: TextStyle(fontSize: 20)),
            UpDownContainer(
              count: foolCount,
              upAction: () {
                setState(() {
                  if (personCount - 1 > foolCount) foolCount++;
                });
              },
              downAction: () {
                setState(() {
                  if (foolCount > 1) foolCount--;
                });
              },
            ),
            const Text('주제', style: TextStyle(fontSize: 20)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 26),
              child: DropdownButtonFormField2(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                isExpanded: true,
                hint: const Text(
                  '주제를 선택 해주세요',
                  style: TextStyle(fontSize: 14),
                ),
                items: menuType
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return '주제를 선택 해주세요.';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    selectedValue = value.toString();
                  });
                },
                onSaved: (value) {
                  selectedValue = value.toString();
                },
                buttonStyleData: const ButtonStyleData(
                  height: 60,
                  padding: EdgeInsets.only(left: 20, right: 10),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 30,
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 26),
              child: OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                  ),
                  onPressed: () {
                    if (selectedValue == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('주제를 선택 해주세요.'),
                      ));

                      return;
                    }

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlayScreen(
                                type: selectedValue!,
                                playerCount: personCount,
                                foolCount: foolCount)));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "확인",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class UpDownContainer extends StatelessWidget {
  const UpDownContainer({
    super.key,
    required this.count,
    required this.upAction,
    required this.downAction,
  });

  final Function() upAction;
  final Function() downAction;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 46),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            child: const Icon(
              Icons.remove,
              size: 42,
            ),
            onTap: () => downAction(),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              "$count",
              style: const TextStyle(fontSize: 36),
            ),
          ),
          GestureDetector(
            child: const Icon(
              Icons.add,
              size: 42,
            ),
            onTap: () => upAction(),
          )
        ],
      ),
    );
  }
}
