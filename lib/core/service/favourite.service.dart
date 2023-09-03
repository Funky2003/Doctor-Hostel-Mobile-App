import 'package:room_booking/core/api/supabase.api.dart';
import 'package:supabase/supabase.dart';

class FavoriteService {
  Future<PostgrestResponse> getAllFavourite({required int userId}) async {
    PostgrestResponse response = await SupabaseAPI.supabaseClient
      .from("favourites")
      .select("rooms(*), favourite_id, user_id")
      .eq('user_id', userId)
      .execute();
    print(response.data);
    print(response.error);
    return response;
  }



  Future<PostgrestResponse> addToFavourite({required int userId, required int room_id}) async {
    PostgrestResponse response = await SupabaseAPI.supabaseClient.from("favourites").insert({
      "user_id": userId,
      "room_id": room_id,
    }).execute();
    return response;
  }

  Future<PostgrestResponse> deleteFromFavourite({required int favouriteId}) async {
    PostgrestResponse response = await SupabaseAPI.supabaseClient
        .from("favourites")
        .delete()
        .eq("favourite_id", favouriteId)
        .execute();
    return response;
  }
}
