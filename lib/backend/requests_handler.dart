import 'dart:io';

import '../model/memory.dart';
import '../model/memory_request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestHandler
{
  Map<String, String> headers;
  String apiId = "uufwd2u0uc";
  RequestHandler(String idToken)
  {
    headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $idToken'};
  }

  Future<List<Memory>> getAllMemories() async
  {
    String url = 'https://$apiId.execute-api.us-east-1.amazonaws.com/dev/memory';
    http.Response response = await http.get(url, headers: this.headers);
    final int code = response.statusCode;
    if (code== 200)
    {
      String body = response.body;
      var parsed = json.decode(body);
      var items = parsed['items'];
      List<Memory> memories = List<Memory>();
      items.forEach((item)=>memories.add(Memory.fromJson(item)));
      return memories;
    }
    throw Exception('Failed to load memories');
  }

  Future<Memory> createMemory(MemoryRequest request) async
  {
    String url = 'https://$apiId.execute-api.us-east-1.amazonaws.com/dev/memory';

    http.Response response = await http.post(url, headers: this.headers, body: utf8.encode(json.encode(request.toJson())));

    final int code = response.statusCode;
    print('code : $code');
    if (code == 201)
    {
      String body = response.body;
      var parsed = json.decode(body);
      return Memory.fromJson(parsed['item']);
    }
    throw Exception('Failed to create memory');
  }

  Future updateMemory(String memoryId, MemoryRequest request) async
  {
    String url = 'https://$apiId.execute-api.us-east-1.amazonaws.com/dev/memory/$memoryId';

    http.Response response = await http.patch(url, headers: this.headers, body: utf8.encode(json.encode(request.toJson())));

    final int code = response.statusCode;
    print('code : $code');
    if (code != 200)
    {
      throw Exception('Failed to update memory');
    }
  }


  Future deleteMemory(String memoryId) async
  {
    String url = 'https://$apiId.execute-api.us-east-1.amazonaws.com/dev/memory/$memoryId';

    http.Response response = await http.delete(url, headers: this.headers);

    final int code = response.statusCode;
    print('code : $code');
    if (code != 200)
    {
      throw Exception('Failed to delete memory');
    }
  }

  Future<String> getUploadAttachmentUrl(String memoryId) async
  {
    String url = 'https://$apiId.execute-api.us-east-1.amazonaws.com/dev/memory/$memoryId/attachment';
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
      throw Exception('Failed to upload attachment memory');
    }
  }
}