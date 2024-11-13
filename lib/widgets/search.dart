import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alquran_alkareem/widgets/ayah.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../controller/controller.dart';
import '../main.dart';
import '../data/api/quran_api.dart';
import '../models/aya_model.dart';
import '../utiles/values.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Controller controller = Get.put(
    Controller(),
  );
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.checkSearch(true);
    });
    super.initState();
  }

  @override
  void dispose() {
    Future.delayed(Duration.zero, () {
    controller.checkSearch(false);
  });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      ayahModel: AyaModel(
                          surahName: ayahsApi[ayahsApi.indexWhere((ayah) =>
                                  removeTashkeel(ayah["text"]) ==
                                  removeTashkeel(controller.filterAyahs[index]))]
                              ["name"],
                          ayahText:
                              ayahsApi[ayahsApi.indexWhere((ayah) => removeTashkeel(ayah["text"]) == removeTashkeel(controller.filterAyahs[index]))]
                                  ["text"],
                          ayaNumber:
                              ayahsApi[ayahsApi.indexWhere((ayah) => removeTashkeel(ayah["text"]) == removeTashkeel(controller.filterAyahs[index]))]
                                      ["numberInSurah"]
                                  .toString(),
                          page: ayahsApi[ayahsApi.indexWhere((ayah) => removeTashkeel(ayah["text"]) == removeTashkeel(controller.filterAyahs[index]))]["page"].toString(),
                          juz: ayahsApi[ayahsApi.indexWhere((ayah) => removeTashkeel(ayah["text"]) == removeTashkeel(controller.filterAyahs[index]))]["juz"].toString()),
                      ayahIndex: ayahsApi.indexWhere((ayah) => removeTashkeel(ayah["text"]) == removeTashkeel(controller.filterAyahs[index])));
                },
              ),
      );
    });
  }
}
