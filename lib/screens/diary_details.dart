import 'package:flutter/material.dart';

// TODO: for view/update{title/details} and view attachment image only
class DiaryDetails extends StatefulWidget {
  String diaryId;
  DiaryDetails(this.diaryId);
  @override
  _DiaryDetailsState createState() => _DiaryDetailsState();
}

class _DiaryDetailsState extends State<DiaryDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.diaryId),
    );
  }
}
