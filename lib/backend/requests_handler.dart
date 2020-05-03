import 'dart:io';

import '../model/diary.dart';
import '../model/diary_request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestHandler
{
  Map<String, String> headers;
  RequestHandler(String idToken)
  {
    headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $idToken'};
  }

  Future<List<Diary>> getAllDiaries() async
  {
    String url = 'https://sz4o3myrbe.execute-api.us-east-1.amazonaws.com/dev/diary';
    http.Response response = await http.get(url, headers: this.headers);
    final int code = response.statusCode;
    if (code== 200)
    {
      String body = response.body;
      var parsed = json.decode(body);
      var items = parsed['items'];
      List<Diary> diaries = List<Diary>();
      items.forEach((item)=>diaries.add(Diary.fromJson(item)));
      return diaries;
    }
    throw Exception('Failed to load diaries');
  }

  Future<Diary> createDiary(DiaryRequest request) async
  {
    String url = 'https://sz4o3myrbe.execute-api.us-east-1.amazonaws.com/dev/diary';

    http.Response response = await http.post(url, headers: this.headers, body: utf8.encode(json.encode(request.toJson())));

    final int code = response.statusCode;
    print('code : $code');
    if (code == 201)
    {
      String body = response.body;
      var parsed = json.decode(body);
      return Diary.fromJson(parsed['item']);
    }
    throw Exception('Failed to create diary');
  }

  Future updateDiary(String diaryId, DiaryRequest request) async
  {
    String url = 'https://sz4o3myrbe.execute-api.us-east-1.amazonaws.com/dev/diary/$diaryId';

    http.Response response = await http.patch(url, headers: this.headers, body: utf8.encode(json.encode(request.toJson())));

    final int code = response.statusCode;
    print('code : $code');
    if (code != 200)
    {
      throw Exception('Failed to update diary');
    }
  }


  Future deleteDiary(String diaryId) async
  {
    String url = 'https://sz4o3myrbe.execute-api.us-east-1.amazonaws.com/dev/diary/$diaryId';

    http.Response response = await http.delete(url, headers: this.headers);

    final int code = response.statusCode;
    print('code : $code');
    if (code != 200)
    {
      throw Exception('Failed to delete diary');
    }
  }

  Future<String> getUploadAttachmentUrl(String diaryId) async
  {
    String url = 'https://sz4o3myrbe.execute-api.us-east-1.amazonaws.com/dev/diary/$diaryId/attachment';
    http.Response response = await http.post(url, headers: this.headers);

    if (response.statusCode == 200)
    {
      String body = response.body;
      var parsed = json.decode(body);
      return parsed['uploadUrl'];
    }
    throw Exception('Failed to get attachment url');
  }

  Future uploadAttachment(File attachment, String uploadUrl) async
  {
    var attachmentBytes = attachment.readAsBytesSync();
    http.Response response = await http.put(uploadUrl, body: attachmentBytes);
    if (response.statusCode != 200)
    {
      throw Exception('Failed to upload attachment diary');
    }
  }
}