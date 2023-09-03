import 'dart:convert';
import 'package:room_booking/core/models/room.model.dart';

List<BookingModel> bookingModelFromJson(String str) => List<BookingModel>.from(json.decode(str).map((x) => BookingModel.fromJson(x)));
String bookingModelToJson(List<BookingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingModel {
  BookingModel({
    required this.bookingPrice,
    required this.bookingDate,
    required this.bookingReference,
    required this.rooms,
  });

  int bookingPrice;
  String bookingDate;
  String bookingReference;
  RoomModel? rooms;

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        bookingPrice: json["booking_price"],
        bookingDate: json["booking_date"],
        bookingReference: json["booking_reference"],
        rooms: RoomModel.fromJson(json["rooms"]),
  );

  Map<String, dynamic> toJson() => {
        "booking_price": bookingPrice,
        "booking_date": bookingDate,
        "booking_reference": bookingReference,
        "rooms": rooms?.toJson(),
  };
}
