import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'map_data.dart';

class SharedPrefsService {
  static final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static Future<List<MapData>> getMaps() async {
    final prefs = await _prefs;
    final List<String> mapStrings = prefs.getStringList('maps') ?? [];
    return mapStrings.map((mapString) => MapData.fromJson(jsonDecode(mapString))).toList();
  }

  static Future<void> saveMap(MapData mapData) async {
    final prefs = await _prefs;
    final List<String> mapStrings = prefs.getStringList('maps') ?? [];
    mapStrings.add(jsonEncode(mapData.toJson()));
    await prefs.setStringList('maps', mapStrings);
  }

  static Future<void> deleteMap(String mapName) async {
    final prefs = await _prefs;
    final List<String> mapStrings = prefs.getStringList('maps') ?? [];

    // Filter out the map with the matching name
    final filteredMaps = mapStrings.where((mapString) =>
    !jsonDecode(mapString)['name'].toString().contains(mapName)).toList();

    await prefs.setStringList('maps', filteredMaps);
  }
}
