import 'dart:convert';

List<ReferenceModel> referenceModelFromJson(String str) => List<ReferenceModel>.from(json.decode(str).map((x) => ReferenceModel.fromJson(x)));

String referenceModelToJson(List<ReferenceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReferenceModel {

  ReferenceModel({
    required this.id,
    required this.roomID,
    required this.createdAt,
    required this.referenceKey,
  });

  int id;
  int roomID;
  String createdAt;
  String referenceKey;

  factory ReferenceModel.fromJson(Map<String, dynamic> json) => ReferenceModel(
    id: json["id"],
    createdAt: json["createdAt"],
    roomID: json['room_id'],
    referenceKey: json['reference_key']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt,
    "room_id": roomID,
    "reference_key": referenceKey
  };
}