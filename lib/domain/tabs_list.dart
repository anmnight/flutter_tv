import 'package:flutter_tv/domain/tab_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tabs_list.g.dart';

@JsonSerializable()
class TabsList {
  final List<TabItem> tabs;

  const TabsList({
    required this.tabs,
  });

  @override
  String toString() {
    return 'tabs: $tabs';
  }

  factory TabsList.fromJson(Map<String, dynamic> data) =>
      _$TabsListFromJson(data);

  Map<String, dynamic> toJson() => _$TabsListToJson(this);

  static const fromJsonFactory = _$TabsListFromJson;
}
