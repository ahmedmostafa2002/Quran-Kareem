import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_kareem/controller/controller.dart';

Controller controller = Get.put(Controller());

const Color bG = Color.fromRGBO(255, 250, 246, 1);
const Color secondryBG = Colors.blueGrey;
double fontSize = controller.fontSize == 1
    ? 20
    : controller.fontSize == 1.8
        ? 22
        : controller.fontSize == 2.6
            ? 26
            : controller.fontSize == 3.4
                ? 30
                : controller.fontSize == 4.2
                    ? 34
                    : 38;
