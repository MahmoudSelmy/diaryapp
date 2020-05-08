import 'package:diary_app/backend/requests_handler.dart';
import 'package:diary_app/model/memory.dart';
import 'package:flutter/material.dart';

// TODO: for view/update{title/details} and view attachment image only
class MemoryDetails extends StatefulWidget {
  Memory memory;
  String tokenId;
  MemoryDetails(this.memory, this.tokenId);
  @override
  _MemoryDetailsState createState() => _MemoryDetailsState();
}

class _MemoryDetailsState extends State<MemoryDetails>
{
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details'),),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.delete, color: Colors.white,),
        onPressed: deleteDiary,
      ),
      body :isLoading? Center(child: CircularProgressIndicator(),): Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Text(widget.memory.title, style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold, fontSize: 30),textDirection: TextDirection.ltr),
                Container(
                  height: 300,
                  child: buildImage(),
                ),
                Text(widget.memory.details, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w100, fontSize: 20),textDirection: TextDirection.ltr,),
              ],
            ),
          )
        ],
      ),
    );
  }

  Image buildImage()
  {
    if(widget.memory.attachmentUrl == null)
    {
      return Image.asset('images/noattachment.png', fit: BoxFit.fill,);
    }
    return Image.network(widget.memory.attachmentUrl, fit: BoxFit.fill,);
  }

  void deleteDiary() async
  {
    setState(() {
      isLoading = true;
    });
    RequestHandler handler = RequestHandler(widget.tokenId);
    await handler.deleteMemory(widget.memory.memoryId);
    Navigator.pop(context);
  }
}
