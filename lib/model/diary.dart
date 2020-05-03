class Diary
{
  String diaryId;
  String userId;
  String title;
  String details;
  String createdAt;
  String attachmentUrl;
  
  Diary(this.diaryId, this.userId, this.title, this.details, this.createdAt,[this.attachmentUrl]);

  factory Diary.fromJson(json)
  {
    return Diary
    (
      json['diaryId'] as String,
      json['userId'] as String,
      json['title'] as String,
      json['details'] as String,
      json['createdAt'] as String,
      json['attachmentUrl'] as String
    );
  }

  factory Diary.forHttpRequest(String title, String details)
  {
    return Diary
      (
        '',
        '',
        title,
        details,
        '',
        ''
    );
  }

  Map<String, dynamic> toJson()
  {
    return {
      'title':this.title,
      'details':this.details,
    };
  }
}