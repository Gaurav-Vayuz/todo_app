class ChatModel {
  final int? id;
  final String message;
  final String time;

  ChatModel({this.id, required this.message, required this.time});

  ChatModel.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        message = res["message"],
        time = res["time"];

  Map<String, Object?> toMap() {
    return {'id': id, 'message': message, 'time': time};
  }
}

class TodoModel {
  final int? id;
  final String title;
  final String desc;
  final String date;

  TodoModel(
    this.id,
    this.title,
    this.desc,
    this.date,
  );
}
