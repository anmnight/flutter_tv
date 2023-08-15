// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tabs_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TabsList _$TabsListFromJson(Map<String, dynamic> json) => TabsList(
      tabs: (json['tabs'] as List<dynamic>)
          .map((e) => TabItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TabsListToJson(TabsList instance) => <String, dynamic>{
      'tabs': instance.tabs,
    };
