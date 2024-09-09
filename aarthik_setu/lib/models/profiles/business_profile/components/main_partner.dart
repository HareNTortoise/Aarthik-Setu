

class MainPartner {
  String name;
  bool owningAHouse;
  bool assessedForIncomeTax;
  bool haveALifeInsurancePolicy;
  String maritalStatus;
  String spouseName;
  String spouseDetails;
  int noOfChildren;
  String category;

  MainPartner({
    required this.name,
    required this.owningAHouse,
    required this.assessedForIncomeTax,
    required this.haveALifeInsurancePolicy,
    required this.maritalStatus,
    required this.spouseName,
    required this.spouseDetails,
    required this.noOfChildren,
    required this.category,
  });

  factory MainPartner.fromJson(Map<String, dynamic> json) {
    return MainPartner(
      name: json['name'],
      owningAHouse: json['owningAHouse'],
      assessedForIncomeTax: json['assessedForIncomeTax'],
      haveALifeInsurancePolicy: json['haveALifeInsurancePolicy'],
      maritalStatus: json['maritalStatus'],
      spouseName: json['spouseName'],
      spouseDetails: json['spouseDetails'],
      noOfChildren: json['noOfChildren'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'owningAHouse': owningAHouse,
      'assessedForIncomeTax': assessedForIncomeTax,
      'haveALifeInsurancePolicy': haveALifeInsurancePolicy,
      'maritalStatus': maritalStatus,
      'spouseName': spouseName,
      'spouseDetails': spouseDetails,
      'noOfChildren': noOfChildren,
      'category': category,
    };
  }
}