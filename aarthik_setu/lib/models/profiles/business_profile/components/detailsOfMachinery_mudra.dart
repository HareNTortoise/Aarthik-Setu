class DetailsOfMachinery {
  String typeOfMachinery;
  String purposeForRequirement;
  String nameOfSupplier;
  double costOfMachinery;

  DetailsOfMachinery({
    required this.typeOfMachinery,
    required this.purposeForRequirement,
    required this.nameOfSupplier,
    required this.costOfMachinery,
  });

  factory DetailsOfMachinery.fromJson(Map<String, dynamic> json) {
    return DetailsOfMachinery(
      typeOfMachinery: json['typeOfMachinery'],
      purposeForRequirement: json['purposeForRequirement'],
      nameOfSupplier: json['nameOfSupplier'],
      costOfMachinery: json['costOfMachinery'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'typeOfMachinery': typeOfMachinery,
      'purposeForRequirement': purposeForRequirement,
      'nameOfSupplier': nameOfSupplier,
      'costOfMachinery': costOfMachinery,
    };
  }
}