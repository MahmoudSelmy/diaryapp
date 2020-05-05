import 'package:diary_app/backend/requests_handler.dart';
import 'package:diary_app/model/diary.dart';
import 'package:diary_app/screens/diary_details.dart';
import 'package:flutter/material.dart';

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
  List<Diary> _diaries;
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
      body: _loading? CircularProgressIndicator() : getListItems(context),
    );
  }

  void getData() async
  {
    Future<List<Diary>> data = _handler.getAllDiaries();
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
              await Navigator.push(context, MaterialPageRoute(builder: (context) => DiaryDetails(_diaries[position], widget._tokenId)));
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

  void setData(List<Diary> diaries)
  {
    setState(()
    {
      _diaries = diaries;
      _count = _diaries.length;
      _loading = false;
    });
  }
}
