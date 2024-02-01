import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scanner_result.g.dart';

@JsonSerializable()
class Criteria {
  final String type;
  final String text;
  final Map<String, dynamic>? variable;

  Criteria({
    required this.type,
    required this.text,
    this.variable,
  });

  factory Criteria.fromJson(Map<String, dynamic> json) =>
      _$CriteriaFromJson(json);

  Map<String, dynamic> toJson() => _$CriteriaToJson(this);
}

@JsonSerializable()
class ScannerResult extends Equatable {
  final int id;
  final String name;
  final String tag;
  final String color;
  final List<Criteria> criteria;

  const ScannerResult({
    required this.id,
    required this.name,
    required this.tag,
    required this.color,
    required this.criteria,
  });

  factory ScannerResult.fromJson(Map<String, dynamic> json) =>
      _$ScannerResultFromJson(json);

  Map<String, dynamic> toJson() => _$ScannerResultToJson(this);

  @override
  List<Object?> get props => [id, name, tag, color, criteria];
}
