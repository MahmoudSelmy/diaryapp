class MemoryRequest
{
  String title;
  String details;
  String attachmentUrl;

  MemoryRequest(this.title, this.details, this.attachmentUrl);

  Map<String, dynamic> toJson()
  {
    return {
      'title':this.title,
      'details':this.details,
      'attachmentUrl':this.attachmentUrl
    };
  }
}