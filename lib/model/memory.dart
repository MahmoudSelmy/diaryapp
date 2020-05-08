class Memory
{
  String memoryId;
  String userId;
  String title;
  String details;
  String createdAt;
  String attachmentUrl;
  
  Memory(this.memoryId, this.userId, this.title, this.details, this.createdAt,[this.attachmentUrl]);

  factory Memory.fromJson(json)
  {
    return Memory
    (
      json['memoryId'] as String,
      json['userId'] as String,
      json['title'] as String,
      json['details'] as String,
      json['createdAt'] as String,
      json['attachmentUrl'] as String
    );
  }

  factory Memory.forHttpRequest(String title, String details)
  {
    return Memory
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