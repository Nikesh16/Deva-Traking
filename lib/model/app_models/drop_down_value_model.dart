import 'dart:convert';

DropDownValueModel dropDownValueModelFromJson(String str) =>
    DropDownValueModel.fromJson(json.decode(str));

String dropDownValueModelToJson(DropDownValueModel data) =>
    json.encode(data.toJson());

class DropDownValueModel {
  DropDownValueModel({
    required this.id,
    required this.value,
  });

  final String id;
  final String value;

  factory DropDownValueModel.fromJson(Map<String, dynamic> json) =>
      DropDownValueModel(
        id: json["id"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
      };
}
