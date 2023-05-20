import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final jsonDataPod = FutureProvider.autoDispose<List>((ref) async {
  String data = await rootBundle.loadString('assets/example.json');
  try {
    final jsonResult = json.decode(data);
    return jsonResult as List;
  } catch (e) {
    return [];
  }
});

final cakesPod = FutureProvider.autoDispose<List<Map>>((ref) async {
  final jsonData = await ref.watch(jsonDataPod.future);
  final List<Map> cakemaps = [];
  if (jsonData.isNotEmpty) {
    for (var cake in jsonData) {
      final batters = cake['batters']['batter'] as List? ?? [];
      final toppingmaps = cake['topping'] as List<dynamic>? ?? [];
      final toppings = toppingmaps.map((e) => e['type'].toString()).join(',');

      for (var batter in batters) {
        final cakemap = {
          "id": cake['id'],
          "type": cake['type'],
          "name": cake['name'],
          "ppu": cake['ppu'],
          "batter": batter['type'],
          "topping": toppings,
        };
        cakemaps.add(cakemap);
      }
    }
  }
  return cakemaps;
});
