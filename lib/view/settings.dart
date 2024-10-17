import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_kareem/controller/controller.dart';
import 'package:quran_kareem/main.dart';
import 'package:quran_kareem/utiles/values.dart';
import 'package:quran_kareem/utiles/screen_info.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Controller());
    return GetBuilder<Controller>(builder: (controller) {
      return Scaffold(
        backgroundColor: controller.isDarkMode == true
            ? const Color.fromRGBO(31, 33, 37, 100)
            : bG,
        appBar: AppBar(
          backgroundColor: controller.isDarkMode == true
              ? const Color.fromRGBO(31, 33, 37, 100)
              : bG,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios,
                color: controller.isDarkMode == true ? bG : Colors.black,
              )),
          title: Text(
            'الاعدادات',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: controller.isDarkMode == true ? bG : Colors.black),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'حجم الخط',
                      style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: controller.isDarkMode == true
                              ? bG
                              : Colors.black),
                    ),
                  ),
                  Slider(
                    value: controller.fontSize,
                    onChanged: (value) {
                      controller.updateFontSize(value);
                    },
                    activeColor: secondryBG,
                    min: 1,
                    max: 5,
                    divisions: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'المظهر',
                          style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                              color: controller.isDarkMode == true
                                  ? bG
                                  : Colors.black),
                        ),
                        IconButton(
                            onPressed: () {
                              controller.changeTheme();
                            },
                            icon: Icon(
                              controller.isDarkMode == true
                                  ? Icons.light_mode
                                  : Icons.dark_mode,
                              color: controller.isDarkMode == true
                                  ? bG
                                  : Colors.black,
                              size: 26,
                            )),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 0.2,
                    color: controller.isDarkMode == true ? bG : Colors.black,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      print(sharedPref.getInt("ayahsIndex"));
                      if (sharedPref.getInt("ayahsIndex") != null) {
                        controller.scrollController
                            .jumpTo(index: sharedPref.getInt("ayahsIndex")!);
                        Navigator.pop(context);
                      } else {
                        Get.snackbar("", "لا توجد ايه محفوظه",
                            snackPosition: SnackPosition.BOTTOM);
                      }
                    },
                    child: const Text(
                      "الذهاب الي الايه المحفوظه",
                      style: TextStyle(fontSize: 22, color: secondryBG),
                    ),
                  ),
                  Container(
                    height: ScreenInfo.isPortrait(context)
                        ? ScreenInfo.height(context) / 10
                        : ScreenInfo.width(context) / 10,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    margin: EdgeInsets.only(
                      top: ScreenInfo.height(context) / 2.6,
                    ),
                    child: ElevatedButton(
                        onPressed: () async {
                          await sharedPref.setDouble(
                              "fontSize", controller.fontSize);
                          await sharedPref.setBool(
                              "isDark", controller.isDarkMode);
                          Get.snackbar("", 'تم حفظ الاعدادات',
                              backgroundColor: secondryBG,
                              colorText: bG,
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 1),
                              animationDuration: const Duration(seconds: 1));
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(secondryBG)),
                        child: const Text(
                          'حفظ الاعدادات',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: bG),
                        )),
                  )
                ],
              )),
        )),
      );
    });
  }
}
