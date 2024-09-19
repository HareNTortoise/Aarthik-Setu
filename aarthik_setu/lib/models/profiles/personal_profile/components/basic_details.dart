
class BasicDetails {
  String salutation;
  String firstName;
  String? middleName;
  String lastName;
  DateTime dob;
  String pan;
  String gender;
  String category;
  String mobile;
  String telephone;
  String emailPersonal;
  String fatherName;
  String educationQualification;
  double netWorth;
  String nationality;
  String dependent;
  String maritalStatus;

  BasicDetails({
    required this.salutation,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.dob,
    required this.pan,
    required this.gender,
    required this.category,
    required this.mobile,
    required this.telephone,
    required this.emailPersonal,
    required this.fatherName,
    required this.educationQualification,
    required this.netWorth,
    required this.nationality,
    required this.dependent,
    required this.maritalStatus,
  });
}
