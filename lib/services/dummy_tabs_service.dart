import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_tv/domain/tab_item.dart';
import 'package:flutter_tv/domain/tabs_list.dart';
import 'package:flutter_tv/services/tabs_service.dart';

class DummyTabsService implements TabsService {
  @override
  Future<List<TabItem>> getTabs() async {
    //todo 数据解析异常处理
    List<TabItem> tabs = TabsList.fromJson(
      await rootBundle.loadString('assets/tabs_service.json').then(
            (tabs) => json.decode(tabs),
          ),
    ).tabs;
    return Future.delayed(const Duration(seconds: 2), () => tabs);
  }
}
