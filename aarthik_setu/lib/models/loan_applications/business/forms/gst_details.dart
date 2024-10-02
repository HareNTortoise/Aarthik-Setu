class GSTDetails {
  String? id;
  String profileId;
  DateTime timestamp;
  String applicationId;

  String gstNumber;
  String gstUsername;
  String city;
  bool verified;
  DateTime? updateOn;
  double? totalPurchase;
  double? totalSales;
  DateTime? gstSince;

  GSTDetails({
    this.id,
    required this.profileId,
    required this.timestamp,
    required this.applicationId,

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
        id: json['_id'],
        profileId: json['profileId'],
        timestamp: DateTime.parse(json['timestamp']),
        applicationId: json['applicationId'],
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
      'id': id,
      'profileId': profileId,
      'timestamp': timestamp.toIso8601String(),
      'applicationId': applicationId,
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
