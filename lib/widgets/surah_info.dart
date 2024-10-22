import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alquran_alkareem/controller/controller.dart';
import 'package:alquran_alkareem/utiles/api/quran_api.dart';
import 'package:alquran_alkareem/utiles/api/surahs.dart';

import '../utiles/values.dart';
import '../utiles/screen_info.dart';

class SurahInfo extends StatelessWidget {
  const SurahInfo({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(builder: (controller) {
      return InkWell(
        onTap: () {
          for (int i = 0; i < ayahsApi.length; i++) {
            ayahsApi[i]['numberInSurah'] == 1 &&
                    surahsApi[index]["name"] == ayahsApi[i]["name"]
                ? controller.setAyahIndex(i)
                : null;
          }
          controller.scrollController.jumpTo(
            index: controller.ayahIndex,
          );

          Navigator.pop(context);
          controller.setSurahIndex(index);
          controller.clearSearchSurahs();
        },
        child: Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.symmetric(vertical: 2),
          height: ScreenInfo.isPortrait(context)
              ? ScreenInfo.height(context) / 14
              : ScreenInfo.width(context) / 14,
          decoration: BoxDecoration(
            color:
                index == controller.surahIndex ? Colors.amber[50] : secondryBG,
            border: Border.all(color: secondryBG, strokeAlign: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    surahsApi[index]["number"].toString(),
                    style: TextStyle(
                        color: index == controller.surahIndex
                            ? Colors.black
                            : Colors.white),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(surahsApi[index]["name"],
                          style: TextStyle(
                              color: index == controller.surahIndex
                                  ? Colors.black
                                  : Colors.white)),
                      Text(
                          surahsApi[index]["revelationType"] == 'Meccan'
                              ? 'مكيه'
                              : 'مدنيه',
                          style: TextStyle(
                              color: index == controller.surahIndex
                                  ? Colors.black
                                  : Colors.white))
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("عدد الأيات",
                      style: TextStyle(
                          color: index == controller.surahIndex
                              ? Colors.black
                              : Colors.white)),
                  Text("${surahsApi[index]["numberOfAyahs"]}",
                      style: TextStyle(
                          color: index == controller.surahIndex
                              ? Colors.black
                              : Colors.white))
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("الصفحه",
                      style: TextStyle(
                          color: index == controller.surahIndex
                              ? Colors.black
                              : Colors.white)),
                  Text("${surahsApi[index]["page"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: index == controller.surahIndex
                            ? Colors.black
                            : Colors.white,
                      )),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
