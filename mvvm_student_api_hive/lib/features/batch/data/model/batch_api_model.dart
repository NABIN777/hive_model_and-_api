import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/batch_entity.dart';

part 'batch_api_model.g.dart';

final batchApiModelProvider = Provider(
  (ref) => BatchApiModel.empty(),
);

@JsonSerializable()
class BatchApiModel {
  @JsonKey(name: '_id')
  final String? batchId;
  final String batchName;

  BatchApiModel({
    required this.batchId,
    required this.batchName,
  });

  BatchApiModel.empty()
      : this(
          batchId: '',
          batchName: '',
        );

  // Convert API Object to Entity
  BatchEntity toEntity() => BatchEntity(
        batchId: batchId,
        batchName: batchName,
      );

  // Convert Entity to API Object
  BatchApiModel toHiveModel(BatchEntity entity) => BatchApiModel(
        batchId: entity.batchId,
        batchName: entity.batchName,
      );

  // Convert API List to Entity List
  List<BatchEntity> toEntityList(List<BatchApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  //To JSON

  Map<String, dynamic> toJson() => _$BatchApiModelToJson(this);

  //From JSON

  factory BatchApiModel.fromJson(Map<String, dynamic> json) =>
      _$BatchApiModelFromJson(json);

  @override
  String toString() {
    return 'batchId: $batchId, batchName: $batchName';
  }
}
