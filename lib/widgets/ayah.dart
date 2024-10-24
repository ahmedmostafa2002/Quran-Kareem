import 'package:alquran_alkareem/models/aya_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alquran_alkareem/utiles/tafsir.dart';

import '../controller/controller.dart';
import '../main.dart';
import '../utiles/values.dart';
import '../utiles/screen_info.dart';

class Ayah extends StatelessWidget {
  const Ayah({super.key, required this.ayahModel, required this.ayahIndex});

  final AyaModel ayahModel;
  final int ayahIndex;

  @override
  Widget build(BuildContext context) {
    Get.put(
      Controller(),
    );
    return GetBuilder<Controller>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {},
            highlightColor: Colors.amber[100],
            onLongPress: () {
              controller.setTafsirAyahIndex(ayahIndex);
              Get.bottomSheet(tafsir);
            },
            child: Text(
              "${ayahModel.ayahText}\uFD3F${ayahModel.ayaNumber}\uFD3E",
              style: TextStyle(
                  fontSize: controller.fontSize == 1
                      ? 20
                      : controller.fontSize == 1.8
                          ? 22
                          : controller.fontSize == 2.6
                              ? 26
                              : controller.fontSize == 3.4
                                  ? 30
                                  : controller.fontSize == 4.2
                                      ? 34
                                      : 38,
                  color: controller.isDarkMode == true ? bG : Colors.black),
              textAlign: TextAlign.start,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              controller.searchOn == true
                  ? TextButton(
                      onPressed: () {
                        controller.scrollController.jumpTo(index: ayahIndex);
                        Navigator.pop(context);
                        controller.clearFilterAyahs();
                        controller.checkSearch(false);
                      },
                      child: const Text(
                        "الانتقال الي الأيه",
                        style: TextStyle(fontSize: 18, color: secondryBG),
                      ))
                  : IconButton(
                      onPressed: () async {
                        controller.ayahsIndex != ayahIndex
                            ? controller.savePosition(ayahIndex)
                            : controller.savePosition(-1);
                        sharedPref.getInt("ayahsIndex") == null ||
                                sharedPref.getInt("ayahsIndex") != ayahIndex
                            ? await sharedPref.setInt("ayahsIndex", ayahIndex)
                            : sharedPref.remove("ayahsIndex");
                      },
                      icon: Icon(controller.ayahsIndex == ayahIndex
                          ? Icons.bookmark
                          : Icons.bookmark_border_outlined),
                      color: secondryBG,
                      iconSize: 22,
                    ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                height: ScreenInfo.isPortrait(context)
                    ? ScreenInfo.height(context) / 24
                    : ScreenInfo.width(context) / 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: secondryBG,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("رقم الصفحه",
                        style: TextStyle(color: Colors.white)),
                    const SizedBox(
                      width: 14,
                    ),
                    Text(
                      " ${ayahModel.page}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                height: ScreenInfo.isPortrait(context)
                    ? ScreenInfo.height(context) / 24
                    : ScreenInfo.width(context) / 24,
                color: secondryBG,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(ayahModel.surahName,
                          style: const TextStyle(color: Colors.white)),
                      const SizedBox(
                        width: 14,
                      ),
                      Text(
                        "رقم الجزء ${ayahModel.juz}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Divider()
        ],
      );
    });
  }
}
