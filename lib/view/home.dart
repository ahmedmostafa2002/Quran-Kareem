import 'package:alquran_alkareem/models/aya_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alquran_alkareem/controller/controller.dart';
import 'package:alquran_alkareem/main.dart';
import 'package:alquran_alkareem/data/api/surahs.dart';
import 'package:alquran_alkareem/widgets/drawer.dart';
import 'package:alquran_alkareem/view/settings.dart';
import 'package:alquran_alkareem/widgets/ayah.dart';
import 'package:alquran_alkareem/widgets/search.dart';
import 'package:alquran_alkareem/widgets/surah_head.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../data/api/quran_api.dart';
import '../utiles/values.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    debugPrint('ayahsIndex : ${sharedPref.getInt('ayahsIndex')}');
  }

  @override
  Widget build(BuildContext context) {
    Controller myController = Get.put(Controller(), permanent: true);
    return GetBuilder<Controller>(builder: (controller) {
      return Scaffold(
          backgroundColor: controller.isDarkMode == true
              ? const Color.fromRGBO(31, 33, 37, 0)
              : bG,
          appBar: AppBar(
            backgroundColor: secondryBG,
            iconTheme: const IconThemeData(color: Colors.white),
            leading: Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                    if (myController
                        .itemPositionsListener.itemPositions.value.isNotEmpty) {
                      myController.setAyahIndex(myController
                          .itemPositionsListener
                          .itemPositions
                          .value
                          .first
                          .index);
                      for (int i = 0; i < surahsApi.length; i++) {
                        surahsApi[i]['name'] ==
                                ayahsApi[myController.ayahIndex]['name']
                            ? myController.setSurahIndex(i)
                            : null;
                      }
                    }

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      myController.scrollController2.jumpTo(
                        index: myController.surahIndex,
                      );
                    });
                    controller.clearSearchSurahs();
                  },
                  icon: const Icon(Icons.menu),
                );
              },
            ),
            title: const Text('القرآن الكريم',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
            actions: [
              IconButton(
                  onPressed: () {
                    controller.checkSearch(true);
                    Get.to(const SearchPage());
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 25,
                    color: bG,
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                    onPressed: () {
                      Get.to(const Settings());
                    },
                    icon: const Icon(
                      Icons.settings,
                      size: 28,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
          drawer: const MyDrawer(),
          body: SafeArea(
              child: ScrollablePositionedList.builder(
            itemScrollController: controller.scrollController,
            itemPositionsListener: controller.itemPositionsListener,
            scrollOffsetController: controller.scrollOffset,
            initialScrollIndex: sharedPref.getInt("ayahsIndex") == null
                ? 0
                : sharedPref.getInt("ayahsIndex")!,
            itemCount: ayahsApi.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ayahsApi[index]["numberInSurah"] == 1
                      ? SurahHead(ayahIndex: index)
                      : Ayah(
                          ayahIndex: index,
                          ayahModel: AyaModel(
                              surahName: ayahsApi[index]["name"],
                              ayahText: ayahsApi[index]["text"],
                              ayaNumber:
                                  ayahsApi[index]["numberInSurah"].toString(),
                              page: ayahsApi[index]["page"].toString(),
                              juz: ayahsApi[index]["juz"].toString()),
                        ));
            },
          )));
    });
  }
}
