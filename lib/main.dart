import 'package:diary_app/model/memory.dart';
import 'package:diary_app/screens/memory_form.dart';
import 'package:flutter/material.dart';
import 'backend/requests_handler.dart';
import 'model/memory_request.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'screens/log_in.dart';

String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL3NlbG15OTYuYXV0aDAuY29tLyIsInN1YiI6Imdvb2dsZS1vYXV0aDJ8MTAwMDEzOTQ0NTEzMjE5NTYwODY1IiwiYXVkIjoieDdPNTZ1MldTTzdWZTJYS2tLbXBVdWtmd05wb2xLb2IiLCJpYXQiOjE1ODg1MTMwNTksImV4cCI6MTU4ODg3MzA1OH0.kD3q2eBBBpEq6QNnmYwTPLVwVMhvKWMelyiqU1a0Tfo';
loadAllDiaries(String idToken) async
{
  RequestHandler handler = RequestHandler(idToken);
  List<Memory> diaries = await handler.getAllMemories();
  print('**************************************');
  print(diaries.length);
  print(diaries[0].title);
}

Future<Memory> createDiary(String idToken) async
{
  print('>>>>>>>> start');
  MemoryRequest req = MemoryRequest('First from flutter', 'create memory from flutter is done', 'NULL');
  RequestHandler handler = RequestHandler(idToken);
  Memory memory = await handler.createMemory(req);
  print(memory.createdAt);
  print(memory.memoryId);

  return memory;
}

updateDiary(String idToken) async
{
  print('>>>>>>>> start');
  MemoryRequest req = MemoryRequest('First update from flutter', 'create diary from flutter is done', '');
  RequestHandler handler = RequestHandler(idToken);
  await handler.updateMemory('2d3ccafc-80a1-4c12-8154-966fd05e3cc8', req);
}

deleteDiary(String idToken) async
{
  print('>>>>>>>> start');
  RequestHandler handler = RequestHandler(idToken);
  await handler.deleteMemory('2d3ccafc-80a1-4c12-8154-966fd05e3cc8');
}

getUploadUrl(String idToken) async
{
  print('>>>>>>>> start');
  RequestHandler handler = RequestHandler(idToken);
  String url = await handler.getUploadAttachmentUrl('e0b4df5c-6037-4254-82be-146d6fee0c8a');
  print(url);
}

uploadImage(String idToken) async
{
  print('>>>>>>>> start');
  RequestHandler handler = RequestHandler(idToken);
  String url = await handler.getUploadAttachmentUrl('e0b4df5c-6037-4254-82be-146d6fee0c8a');
  print(url);

  File file = await ImagePicker.pickImage(source: ImageSource.gallery);

  await handler.uploadAttachment(file, url);
}

void main()
{
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogIn()
  ));
}
///x,ncx,lhnklxchkxknn




