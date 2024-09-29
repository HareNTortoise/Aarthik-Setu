class BasicDetails {
  String? id;
  String profileId;
  DateTime timestamp;
  String applicationId;

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
  String? fatherName;
  String educationQualification;
  double netWorth;
  String nationality;
  String dependent;
  String maritalStatus;

  BasicDetails({
    required this.profileId,
    required this.timestamp,
    required this.applicationId,
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
    this.fatherName,
    required this.educationQualification,
    required this.netWorth,
    required this.nationality,
    required this.dependent,
    required this.maritalStatus,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'profileId': profileId,
      'timestamp': timestamp,
      'applicationId': applicationId,
      'salutation': salutation,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'dob': dob,
      'pan': pan,
      'gender': gender,
      'category': category,
      'mobile': mobile,
      'telephone': telephone,
      'emailPersonal': emailPersonal,
      'fatherName': fatherName,
      'educationQualification': educationQualification,
      'netWorth': netWorth,
      'nationality': nationality,
      'dependent': dependent,
      'maritalStatus': maritalStatus,
      'id': id,
    };
  }

  factory BasicDetails.fromJson(Map<String, dynamic> json) {
    return BasicDetails(
      profileId: json['profileId'],
      timestamp: json['timestamp'],
      applicationId: json['applicationId'],
      salutation: json['salutation'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      dob: json['dob'],
      pan: json['pan'],
      gender: json['gender'],
      category: json['category'],
      mobile: json['mobile'],
      telephone: json['telephone'],
      emailPersonal: json['emailPersonal'],
      fatherName: json['fatherName'],
      educationQualification: json['educationQualification'],
      netWorth: json['netWorth'],
      nationality: json['national'],
      dependent: json['dependent'],
      maritalStatus: json['maritalStatus'],
      id: json['id'],
    );
  }
}
