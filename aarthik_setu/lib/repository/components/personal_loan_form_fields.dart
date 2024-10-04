import 'package:aarthik_setu/constants/form_constants.dart';

class FormField {
  final String name;
  final String type;
  final String? format;
  final List<String>? options;

  FormField({
    required this.name,
    required this.type,
    this.format,
    this.options,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'format': format,
      'options': options,
    };
  }
}

class BasicDetailsFormFields {
  static List<FormField> basicDetailsFields = [
    FormField(name: "salutation", type: "Dropdown", options: Salutations.getSalutations()),
    FormField(name: "firstName", type: "Text"),
    FormField(name: "middleName", type: "Text"),
    FormField(name: "lastName", type: "Text"),
    FormField(name: "dateOfBirth", type: "Date"),
    FormField(name: "panNumber", type: "Text"),
    FormField(name: "gender", type: "Dropdown", options: Genders.getGenders()),
    FormField(name: "category", type: "Dropdown", options: Categories.getCategories()),
    FormField(name: "mobileNumber", type: "Text"),
    FormField(name: "email", type: "Text"),
    FormField(name: "fathersName", type: "Text"),
    FormField(
        name: "educationQualification",
        type: "Dropdown",
        options: EducationQualifications.getEducationQualifications()),
    FormField(name: "netWorth", type: "Text"),
    FormField(name: "nationality", type: "Dropdown", options: Nationalities.getNationalities()),
    FormField(name: "dependents", type: "Dropdown", options: Dependents.getDependents()),
    FormField(name: "maritalStatus", type: "Dropdown", options: MaritalStatus.getMaritalStatuses()),
  ];

  static List<Map<String, dynamic>> toJson() {
    return basicDetailsFields.map((field) => field.toJson()).toList();
  }
}

class ContactDetailsFormFields {
  static List<FormField> contactDetailsFields = [
    FormField(name: "Selected Month", type: "text", options: List.generate(12, (index) => (index + 1).toString())),
    FormField(name: "Selected Year", type: "text"),
    FormField(name: "Address Line 1", type: "Text"),
    FormField(name: "Address Line 2", type: "Text"),
    FormField(name: "Landmark", type: "Text"),
    FormField(name: "Country", type: "Dropdown", options: ["India", "Other"]),
    FormField(name: "State", type: "Dropdown", options: ["State 1", "State 2"]),
    FormField(name: "City", type: "Dropdown", options: ["City 1", "City 2"]),
    FormField(name: "Pin Code", type: "Text"),
    FormField(name: "Village", type: "Text"),
    FormField(name: "District", type: "Text"),
    FormField(name: "Sub-District", type: "Text"),
  ];

  static List<Map<String, dynamic>> toJson() {
    return contactDetailsFields.map((field) => field.toJson()).toList();
  }
}
