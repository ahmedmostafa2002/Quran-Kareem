import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_kareem/widgets/ayah.dart';
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
                controller.searchAyah(removeTashkeel(text));
                text.isEmpty ? controller.clearSearchAyah() : null;
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) {
                    if (controller.searchAyahText.isNotEmpty) {
                      controller.searchScrollController.jumpTo(index: 0);
                    }
                  },
                );
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
                  controller.clearSearchAyah();
                },
                icon: const Icon(
                  Icons.close,
                  size: 25,
                  color: bG,
                ))
          ],
        ),
        body: ScrollablePositionedList.builder(
          itemCount: ayahsApi.length,
          itemScrollController: controller.searchScrollController,
          itemBuilder: (context, index) {
            return removeTashkeel(ayahsApi[index]["text"])
                    .contains(controller.searchAyahText)
                ? Ayah(ayahIndex: index)
                : const SizedBox.shrink();
          },
        ),
      );
    });
  }
}
