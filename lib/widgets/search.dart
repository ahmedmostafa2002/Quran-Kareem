import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alquran_alkareem/widgets/ayah.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../controller/controller.dart';
import '../main.dart';
import '../utiles/api/quran_api.dart';
import '../utiles/values.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(
      Controller(),
    );
    TextEditingController searchController = TextEditingController();

    return GetBuilder<Controller>(builder: (controller) {
      return Scaffold(
        backgroundColor: controller.isDarkMode == true
            ? const Color.fromRGBO(31, 33, 37, 0)
            : bG,
        appBar: AppBar(
          backgroundColor: secondryBG,
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              controller.checkSearch(false);
              searchController.clear();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: TextField(
              onChanged: (text) {
                if (text.isEmpty) {
                  controller.clearFilterAyahs();
                } else {
                  controller.clearFilterAyahs();
                  for (int i = 0; i < ayahsApi.length; i++) {
                    removeTashkeel(ayahsApi[i]['text'])
                            .contains(removeTashkeel(text))
                        ? controller.addToFilterAyahs(ayahsApi[i]['text'])
                        : null;
                  }
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) {
                      if (controller.filterAyahs.isNotEmpty) {
                        controller.searchScrollController.jumpTo(index: 0);
                      }
                    },
                  );
                }
              },
              autofocus: true,
              style: const TextStyle(color: bG),
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'ابحث عن ايه...',
                hintStyle: TextStyle(color: bG),
                border: InputBorder.none,
              )),
          actions: [
            IconButton(
                onPressed: () {
                  searchController.clear();
                  controller.clearFilterAyahs();
                },
                icon: const Icon(
                  Icons.close,
                  size: 25,
                  color: bG,
                ))
          ],
        ),
        body: controller.filterAyahs.isEmpty
            ? const SizedBox.shrink()
            : ScrollablePositionedList.builder(
                itemCount: controller.filterAyahs.length,
                itemScrollController: controller.searchScrollController,
                itemBuilder: (context, index) {
                  return Ayah(
                      ayahIndex: ayahsApi.indexWhere((ayah) =>
                          removeTashkeel(ayah["text"]) ==
                          removeTashkeel(controller.filterAyahs[index])));
                },
              ),
      );
    });
  }
}
