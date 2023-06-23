import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_and_api_for_class/config/constants/api_endpoint_1.dart';
import 'package:hive_and_api_for_class/core/network/remote/http_service.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/course_entity.dart';
import '../dto/get_all_course_dto.dart';
import '../model/course_api_model.dart';

final courseRemoteDataSourceProvider = Provider(
  (ref) => CourseRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    courseApiModel: ref.read(courseApiModelProvider),
  ),
);

class CourseRemoteDataSource {
  final Dio dio;
  final CourseApiModel courseApiModel;

  CourseRemoteDataSource({
    required this.dio,
    required this.courseApiModel,
  });

  //Add Course

  Future<Either<Failure, bool>> addCourse(CourseEntity course) async {
    try {
      var response = await dio.post(
        ApiEndpoints.createCourse,
        data: {
          "courseName": course.courseName,
        },
      );
      //check for status code
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }

  //Get Course

  Future<Either<Failure, List<CourseEntity>>> getAllCourses() async {
    try {
      var response = await dio.get(ApiEndpoints.getAllCourse);
      //check for the status code
      if (response.statusCode == 200) {
        GetAllCourseDto getAllCourseDto =
            GetAllCourseDto.fromJson(response.data);

        //convert model to entity
        return Right(courseApiModel.toEntityList(getAllCourseDto.data));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }
}
