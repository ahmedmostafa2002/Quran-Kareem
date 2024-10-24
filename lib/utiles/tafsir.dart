import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';
import '../data/api/quran_api.dart';
import '../data/api/tafsir_muyassar.dart';
import 'values.dart';
import 'screen_info.dart';

Controller controller = Get.put(Controller(), permanent: true);
BottomSheet tafsir = BottomSheet(
  onClosing: () {},
  elevation: 10,
  backgroundColor: controller.isDarkMode == true
      ? const Color.fromARGB(255, 52, 58, 64)
      : bG,
  enableDrag: false,
  showDragHandle: false,
  builder: (context) {
    return GetBuilder<Controller>(builder: (myController) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(14),
        height: ScreenInfo.height(context),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'التفسير الميسر',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: controller.isDarkMode == true ? bG : Colors.black),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        if (myController.tafsirAyahIndesx > 0) {
                          myController.setTafsirAyahIndex(
                              myController.tafsirAyahIndesx - 1);
                        }
                      },
                      icon:
                          const Icon(Icons.arrow_back_ios, color: secondryBG)),
                  Text(
                    "${ayahsApi[myController.tafsirAyahIndesx]['name']} ${ayahsApi[myController.tafsirAyahIndesx]['numberInSurah']}",
                    style: const TextStyle(
                        fontSize: 18,
                        color: secondryBG,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        if (myController.tafsirAyahIndesx <
                            ayahsApi.length - 1) {
                          myController.setTafsirAyahIndex(
                              myController.tafsirAyahIndesx + 1);
                        }
                      },
                      icon: const Icon(Icons.arrow_forward_ios,
                          color: secondryBG))
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                  tafsirMuyassar[myController.tafsirAyahIndesx]["text"]
                      .toString(),
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
                    color: controller.isDarkMode == true ? bG : Colors.black,
                  ),
                  textAlign: TextAlign.start)
            ],
          ),
        ),
      );
    });
  },
);
