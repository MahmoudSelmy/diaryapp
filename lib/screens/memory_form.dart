import 'dart:io';

import 'package:diary_app/backend/requests_handler.dart';
import 'package:diary_app/model/memory.dart';
import 'package:diary_app/model/memory_request.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class MemoryForm extends StatefulWidget
{
  Memory memory;
  String tokenId;
  MemoryForm(this.tokenId, [this.memory]);
  bool isCreateMode;
  @override
  _MemoryFormState createState()
  {
    isCreateMode = false;
    if(memory == null)
    {
      isCreateMode = true;
    }
    return _MemoryFormState();
  }
}

class _MemoryFormState extends State<MemoryForm>
{
  String imagePickerLabel = "Add Image";
  bool isUploading = false;
  File image;
  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: buildTitle(),),
      body: isUploading? CircularProgressIndicator() : ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: buildTextField('Title', titleController),
                flex: 1,
              ),
              Expanded(
                child: buildTextField('Details', detailsController),
                flex: 7,
              ),
              RaisedButton.icon(
                label:  Text(imagePickerLabel,
                  style: TextStyle(color: Colors.white, fontSize: 20),),
                color: Colors.blue[900],
                textColor: Colors.white,
                icon: Icon(Icons.attach_file, color: Colors.white,),
                onPressed: selectImage,
              ),
              RaisedButton.icon(
                label: Text("Create Diary",
                  style: TextStyle(color: Colors.white, fontSize: 20),),
                color: Colors.blue[900],
                textColor: Colors.white,
                icon: Icon(Icons.book, color: Colors.white,),
                onPressed: createDiary,
              )
            ],
          ),
        ),
      ),
    );
  }

  Text buildTitle()
  {
    String title = 'Edit Event';
    if(widget.isCreateMode)
    {
      title = 'Create Event';
    }
    return Text(title);
  }

  TextField buildTextField(String hint, TextEditingController controller)
  {
    return TextField(
      expands: true,
      maxLines: null,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.top,
      controller: controller,
      decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.all(5.0),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 1, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(5.0))),
    );
  }

  void selectImage() async
  {
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(()
    {
      image = file;
      imagePickerLabel = path.basename(image.path).toString();
    });
  }

  void createDiary() async
  {
    if(image == null)
      return;

    setState(() {
      isUploading = true;
    });

    String title = titleController.text.toString();
    String details = detailsController.text.toString();
    String attachmentUrl = 'NULL';
    MemoryRequest request = MemoryRequest(title, details, attachmentUrl);
    RequestHandler handler = RequestHandler(widget.tokenId);
    Memory diary = await handler.createMemory(request);

    String url = await handler.getUploadAttachmentUrl(diary.memoryId);

    await handler.uploadAttachment(image, url);

    Navigator.pop(context);

  }
}
