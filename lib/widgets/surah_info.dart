import 'package:alquran_alkareem/models/surah_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alquran_alkareem/controller/controller.dart';
import 'package:alquran_alkareem/data/api/quran_api.dart';

import '../utiles/values.dart';
import '../utiles/my_extention.dart';

class SurahInfo extends StatelessWidget {
  const SurahInfo({super.key, required this.index, required this.surahModel});
  final SurahModel surahModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(builder: (controller) {
      return InkWell(
        onTap: () {
          for (int i = 0; i < ayahsApi.length; i++) {
            ayahsApi[i]['numberInSurah'] == 1 &&
                    surahModel.name == ayahsApi[i]["name"]
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
          height: context.isPortrait
              ? context.screenHeight / 14
              : context.screenWidth / 14,
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
                    surahModel.page.toString(),
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
                      Text(surahModel.name,
                          style: TextStyle(
                              color: index == controller.surahIndex
                                  ? Colors.black
                                  : Colors.white)),
                      Text(
                          surahModel.revelationType == 'Meccan'
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
                  Text(surahModel.numberOfAyahs,
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
                  Text(surahModel.page,
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
