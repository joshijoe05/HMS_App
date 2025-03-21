class HostelEntity {
  final String id;
  final String name;
  final List<String> wings;
  final int totalRooms;
  final List<String> caretakerIds;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  HostelEntity({
    required this.id,
    required this.name,
    required this.wings,
    required this.totalRooms,
    required this.caretakerIds,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create a Hostel object from JSON
  factory HostelEntity.fromJson(Map<String, dynamic> json) {
    return HostelEntity(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      wings: List<String>.from(json["wings"] ?? []),
      totalRooms: json["totalRooms"] ?? 0,
      caretakerIds: List<String>.from(json["caretakerIds"] ?? []),
      createdBy: json["createdBy"] ?? "",
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "wings": wings,
      "totalRooms": totalRooms,
      "caretakerIds": caretakerIds,
      "createdBy": createdBy,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }
}
