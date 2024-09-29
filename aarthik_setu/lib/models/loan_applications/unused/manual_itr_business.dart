class ManualItrBusiness{
  String entityName;
  String constitution;
  String state;
  String city;
  String pan;
  int numberOfCustomers;
  double highestSalesToOneCustomer;
  Map<(String, int), double> monthlySalesAmount;

  ManualItrBusiness({
    required this.entityName,
    required this.constitution,
    required this.state,
    required this.city,
    required this.pan,
    required this.numberOfCustomers,
    required this.highestSalesToOneCustomer,
    required this.monthlySalesAmount,
  });

  Map<String, dynamic> toJson() {
    return {
      'entityName': entityName,
      'constitution': constitution,
      'State': state,
      'city': city,
      'pan': pan,
      'numberOfCustomers': numberOfCustomers,
      'highestSalesToOneCustomer': highestSalesToOneCustomer,
      'monthlySalesAmount': monthlySalesAmount,
    };
  }

  factory ManualItrBusiness.fromJson(Map<String, dynamic> json) {
    return ManualItrBusiness(
      entityName: json['entityName'],
      constitution: json['constitution'],
      state: json['State'],
      city: json['city'],
      pan: json['pan'],
      numberOfCustomers: json['numberOfCustomers'],
      highestSalesToOneCustomer: json['highestSalesToOneCustomer'],
      monthlySalesAmount: json['monthlySalesAmount'],
    );
  }
}