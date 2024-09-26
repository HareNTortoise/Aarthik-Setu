class GSTDetails {
  String gstNumber;
  String gstUsername;
  String city;
  bool verified;
  DateTime? updateOn;
  double? totalPurchase;
  double? totalSales;
  DateTime? gstSince;

  GSTDetails({
    required this.gstNumber,
    required this.gstUsername,
    required this.city,
    required this.verified,
    this.updateOn,
    this.totalPurchase,
    this.totalSales,
    this.gstSince,
  });

  factory GSTDetails.fromJson(Map<String, dynamic> json) {
    return GSTDetails(
        gstNumber: json['gstNumber'],
        gstUsername: json['gstUsername'],
        city: json['city'],
        verified: json['verified'],
        updateOn: DateTime.parse(json['updateOn']),
        totalPurchase: json['totalPurchase'],
        totalSales: json['totalSales'],
        gstSince: DateTime.parse(json['gstSince']));
  }

  Map<String, dynamic> toJson() {
    return {
      'gstNumber': gstNumber,
      'gstUsername': gstUsername,
      'city': city,
      'verified': verified,
      'updateOn': updateOn?.toIso8601String(),
      'totalPurchase': totalPurchase,
      'totalSales': totalSales,
      'gstSince': gstSince?.toIso8601String()
    };
  }
}
