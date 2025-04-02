class BusResponseParams {
  final bool willTravelByBus;
  final String? destinationCity;
  final String? relation;

  BusResponseParams({required this.willTravelByBus, required this.destinationCity, required this.relation});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'willTravelByBus': willTravelByBus,
      if (destinationCity != null) 'destinationCity': destinationCity,
      if (relation != null) 'relation': relation,
    };
  }
}
