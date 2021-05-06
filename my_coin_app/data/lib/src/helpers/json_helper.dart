import 'dart:convert';

import 'package:flutter_sdk/flutter_sdk.dart';

class JsonHelper {
  static Map<String, dynamic> getMap(dynamic data) {
    try {
      if (data != null) {
        if (data is Map) return data as Map<String, dynamic>;
        return jsonDecode(data.toString()) as Map<String, dynamic>;
      }
    } catch (e) {
      Log.e(e.toString(), tag: 'JsonHelper');
    }
    return null;
  }

  static List<Map<String, dynamic>> getMapList(dynamic data) {
    final List<Map<String, dynamic>> mapList = [];
    if (data == null) return mapList;

    try {
      if (data is! List) {
        data = jsonDecode(data.toString()) as List<dynamic>;
      }
      data.forEach((data) {
        final element = getMap(data);
        if (element != null) {
          mapList.add(element);
        }
      });
    } catch (e) {
      Log.e(e.toString(), tag: 'JsonHelper');
    }

    return mapList;
  }
}
