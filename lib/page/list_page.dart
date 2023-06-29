import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motivation_app/model/famous_list_model.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final ListPageController controller = Get.put(ListPageController());
//card 이용?
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      //새로고침
      onRefresh: () async {
        setState(() {
          controller.shuffle();
        });
      },
      child: Padding(
        padding: EdgeInsets.only(right: 10, left: 10),
        child: GridView.builder(
          itemCount:
              controller.famous_list_model.famous_saying.length, //item 개수
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
            childAspectRatio: 1, //item 의 가로 1, 세로 2 의 비율
            mainAxisSpacing: 10, //수평 Padding
            crossAxisSpacing: 10, //수직 Padding
          ),
          itemBuilder: (BuildContext context, int index) {
            //item 의 반목문 항목 형성
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),

              elevation: 4.0, //그림자 깊이
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: SingleChildScrollView(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        controller.famous_list_model
                                            .famous_saying[index],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400),
                                      ),
                                      // Text("스크랩, 저장, 공유"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  });
                },
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      controller.famous_list_model.famous_saying[index],
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ListPageController extends GetxController {
  final famous_list_model = FamousListModel();

  void shuffle() {
    famous_list_model.famous_saying.shuffle();
  }
}
