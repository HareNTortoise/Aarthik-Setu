class ManualGST{
  String entityName;
  DateTime dateOfIncorporation;
  String constitution;
  String state;
  String city;
  String pan;
  int noOfCustomers;
  double highestSaleToOneCustomer;
  Map<(int,int), double> salesInLast12Months;

  ManualGST({
    required this.entityName,
    required this.dateOfIncorporation,
    required this.constitution,
    required this.state,
    required this.city,
    required this.pan,
    required this.noOfCustomers,
    required this.highestSaleToOneCustomer,
    required this.salesInLast12Months,
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
        highestSaleToOneCustomer: json['highestSaleToOneCustomer'],
        salesInLast12Months: json['salesInLast12Months']);
  }

  Map<String, dynamic> toJson() {
    return {
      'entityName': entityName,
      'dateOfIncorporation': dateOfIncorporation.toIso8601String(),
      'constitution': constitution,
      'state': state,
      'city': city,
      'pan': pan,
      'noOfCustomers': noOfCustomers,
      'highestSaleToOneCustomer': highestSaleToOneCustomer,
      'salesInLast12Months': salesInLast12Months
    };
  }
}