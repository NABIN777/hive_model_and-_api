import 'package:json_annotation/json_annotation.dart';

import '../model/course_api_model.dart';

part 'get_all_course_dto.g.dart';

@JsonSerializable()
class GetAllCourseDto {
  final bool success;
  final int count;
  // @JsonKey(name: 'data')
  final List<CourseApiModel> data;

  GetAllCourseDto({
    required this.success,
    required this.count,
    required this.data,
  });

  factory GetAllCourseDto.fromJson(Map<String, dynamic> json) =>
      _$GetAllCourseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllCourseDtoToJson(this);
}
