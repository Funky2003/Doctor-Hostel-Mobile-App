import 'package:room_booking/core/api/supabase.api.dart';
import 'package:room_booking/core/models/booking.model.dart';
import 'package:supabase/supabase.dart';

class BookingService {
  Future<PostgrestResponse> getBookingData({required int userId}) async {
    PostgrestResponse response = await SupabaseAPI.supabaseClient
        .from("bookings")
        .select("booking_reference,booking_price,booking_date,rooms(*)")
        .eq("user_id", userId)
        .execute();
    return response;
  }

  Future<PostgrestResponse> insertBooking({
    required int roomID,
    required int userID,
    required int bookingPrice,
    required String reference,
  }) async {
    PostgrestResponse response = await SupabaseAPI.supabaseClient
        .from("bookings")
        .insert({
          "room_id": roomID,
          "user_id": userID,
          "booking_price": bookingPrice,
          "booking_reference": reference,
          "booking_date": DateTime.now().toString(),
        }).execute();
    print('The response: ${response.data}');
    return response;
  }

  Future<PostgrestResponse?> confirmBooking({
    required BookingModel bookingModel,
    required int userId,
    required int roomId,
  }) async {
    try {
      PostgrestResponse? response = await SupabaseAPI.supabaseClient.from("bookings").insert({
        "room_id": roomId,
        "user_id": userId,
        "booking_price": bookingModel.bookingPrice,
        "booking_reference": bookingModel.bookingReference,
        "booking_date": bookingModel.bookingDate,
      }).execute();
      return response;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
