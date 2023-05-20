import 'package:flutter/material.dart';
import 'package:fool_liar_game/Screen/PlayScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var MenuType = ["음식", "영화"];
  String selectedDropdown = '음식';
  int count = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '인원',
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Icon(Icons.remove),
                    onTap: () {
                      setState(() {
                        if (count > 3) count--;
                      });
                    },
                  ),
                  Container(
                    child: Text("$count"),
                  ),
                  GestureDetector(
                    child: Icon(Icons.add),
                    onTap: () {
                      setState(() {
                        count++;
                      });
                    },
                  )
                ],
              ),
            ),
            Text(
              '주제',
            ),
            DropdownButton(
              value: selectedDropdown,
              items: MenuType.map((String item) {
                return DropdownMenuItem<String>(
                  child: Text('$item'),
                  value: item,
                );
              }).toList(),
              onChanged: (dynamic value) {
                setState(() {
                  selectedDropdown = value;
                });
              },
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlayScreen(
                              type: selectedDropdown, playerCount: count)));
                },
                child: Text("확인"))
          ],
        ),
      ),
    );
  }
}
