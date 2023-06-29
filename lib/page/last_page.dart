import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LastPage extends StatefulWidget {
  const LastPage({super.key});

  @override
  State<LastPage> createState() => _LastPageState();
}

class _LastPageState extends State<LastPage> {
  final _TextEditController = TextEditingController();
  final LastPageController controller = Get.put(LastPageController());

  @override
  void dispose() {
    _TextEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    final String formattedTime = "${now.year}.${now.month}.${now.day}";

    return Scaffold(
      body: ListView.builder(
          itemCount: controller.text_list.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: UniqueKey(), //key값에대한 공부 해야함
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  setState(() {
                    controller.text_list.removeAt(index); //밀었을때 카드 삭제
                    controller.date_list.removeAt(index); //날짜도 같이 삭제
                    print(controller.text_list.length);
                  });
                }
              },
              confirmDismiss: (direction) async {
                //왜 async가 붙는지 공부하기
                if (direction == DismissDirection.endToStart) {
                  return Get.defaultDialog(
                      title: '정말 삭제하시겠습니까?',
                      content: const Text(
                        '삭제된 글은 복구가 불가능합니다.',
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      textConfirm: '예',
                      confirmTextColor:
                          Get.isDarkMode //확인버튼 다크모드면 black 아니면 white
                              ? Colors.black
                              : Colors.white,
                      onConfirm: () {
                        Get.back(result: true); //돌아가고 true반환?
                      },
                      textCancel: '취소',
                      onCancel: () {
                        Get.back(result: false);
                      });
                }
              },
              background: _buildBackgroundWidget,
              child: Card(
                margin: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 4.0,
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 100,
                        child: Text(
                          controller.text_list[index], //작성한 카드
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                          controller.date_list[index], //작성한 날짜
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
              title: '명언 작성하기',
              content: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    controller: _TextEditController,
                  )),
              textConfirm: "확인",
              onConfirm: () {
                setState(() {
                  if (_TextEditController.text.isEmpty) {
                    //텍스트필드 비어있으면 확인눌러도 리스트 안만들어짐
                    Get.back();
                  } else
                    controller.text_list.add("\"" +
                        _TextEditController.text +
                        "\""); //리스트에 하나씩 추가(이스케이프 시퀀스 활용)
                  controller.date_list.add(formattedTime); //리스트만들었을때 오른쪽밑에 시간표시
                  print(formattedTime);
                });
                _TextEditController.clear(); //기존 남아있는 텍스트 삭제
                Get.back();
              },
              confirmTextColor: Get.isDarkMode //확인버튼 다크모드면 black 아니면 white
                  ? Colors.black
                  : Colors.white,
              textCancel: "취소",
              onCancel: () {
                _TextEditController.clear();
              });
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}

//드래그했을때 빨간휴지통 속성
final _buildBackgroundWidget = Container(
  margin: const EdgeInsets.all(8),
  padding: const EdgeInsets.symmetric(horizontal: 20),
  color: Colors.red,
  alignment: Alignment.centerRight,
  child: const Icon(
    Icons.delete,
    size: 36,
    color: Colors.white,
  ),
);

//이 페이지 getx 컨트롤러
class LastPageController extends GetxController {
  List<String> text_list = [
    "자신만의 명언을 작성해 보세요",
    "ex) Just do it",
  ]; //작성할 명언리스트

  List<String> date_list = [
    "",
    "",
  ]; //날짜 리스트
}
