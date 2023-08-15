import 'package:json_annotation/json_annotation.dart';

part 'tab_item.g.dart';

@JsonSerializable()
class TabItem {
  final String tabId;
  final String name;
  final String image;

  const TabItem({
    required this.tabId,
    required this.name,
    required this.image,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TabItem &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          image == other.image &&
          tabId == other.tabId;

  @override
  int get hashCode => name.hashCode ^ image.hashCode ^ tabId.hashCode;

  @override
  String toString() {
    return 'Movie{name: $name, tabId: $tabId}';
  }

  factory TabItem.fromJson(Map<String, dynamic> data) => _$TabItemFromJson(data);

  Map<String, dynamic> toJson() => _$TabItemToJson(this);

  static const fromJsonFactory = _$TabItemFromJson;
}
