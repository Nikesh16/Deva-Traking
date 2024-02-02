import 'dart:convert';

class MemberMetaModel {
  bool? success;
  String? message;
  List<MemberList>? members;

  MemberMetaModel({
    this.success,
    this.message,
    this.members,
  });

  factory MemberMetaModel.fromJson(String str) =>
      MemberMetaModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MemberMetaModel.fromMap(Map<String, dynamic> json) => MemberMetaModel(
        success: json["success"],
        message: json["message"],
        members: json["data"] == null
            ? []
            : List<MemberList>.from(
                json["data"]!.map((x) => MemberList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": members == null
            ? []
            : List<dynamic>.from(members!.map((x) => x.toMap())),
      };
}

class MemberList {
  int? id;
  String? name;
  String? email;
  String? photo;
  dynamic emailVerifiedAt;
  String? position;
  String? type;

  MemberList({
    this.id,
    this.name,
    this.email,
    this.photo,
    this.emailVerifiedAt,
    this.position,
    this.type,
  });

  factory MemberList.fromJson(String str) =>
      MemberList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MemberList.fromMap(Map<String, dynamic> json) => MemberList(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        photo: json["photo"],
        emailVerifiedAt: json["email_verified_at"],
        position: json["position"],
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "photo": photo,
        "email_verified_at": emailVerifiedAt,
        "position": position,
        "type": type,
      };
}
