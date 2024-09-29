class ManualGST {
  String entityName;
  DateTime dateOfIncorporation;
  String constitution;
  String state;
  String city;
  String pan;
  int noOfCustomers;
  double? highestSaleToCustomerJanuary;
  double? highestSaleToCustomerFebruary;
  double? highestSaleToCustomerMarch;
  double? highestSaleToCustomerApril;
  double? highestSaleToCustomerMay;
  double? highestSaleToCustomerJune;
  double? highestSaleToCustomerJuly;
  double? highestSaleToCustomerAugust;
  double? highestSaleToCustomerSeptember;
  double? highestSaleToCustomerOctober;
  double? highestSaleToCustomerNovember;
  double? highestSaleToCustomerDecember;

  ManualGST({
    required this.entityName,
    required this.dateOfIncorporation,
    required this.constitution,
    required this.state,
    required this.city,
    required this.pan,
    required this.noOfCustomers,
    this.highestSaleToCustomerJanuary,
    this.highestSaleToCustomerFebruary,
    this.highestSaleToCustomerMarch,
    this.highestSaleToCustomerApril,
    this.highestSaleToCustomerMay,
    this.highestSaleToCustomerJune,
    this.highestSaleToCustomerJuly,
    this.highestSaleToCustomerAugust,
    this.highestSaleToCustomerSeptember,
    this.highestSaleToCustomerOctober,
    this.highestSaleToCustomerNovember,
    this.highestSaleToCustomerDecember,
  });

  factory ManualGST.fromJson(Map<String, dynamic> json) {
    return ManualGST(
      entityName: json['entityName'],
      dateOfIncorporation: DateTime.parse(json['dateOfIncorporation']),
      constitution: json['constitution'],
      state: json['state'],
      city: json['city'],
      pan: json['pan'],
      noOfCustomers: json['noOfCustomers'],
      highestSaleToCustomerJanuary: json['highestSaleToCustomerJanuary'],
      highestSaleToCustomerFebruary: json['highestSaleToCustomerFebruary'],
      highestSaleToCustomerMarch: json['highestSaleToCustomerMarch'],
      highestSaleToCustomerApril: json['highestSaleToCustomerApril'],
      highestSaleToCustomerMay: json['highestSaleToCustomerMay'],
      highestSaleToCustomerJune: json['highestSaleToCustomerJune'],
      highestSaleToCustomerJuly: json['highestSaleToCustomerJuly'],
      highestSaleToCustomerAugust: json['highestSaleToCustomerAugust'],
      highestSaleToCustomerSeptember: json['highestSaleToCustomerSeptember'],
      highestSaleToCustomerOctober: json['highestSaleToCustomerOctober'],
      highestSaleToCustomerNovember: json['highestSaleToCustomerNovember'],
      highestSaleToCustomerDecember: json['highestSaleToCustomerDecember'],
    );
  }
}
