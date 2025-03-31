class BusRouteModel {
  final String id;
  final CreatedBy createdBy;
  final String name;
  final String from;
  final String to;
  final int busFare;
  final int seatsAvailable;
  final String busType;
  final List<Hostel> hostels;
  final DateTime date;
  final DateTime createdAt;

  BusRouteModel({
    required this.id,
    required this.createdBy,
    required this.name,
    required this.from,
    required this.to,
    required this.busFare,
    required this.seatsAvailable,
    required this.busType,
    required this.hostels,
    required this.date,
    required this.createdAt,
  });

  factory BusRouteModel.fromJson(Map<String, dynamic> json) {
    return BusRouteModel(
      id: json['_id'],
      createdBy: CreatedBy.fromJson(json['createdBy']),
      name: json['name'],
      from: json['from'],
      to: json['to'],
      busFare: json['busFare'],
      seatsAvailable: json['seatsAvailable'],
      busType: json['busType'],
      hostels: (json['hostels'] as List).map((hostel) => Hostel.fromJson(hostel)).toList(),
      date: DateTime.parse(json['date']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'createdBy': createdBy.toJson(),
      'name': name,
      'from': from,
      'to': to,
      'busFare': busFare,
      'seatsAvailable': seatsAvailable,
      'busType': busType,
      'hostels': hostels.map((hostel) => hostel.toJson()).toList(),
      'date': date.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class CreatedBy {
  final String id;
  final String email;
  final String fullName;

  CreatedBy({required this.id, required this.email, required this.fullName});

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['_id'],
      email: json['email'],
      fullName: json['fullName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'fullName': fullName,
    };
  }
}

class Hostel {
  final String id;
  final String name;

  Hostel({required this.id, required this.name});

  factory Hostel.fromJson(Map<String, dynamic> json) {
    return Hostel(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}
