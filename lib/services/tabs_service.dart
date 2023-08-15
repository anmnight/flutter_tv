import 'package:flutter_tv/domain/tab_item.dart';

abstract class TabsService {
  Future<List<TabItem>> getTabs();
}
