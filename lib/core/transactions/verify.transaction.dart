import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../presentation/screens/payStack/api_key.dart';
import '../service/reference.service.dart';
import '../service/room.service.dart';

class Transactions {
  Future<bool> verifyTransaction() async {
    try {
      var references = await ReferenceService().getAllReference();
      var rooms = await RoomService().getAllRooms();

      // Initialize a list to keep track of successfully updated room IDs
      List<int> updatedRoomIDs = [];

      for (var referenceData in references.data) {
        var reference = referenceData['reference_key'];
        var room_id = referenceData['room_id'];

        // Find the corresponding room
        var roomData = rooms.data.firstWhere(
              (room) => room['room_id'] == room_id,
          orElse: () => null, // Return null if room not found
        );

        if (roomData != null) {
          var roomID = roomData['room_id'];

          final String url = 'https://api.paystack.co/transaction/verify/$reference';
          http.Response response = await http.get(
            Uri.parse(url),
            headers: {
              'Authorization': 'Bearer ${ApiKey.secretKey}',
              'Content-Type': 'application/json',
            },
          );
          var body = response.body;
          print('This is the response body: ${body.toString()}');

          if (response.statusCode == 200) {
            final responseData = jsonDecode(response.body);
            if (reference == responseData['data']['reference'] &&
                responseData['data']['status'] == "success") {
              // Update the room status
              var roomStatus = await RoomService().updateRoomStatus(status: false, roomID: room_id);
              print('Room status updated for room ID: $room_id');
              updatedRoomIDs.add(roomID); // Add successfully updated room ID to the list
            }
          }
        }
      }

      // Check if any room statuses were updated successfully
      if (updatedRoomIDs.isNotEmpty) {
        print('Successfully updated room IDs: $updatedRoomIDs');
        return true;
      } else {
        print('No room statuses were updated.');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}