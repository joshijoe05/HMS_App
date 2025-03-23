class ComplaintModel {
  final String id;
  final String hostelId;
  final String type;
  final String description;
  final String status;
  final String raisedBy;
  final String priority;
  final List<String> images;
  final DateTime createdAt;
  final DateTime updatedAt;

  ComplaintModel({
    required this.id,
    required this.hostelId,
    required this.type,
    required this.description,
    required this.status,
    required this.raisedBy,
    required this.priority,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['_id'],
      hostelId: json['hostel_id'],
      type: json['type'],
      description: json['description'],
      status: json['status'],
      raisedBy: json['raised_by'],
      priority: json['priority'],
      images: List<String>.from(json['images'] ?? []),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'hostel_id': hostelId,
      'type': type,
      'description': description,
      'status': status,
      'raised_by': raisedBy,
      'priority': priority,
      'images': images,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
