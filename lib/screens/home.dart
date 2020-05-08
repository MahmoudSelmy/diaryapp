import 'package:diary_app/backend/requests_handler.dart';
import 'package:diary_app/main.dart';
import 'package:diary_app/model/memory.dart';
import 'package:diary_app/screens/memory_details.dart';
import 'package:flutter/material.dart';

import 'memory_form.dart';

class Home extends StatefulWidget {
  String _tokenId;
  Home(String tokenId)
  {
    _tokenId = tokenId;
  }
  @override
  _HomeState createState() => _HomeState(_tokenId);
}

class _HomeState extends State<Home>
{
  List<Memory> _diaries;
  int _count = 0;
  bool _loading = true;

  RequestHandler _handler;
  _HomeState(String tokenId)
  {
    _handler = RequestHandler(tokenId);
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Diary App"),),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        child: Icon(Icons.add, color: Colors.blue,),
        onPressed: createDiary,
      ),
      body: _loading? Center(child: CircularProgressIndicator(),) : getListItems(context),
    );
  }

  void getData() async
  {
    Future<List<Memory>> data = _handler.getAllMemories();
    data.then((value) => setData(value));

  }

  ListView getListItems(BuildContext context) {
    return ListView.builder(
      itemCount: _count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text(_diaries[position].title),
            subtitle: Text(_diaries[position].createdAt),
            onTap: () async {
              // debugPrint(_diaries[position].diaryId);
              await Navigator.push(context, MaterialPageRoute(builder: (context) => MemoryDetails(_diaries[position], widget._tokenId)));
              setState(()
              {
                _loading = true;
              });
              getData();
            },
          ),
        );
      },
    );
  }

  void setData(List<Memory> diaries)
  {
    setState(()
    {
      _diaries = diaries;
      _count = _diaries.length;
      _loading = false;
    });
  }

  void createDiary() async
  {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => MemoryForm(widget._tokenId)));
    setState(()
    {
      _loading = true;
    });
    getData();
  }
}
