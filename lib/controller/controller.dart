import 'package:get/get.dart';
import 'package:quran_kareem/main.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Controller extends GetxController {
  final ItemScrollController scrollController = ItemScrollController();
  final ItemScrollController scrollController2 = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetController scrollOffset = ScrollOffsetController();

  final ItemScrollController searchScrollController = ItemScrollController();

// Search part *******************************************
  bool searchOn = false;
  void checkSearch(bool val) {
    searchOn = val;
    update();
  }

  String searchSurahText = '';
  void searchSurah(String text) {
    searchSurahText = text;
    update();
  }

  void clearSearchSurahs() {
    searchSurahText = '';
    update();
  }

  String searchAyahText = '';
  void searchAyah(String text) {
    searchAyahText = text;
    update();
  }

  void clearSearchAyah() {
    searchAyahText = '';
    update();
  }

// theme part *********************************************
  bool isDarkMode = sharedPref.getBool("isDark") == null
      ? false
      : sharedPref.getBool("isDark")!;
  void changeTheme() {
    isDarkMode == true ? isDarkMode = false : isDarkMode = true;
    update();
  }

// font part *********************************************
  double fontSize = sharedPref.getDouble("fontSize") == null
      ? 2.6
      : sharedPref.getDouble("fontSize")!;
  void updateFontSize(double value) {
    fontSize = value;
    update();
  }

// drawer part *********************************************
  int surahIndex = 0;
  void setSurahIndex(int i) {
    surahIndex = i;
    update();
  }

  int ayahIndex = 0;
  void setAyahIndex(int i) {
    ayahIndex = i;
    update();
  }

// saved position part *************************************
  double offset = 0;
  void setOffset(double value) {
    offset = value;
    update();
  }

//  int surahNumber = 0;
  int ayahsIndex = sharedPref.getInt("ayahsIndex") == null
      ? -1
      : sharedPref.getInt("ayahsIndex")!;
  void savePosition(int index) {
    ayahsIndex = index;
    update();
  }

  //tafsir part *******************************************
  int tafsirAyahIndesx = 0;
  void setTafsirAyahIndex(int index) {
    tafsirAyahIndesx = index;
    update();
  }
}
