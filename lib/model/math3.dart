import 'dart:convert';

List<MathBook3> mathBook3FromJson(String str) =>
// List<MathBook3>.from(elements)
    List<MathBook3>.from(json.decode(str).map((x) => MathBook3.fromJson(x)));

String mathBook3ToJson(List<MathBook3> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MathBook3 {
  MathBook3({
    this.id,
    this.name,
    this.category,
    this.pageFilePath,
    this.createdAt,
    this.updatedAt,
  });

  final String? id;
  final String? name;
  final Category? category;
  final String? pageFilePath;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory MathBook3.fromJson(Map<String, dynamic> json) => MathBook3(
        id: json["id"],
        name: json["name"],
        category: categoryValues.map![json["category"]],
        pageFilePath: json["page_file_path"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": categoryValues.reverse[category],
        "page_file_path": pageFilePath,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

enum Category {
  MATHS3_EM_CHAP_01,
  MATHS3_EM_CHAP_02,
  MATHS3_EM_CHAP_03,
  MATHS3_EM_CHAP_04,
  MATHS3_EM_CHAP_05,
  MATHS3_EM_CHAP_06,
  MATHS3_EM_CHAP_07,
  MATHS3_EM_CHAP_08,
  MATHS3_EM_CHAP_09,
  MATHS3_EM_CHAP_10
}

final categoryValues = EnumValues({
  "Maths3_EM/chap_01/": Category.MATHS3_EM_CHAP_01,
  "Maths3_EM/chap_02/": Category.MATHS3_EM_CHAP_02,
  "Maths3_EM/chap_03/": Category.MATHS3_EM_CHAP_03,
  "Maths3_EM/chap_04/": Category.MATHS3_EM_CHAP_04,
  "Maths3_EM/chap_05/": Category.MATHS3_EM_CHAP_05,
  "Maths3_EM/chap_06/": Category.MATHS3_EM_CHAP_06,
  "Maths3_EM/chap_07/": Category.MATHS3_EM_CHAP_07,
  "Maths3_EM/chap_08/": Category.MATHS3_EM_CHAP_08,
  "Maths3_EM/chap_09/": Category.MATHS3_EM_CHAP_09,
  "Maths3_EM/chap_10/": Category.MATHS3_EM_CHAP_10
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
