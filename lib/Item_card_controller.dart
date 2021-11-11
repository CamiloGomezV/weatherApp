import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data_service.dart';
import 'models.dart';

class CardController extends GetxController {
  final cityTextController = TextEditingController().obs;
  final dataService = DataService().obs;
  final background =
      [Colors.cyan.shade800, Colors.cyan.shade800, Colors.white].obs;
  final response = WeatherResponse().obs;
  final fav = Icon(Icons.favorite_border).obs;
  final aux = true.obs;
  final selectedId = 0.obs;
}
