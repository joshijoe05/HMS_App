class ComplaintDetailModel {
  final String id;
  final String hostel;
  final String type;
  final String description;
  final String status;
  final String raisedBy;
  final String priority;
  final List<String> images;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<CommentModel> comments;

  ComplaintDetailModel({
    required this.id,
    required this.hostel,
    required this.type,
    required this.description,
    required this.status,
    required this.raisedBy,
    required this.priority,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
    required this.comments, // Required comments list
  });

  factory ComplaintDetailModel.fromJson(Map<String, dynamic> json) {
    return ComplaintDetailModel(
      id: json['_id'],
      hostel: json['hostel'],
      type: json['type'],
      description: json['description'],
      status: json['status'],
      raisedBy: json['raised_by'],
      priority: json['priority'],
      images: List<String>.from(json['images'] ?? []),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      comments: (json['comments'] as List?)?.map((e) => CommentModel.fromJson(e)).toList() ?? [], // Parse comments
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'hostel': hostel,
      'type': type,
      'description': description,
      'status': status,
      'raised_by': raisedBy,
      'priority': priority,
      'images': images,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'comments': comments.map((e) => e.toJson()).toList(), // Convert comments to JSON
    };
  }
}

class CommentModel {
  final String id;
  final String text;
  final DateTime createdAt;
  final String addedBy;

  CommentModel({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.addedBy,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['_id'],
      text: json['comment'],
      createdAt: DateTime.parse(json['createdAt']),
      addedBy: json['added_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'text': text,
      'createdAt': createdAt.toIso8601String(),
      'added_by': addedBy,
    };
  }
}
