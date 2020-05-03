class DiaryRequest
{
  String title;
  String details;
  String attachmentUrl;

  DiaryRequest(this.title, this.details, this.attachmentUrl);

  Map<String, dynamic> toJson()
  {
    return {
      'title':this.title,
      'details':this.details,
      'attachmentUrl':this.attachmentUrl
    };
  }
}