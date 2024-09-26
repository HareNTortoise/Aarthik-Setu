class FinancialYear {
  int startYear;
  int endYear;

  FinancialYear({required this.startYear, required this.endYear}) {
    if (endYear - startYear != 1) {
      throw Exception("Financial year difference must be 1");
    }
  }
}

class FileItrPersonal {
  String? id;
  String profileId;
  DateTime timestamp;
  String applicationId;
  final MapEntry<FinancialYear, String> firstItr;
  final MapEntry<FinancialYear, String> secondItr;
  final MapEntry<FinancialYear, String> thirdItr;

  FileItrPersonal({
    required this.profileId,
    required this.timestamp,
    required this.applicationId,
    this.id,
    required this.firstItr,
    required this.secondItr,
    required this.thirdItr,
  });

  Map<String, dynamic> toJson() {
    return {
      'profileId': profileId,
      'timestamp': timestamp,
      'applicationId': applicationId,
      'id': id,
      'firstItr': {
        'startYear': firstItr.key.startYear,
        'endYear': firstItr.key.endYear,
        'file': firstItr.value,
      },
      'secondItr': {
        'startYear': secondItr.key.startYear,
        'endYear': secondItr.key.endYear,
        'file': secondItr.value,
      },
      'thirdItr': {
        'startYear': thirdItr.key.startYear,
        'endYear': thirdItr.key.endYear,
        'file': thirdItr.value,
      },
    };
  }

  factory FileItrPersonal.fromJson(Map<String, dynamic> json) {
    return FileItrPersonal(
      profileId: json['profileId'],
      timestamp: json['timestamp'],
      applicationId: json['applicationId'],
      id: json['id'],
      firstItr: MapEntry(
        FinancialYear(
          startYear: json['firstItr']['startYear'],
          endYear: json['firstItr']['endYear'],
        ),
        json['firstItr']['file'],
      ),
      secondItr: MapEntry(
        FinancialYear(
          startYear: json['secondItr']['startYear'],
          endYear: json['secondItr']['endYear'],
        ),
        json['secondItr']['file'],
      ),
      thirdItr: MapEntry(
        FinancialYear(
          startYear: json['thirdItr']['startYear'],
          endYear: json['thirdItr']['endYear'],
        ),
        json['thirdItr']['file'],
      ),
    );
  }
}
