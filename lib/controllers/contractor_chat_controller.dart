import 'dart:convert';
import 'package:flutter_project_labour_app/models/room.dart';
import 'package:flutter_project_labour_app/models/room_message.dart';
import 'package:flutter_project_labour_app/util/endpoints.dart';
import 'package:flutter_project_labour_app/util/storage_access.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ContractorChatController extends GetxController {
  var allRooms = <Room>[].obs;
  var roomMessage = <RoomMessage>[].obs;
  var isMessageLoading = false.obs;
  var isChatLoading = false.obs;

  Future<bool> getRooms() async {
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    var response = await http.get(
      Uri.parse(Endpoints.contractorGetRooms),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode < 299) {
      var body = jsonDecode(response.body);
      if (body['data'] != null) {
        var jobs = body['data'] as List;
        allRooms.clear();
        allRooms.addAll(jobs.map((e) => Room.fromJson(e)));
      }
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getMessages(int roomId) async {
    isMessageLoading(true);
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    var response = await http.get(
      Uri.parse('${Endpoints.contractorGetMessages}?room_id=$roomId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    isMessageLoading(false);
    if (response.statusCode < 299) {
      var body = jsonDecode(response.body);
      if (body['data'] != null) {
        var jobs = body['data'] as List;
        roomMessage.clear();
        roomMessage.addAll(jobs.map((e) => RoomMessage.fromJson(e)));
      }
      return true;
    } else {
      return false;
    }
  }

  Future<Room?> createChatRoom(int labourId, String type) async {
    isChatLoading(true);
    var token = await StorageAccess.getToken();
    if (token == null) {
      isChatLoading(false);
      return null;
    }
    var response = await http.post(
      Uri.parse('${Endpoints.contractorGetRooms}?joiner_id=$labourId&joiner_type=$type'),
      headers: {'Authorization': 'Bearer $token'},
    );
    isChatLoading(false);
    if (response.statusCode < 299) {
      var body = jsonDecode(response.body);
      if (body['data'] != null) {
        var room = Room.fromJson(body['data']);
        getRooms();
        return room;
      }
      return null;
    } else {
      return null;
    }
  }
}
