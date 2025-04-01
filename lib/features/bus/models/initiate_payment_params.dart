class InitiatePaymentParams {
  final String busId;
  final String passengerName;
  final String passengerEmail;
  final String passengerPhone;

  InitiatePaymentParams({
    required this.busId,
    required this.passengerName,
    required this.passengerEmail,
    required this.passengerPhone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'busId': busId,
      'passengerName': passengerName,
      'passengerEmail': passengerEmail,
      'passengerPhone': passengerPhone,
    };
  }

  factory InitiatePaymentParams.fromMap(Map<String, dynamic> map) {
    return InitiatePaymentParams(
      busId: map['busId'] as String,
      passengerName: map['passengerName'] as String,
      passengerEmail: map['passengerEmail'] as String,
      passengerPhone: map['passengerPhone'] as String,
    );
  }
}
