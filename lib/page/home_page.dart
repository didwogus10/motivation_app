import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motivation_app/model/famous_list_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageController controller = Get.put(HomePageController());
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    // 현재 시간을 기준으로 다음 자정까지의 시간을 계산
    DateTime now = DateTime.now();
    DateTime nextMidnight = DateTime(now.year, now.month, now.day + 1);
    Duration duration = nextMidnight.difference(now);

    // 타이머 설정
    _timer = Timer.periodic(duration, (Timer timer) {
      // 자정마다 수행될 동작
      setState(() {
        controller.updateIndex();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlipCard(
          direction: FlipDirection.HORIZONTAL,
          // front of the card
          front: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4.0,
            child: Container(
              alignment: Alignment.center,
              width: 250,
              height: 250,
              child: Text(
                "오늘의 명언",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          // back of the card
          back: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4.0,
            child: Container(
              alignment: Alignment.center,
              width: 250,
              height: 250,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  controller._displayText,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Get.isDarkMode
                ? controller.dark_or_light = Icons.dark_mode
                : controller.dark_or_light = Icons.light_mode;
          });
          Get.changeTheme(
            Get.isDarkMode
                ? ThemeData(
                    brightness: Brightness.light,
                    fontFamily: 'The Jamsil',
                  )
                : ThemeData(
                    brightness: Brightness.dark,
                    fontFamily: 'The Jamsil',
                  ),
          );
        },
        child: Icon(
          controller.dark_or_light,
        ),
      ),
    );
  }

//명언 하루마다 업데이트
}

class HomePageController extends GetxController {
  final famous_list_model = FamousListModel();
  IconData dark_or_light = Icons.dark_mode;
  String _displayText =
      '만약 떨어지면 어떻게 하지? 라고 너무 고민하지마라. 만약 날게 되면 어떻게 할 것인가?\n\n –Erin Hanson–'; //첫번째 명언
  int index = 0;

  void updateIndex() {
    _displayText = famous_list_model.famous_saying[
        index > famous_list_model.famous_saying.length ? index = 0 : index + 1];
    //index가 명언리스트 총 개수 넘으면 다시 처음부터
  }
}
