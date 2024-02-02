import 'dart:convert';

MessageMetaModel messageMetaModelFromMap(String str) =>
    MessageMetaModel.fromMap(json.decode(str));

String messageMetaModelToMap(MessageMetaModel data) =>
    json.encode(data.toMap());

class MessageMetaModel {
  bool? success;
  String? message;
  List<Message>? data;

  MessageMetaModel({
    this.success,
    this.message,
    this.data,
  });

  factory MessageMetaModel.fromMap(Map<String, dynamic> json) =>
      MessageMetaModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Message>.from(json["data"]!.map((x) => Message.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Message {
  int? id;
  String? name;
  String? message;
  String? userPhoto;
  String? messageImage;

  DateTime? createdAt;
  String? messagePosition;

  Message({
    this.id,
    this.name,
    this.message,
    this.userPhoto,
    this.messageImage,
    this.createdAt,
    this.messagePosition,
  });

  factory Message.fromMap(Map<String, dynamic> json) => Message(
        id: json["id"],
        name: json["name"],
        message: json["message"],
        userPhoto: json["user_photo"],
        messageImage: json["message_image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        messagePosition: json["message_position"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "message": message,
        "photo": userPhoto,
        "message_image": messageImage,
        "created_at": createdAt?.toIso8601String(),
        "message_position": messagePosition,
      };
}
