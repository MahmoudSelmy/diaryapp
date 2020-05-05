import 'package:diary_app/backend/requests_handler.dart';
import 'package:diary_app/model/diary.dart';
import 'package:flutter/material.dart';

// TODO: for view/update{title/details} and view attachment image only
class DiaryDetails extends StatefulWidget {
  Diary diary;
  String tokenId;
  DiaryDetails(this.diary, this.tokenId);
  @override
  _DiaryDetailsState createState() => _DiaryDetailsState();
}

class _DiaryDetailsState extends State<DiaryDetails>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.delete, color: Colors.white,),
        onPressed: deleteDiary,
      ),
      body :Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Text(widget.diary.title, style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold, fontSize: 30),textDirection: TextDirection.ltr),
                Container(
                  height: 300,
                  child: buildImage(),
                ),
                Text(widget.diary.details, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w100, fontSize: 20),textDirection: TextDirection.ltr,),
              ],
            ),
          )
        ],
      ),
    );
  }

  Image buildImage()
  {
    if(widget.diary.attachmentUrl == null)
    {
      return Image.asset('images/noattachment.png', fit: BoxFit.fill,);
    }
    return Image.network(widget.diary.attachmentUrl, fit: BoxFit.fill,);
  }

  void deleteDiary() async
  {
    RequestHandler handler = RequestHandler(widget.tokenId);
    await handler.deleteDiary(widget.diary.diaryId);
    Navigator.pop(context);
  }
}
