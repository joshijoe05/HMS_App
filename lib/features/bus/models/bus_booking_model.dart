class BusBookingModel {
  final String id;
  final String userId;
  final BusModel bus;
  final String transactionId;
  final String status;
  final int amount;
  final String passengerName;
  final String passengerEmail;
  final String passengerPhone;
  final DateTime createdAt;

  BusBookingModel({
    required this.id,
    required this.userId,
    required this.bus,
    required this.transactionId,
    required this.status,
    required this.amount,
    required this.passengerName,
    required this.passengerEmail,
    required this.passengerPhone,
    required this.createdAt,
  });

  factory BusBookingModel.fromMap(Map<String, dynamic> map) {
    return BusBookingModel(
      id: map['_id'] as String,
      userId: map['userId'] as String,
      bus: BusModel.fromMap(map['busId']),
      transactionId: map['transactionId'] as String,
      status: map['status'] as String,
      amount: map['amount'] as int,
      passengerName: map['passengerName'] as String,
      passengerEmail: map['passengerEmail'] as String,
      passengerPhone: map['passengerPhone'] as String,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'userId': userId,
      'busId': bus.toMap(),
      'transactionId': transactionId,
      'status': status,
      'amount': amount,
      'passengerName': passengerName,
      'passengerEmail': passengerEmail,
      'passengerPhone': passengerPhone,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class BusModel {
  final String id;
  final String name;
  final String from;
  final String to;
  final String busType;
  final DateTime date;

  BusModel({
    required this.id,
    required this.name,
    required this.from,
    required this.to,
    required this.busType,
    required this.date,
  });

  factory BusModel.fromMap(Map<String, dynamic> map) {
    return BusModel(
      id: map['_id'] as String,
      name: map['name'] as String,
      from: map['from'] as String,
      to: map['to'] as String,
      busType: map['busType'] as String,
      date: DateTime.parse(map['date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'from': from,
      'to': to,
      'busType': busType,
      'date': date.toIso8601String(),
    };
  }
}
