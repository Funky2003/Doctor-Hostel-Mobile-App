import 'package:room_booking/core/api/supabase.api.dart';
import 'package:supabase/supabase.dart';

class ReferenceService {
  Future<PostgrestResponse> getAllReference() async {
    PostgrestResponse response = await SupabaseAPI.supabaseClient
        .from("booking_status")
        .select()
        .execute();
    print(response.data.toString());
    return response;
  }

  Future<PostgrestResponse> insertReference({required int roomID, required String refID }) async {
    PostgrestResponse response = await SupabaseAPI.supabaseClient
        .from("booking_status")
        .insert({
            'created_at': DateTime.timestamp().toString(),
            'room_id': roomID,
            'reference_key': refID.toString()
        })
        .execute();
    print(response.data.toString());
    return response;
  }
}
