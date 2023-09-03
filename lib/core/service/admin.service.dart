import 'package:room_booking/core/api/supabase.api.dart';
import 'package:supabase/supabase.dart';

class AdminService {
  Future<PostgrestResponse> getAllAdmin() async {
    PostgrestResponse response = await SupabaseAPI.supabaseClient.from("admin").select().execute();
    return response;
  }
}
