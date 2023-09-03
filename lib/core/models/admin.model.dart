import 'dart:convert';

List<AdminModel> adminModelFromJson(String str) => List<AdminModel>.from(json.decode(str).map((x) => AdminModel.fromJson(x)));

String adminModelToJson(List<AdminModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminModel {

  AdminModel({
    required this.adminId,
    required this.createdAt,
    required this.fullName,
    required this.email,
    required this.mobileNumber,
    required this.password,
    required this.uID,
    required this.hostelName,
    required this.hostelLocation,
    required this.hostelThumbnail
  });

  String adminId;
  String createdAt;
  String fullName;
  String email;
  String mobileNumber;
  String password;
  String uID;
  String hostelName;
  String hostelLocation;
  String hostelThumbnail;

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
      adminId: json["id"],
      createdAt: json["createdAt"],
      fullName: json["full_name"],
      email: json["email"],
      mobileNumber: json["mobile_number"],
      password: json["password"],
      uID: json["uID"],
      hostelName: json["hostel_name"],
      hostelLocation: json["hostel_location"],
      hostelThumbnail: json["hostel_thumbnail"]
  );

  Map<String, dynamic> toJson() => {
    "id": adminId,
    "created_at": createdAt,
    "full_name": fullName,
    "email": email,
    "mobileNumber": mobileNumber,
    "password": password,
    "uID": uID,
    "hostel_name": hostelName,
    "hostel_location": hostelLocation,
    "hostel_thumbnail": hostelThumbnail
  };
}