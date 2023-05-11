class ItemModel {
  final int userId; //userId
  final int id;
  final String? title;
  final String? body;
  final bool like;

  ItemModel({
    required this.id,
    required this.userId,
    this.title,
    this.body,
    this.like = false,
  });

  factory ItemModel.fromJson(Map<dynamic, dynamic> json) {
    return ItemModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
      like: json['like'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
      'like': like,
    };
  }
}
