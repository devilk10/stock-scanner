// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanner_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Criteria _$CriteriaFromJson(Map<String, dynamic> json) => Criteria(
      type: json['type'] as String,
      text: json['text'] as String,
      variable: json['variable'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$CriteriaToJson(Criteria instance) => <String, dynamic>{
      'type': instance.type,
      'text': instance.text,
      'variable': instance.variable,
    };

ScannerResult _$ScannerResultFromJson(Map<String, dynamic> json) =>
    ScannerResult(
      id: json['id'] as int,
      name: json['name'] as String,
      tag: json['tag'] as String,
      color: json['color'] as String,
      criteria: (json['criteria'] as List<dynamic>)
          .map((e) => Criteria.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScannerResultToJson(ScannerResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tag': instance.tag,
      'color': instance.color,
      'criteria': instance.criteria,
    };
