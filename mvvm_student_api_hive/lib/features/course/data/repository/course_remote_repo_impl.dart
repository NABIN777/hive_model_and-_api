import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_and_api_for_class/core/failure/failure.dart';

import '../../domain/entity/course_entity.dart';
import '../../domain/repository/course_repository.dart';
import '../data_source/course_remote_data_source.dart';

final courseRemoteRepoProvider = Provider<ICourseRepository>((ref) {
  return CourseRemoteRepositoryImpl(
    courseRemoteDataSource: ref.read(courseRemoteDataSourceProvider),
  );
});

class CourseRemoteRepositoryImpl implements ICourseRepository {
  final CourseRemoteDataSource courseRemoteDataSource;

  CourseRemoteRepositoryImpl({required this.courseRemoteDataSource});

  @override
  Future<Either<Failure, bool>> addCourse(CourseEntity course) {
    return courseRemoteDataSource.addCourse(course);
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getAllCourses() {
    return courseRemoteDataSource.getAllCourses();
  }
}
