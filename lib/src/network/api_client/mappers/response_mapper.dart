import 'package:json_annotation/json_annotation.dart';

part 'response_mapper.g.dart';

@JsonSerializable()
class ResponseMapper {
  const ResponseMapper({
    required this.message,
    required this.error,
    required this.statusCode,
  });

  factory ResponseMapper.fromJson(Map<String, dynamic> json) =>
      _$ResponseMapperFromJson(json);

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'error')
  final String error;

  @JsonKey(name: 'statusCode')
  final int statusCode;
}
