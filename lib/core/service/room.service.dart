import 'package:room_booking/core/api/supabase.api.dart';
import 'package:supabase/supabase.dart';

class RoomService {
  Future<PostgrestResponse> getAllRooms() async {
    PostgrestResponse response = await SupabaseAPI.supabaseClient.from("rooms").select().execute();
    return response;
  }

  // Testing...Testing...Testing...
  Future<PostgrestResponse> getAdminRoomsOnly({required int uID}) async {
    PostgrestResponse response = await SupabaseAPI.supabaseClient
        .from("rooms")
        .select()
        .filter("admin", "eq", uID)
        .execute();
    // print(response.data.toString());
    return response;
  }

  Future<PostgrestResponse> getSpecificRoom({required int roomId}) async {
    PostgrestResponse response = await SupabaseAPI.supabaseClient
        .from("rooms")
        .select()
        .eq("room_id", roomId)
        .execute();
    return response;
  }

  Future<PostgrestResponse> getAdminRoom({required var uID}) async {
    PostgrestResponse response = await SupabaseAPI.supabaseClient
        .from("rooms")
        .select()
        .eq("admin", uID)
        .execute();
    return response;
  }

  Future<PostgrestResponse> updateRoomStatus({required bool status, required int roomID}) async {
    PostgrestResponse response = await SupabaseAPI.supabaseClient
        .from("rooms")
        .update({"room_status": status})
        .eq("room_id", roomID)
        .execute();
    if (response.error != null) {
    print('Error updating boolean value: ${response.error!.message}');
    } else {
    print('Boolean value updated successfully');
    }
    return response;
  }

  Future<PostgrestResponse> getSearchRooms({required String roomName}) async {
    PostgrestResponse response = await SupabaseAPI.supabaseClient
        .from("rooms")
        .select()
        .filter('room_name', 'ilike', '%$roomName%')
        .execute();
    // .textSearch('room_name', roomName)
    return response;
  }
}
