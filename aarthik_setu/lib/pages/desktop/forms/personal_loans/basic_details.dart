import 'package:aarthik_setu/bloc/audio_filler/audio_filler_bloc.dart';
import 'package:aarthik_setu/constants/form_constants.dart';
import 'package:aarthik_setu/global_components/back_button.dart';
import 'package:aarthik_setu/global_components/custom_dropdown.dart';
import 'package:aarthik_setu/repository/components/personal_loan_form_fields.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../bloc/l10n/l10n_bloc.dart';
import '../../../../constants/app_constants.dart';
import '../../../../constants/colors.dart';
import '../../../../global_components/audio_recorder.dart';
import '../../../../global_components/labelled_text_field.dart';
import '../../../../global_components/language_dropdown.dart';
import '../../../../global_components/procees_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../repository/form_filler.dart';

class BasicDetailsForm extends StatefulWidget {
  const BasicDetailsForm({super.key});

  @override
  State<BasicDetailsForm> createState() => _BasicDetailsFormState();
}

class _BasicDetailsFormState extends State<BasicDetailsForm> {
  int currentYear = DateTime.now().year;

  String? _salutation;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();
  DateTime? _dateOfBirth;
  final TextEditingController _panController = TextEditingController();
  String? _gender;

  String? _category;
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailPersonalController = TextEditingController();

  final TextEditingController _fatherNameController = TextEditingController();
  String? _educationQualification;
  final TextEditingController _netWorthController = TextEditingController();

  String? _nationality;
  String? _dependents;
  String? _maritalStatus;

  bool _audioProcessing = false;

  @override
  Widget build(BuildContext context) {
    context.read<AudioFillerBloc>().add(InitializeAudioFiller());
    return ResponsiveScaledBox(
      width: AppConstants.desktopScaleWidth,
      child: Localizations.override(
        context: context,
        locale: (context.watch<L10nBloc>().state as L10n).locale,
        child: BlocBuilder<L10nBloc, L10nState>(
          builder: (context, state) {
            return Scaffold(
              floatingActionButton: Container(
                margin: const EdgeInsets.only(bottom: 20, right: 20),
                child: _audioProcessing
                    ? Container(
                        width: 70,
                        height: 70,
                        child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          onPressed: () {},
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )
                    : AudioRecordingWidget(
                        onSubmitAudio: (audioFile) async {
                          final formFillerRepository = RepositoryProvider.of<FormFillerRepository>(context);
                          setState(() {
                            _audioProcessing = true;
                          });
                          final response = await formFillerRepository.fillForm(
                            audioFile,
                            BasicDetailsFormFields.toJson(),
                          );
                          setState(() {
                            _audioProcessing = false;
                          });
                          if (context.mounted) {
                            context.read<AudioFillerBloc>().add(ResetAudioFiller());
                          }
                          if (response['firstName'] != null) {
                            _firstNameController.clear();
                            for (int i = 0; i < response['firstName'].length; i++) {
                              await Future.delayed(Duration(milliseconds: 50), () {
                                _firstNameController.text += response['firstName'][i];
                              });
                            }
                          }
                          if (response['middleName'] != null) {
                            _middleNameController.clear();
                            for (int i = 0; i < response['middleName'].length; i++) {
                              await Future.delayed(Duration(milliseconds: 50), () {
                                _middleNameController.text += response['middleName'][i];
                              });
                            }
                          }
                          if (response['lastName'] != null) {
                            _lastNameController.clear();
                            for (int i = 0; i < response['lastName'].length; i++) {
                              await Future.delayed(Duration(milliseconds: 50), () {
                                _lastNameController.text += response['lastName'][i];
                              });
                            }
                          }
                          if (response['email'] != null) {
                            _emailPersonalController.clear();
                            for (int i = 0; i < response['email'].length; i++) {
                              await Future.delayed(Duration(milliseconds: 50), () {
                                _emailPersonalController.text += response['email'][i];
                              });
                            }
                          }
                          if (response['panNumber'] != null) {
                            _panController.clear();
                            for (int i = 0; i < response['panNumber'].length; i++) {
                              await Future.delayed(Duration(milliseconds: 50), () {
                                _panController.text += response['panNumber'][i];
                              });
                            }
                          }
                          if (response['mobileNumber'] != null) {
                            _mobileController.clear();
                            for (int i = 0; i < response['mobileNumber'].length; i++) {
                              await Future.delayed(Duration(milliseconds: 50), () {
                                _mobileController.text += response['mobileNumber'][i];
                              });
                            }
                          }
                          if (response['fatherName'] != null) {
                            _fatherNameController.clear();
                            for (int i = 0; i < response['fatherName'].length; i++) {
                              await Future.delayed(Duration(milliseconds: 50), () {
                                _fatherNameController.text += response['fatherName'][i];
                              });
                            }
                          }
                          if (response['netWorth'] != null) {
                            _netWorthController.clear();
                            for (int i = 0; i < response['netWorth'].length; i++) {
                              await Future.delayed(Duration(milliseconds: 50), () {
                                _netWorthController.text += response['netWorth'][i];
                              });
                            }
                          }
                          if (response['dateOfBirth'] != null) {
                            setState(() {
                              _dateOfBirth = DateTime.parse(response['dateOfBirth']);
                            });
                          }
                          if (response['salutation'] != null) {
                            setState(() {
                              _salutation = response['salutation'];
                            });
                          }
                          if (response['gender'] != null) {
                            setState(() {
                              _gender = response['gender'];
                            });
                          }
                          if (response['category'] != null) {
                            setState(() {
                              _category = response['category'];
                            });
                          }
                          if (response['educationQualification'] != null) {
                            setState(() {
                              _educationQualification = response['educationQualification'];
                            });
                          }
                          if (response['nationality'] != null) {
                            setState(() {
                              _nationality = response['nationality'];
                            });
                          }
                          if (response['dependents'] != null) {
                            setState(() {
                              _dependents = response['dependents'];
                            });
                          }
                          if (response['maritalStatus'] != null) {
                            setState(() {
                              _maritalStatus = response['maritalStatus'];
                            });
                          }
                        },
                      ),
              ),
              body: SizedBox.expand(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      const LanguageDropdown(),
                      const SizedBox(height: 60),
                      Text(
                        AppLocalizations.of(context)!.basicDetails,
                        style: GoogleFonts.poppins(fontSize: 80),
                      ),
                      const SizedBox(width: 20),
                      const SizedBox(height: 40),
                      IntrinsicHeight(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          margin: const EdgeInsets.only(bottom: 100),
                          width: 1200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 7,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Form(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomDropdown(
                                          label: AppLocalizations.of(context)!.salutation,
                                          buttonLabel: _salutation ?? AppLocalizations.of(context)!.selectSalutation,
                                          items: Salutations.getSalutations(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              _salutation = value;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        LabelledTextField(
                                          label: AppLocalizations.of(context)!.firstName,
                                          hintText: AppLocalizations.of(context)!.firstNameHint,
                                          controller: _firstNameController,
                                        ),
                                        LabelledTextField(
                                          label: AppLocalizations.of(context)!.middleName,
                                          hintText: AppLocalizations.of(context)!.middleNameHint,
                                          controller: _middleNameController,
                                        ),
                                        LabelledTextField(
                                          label: AppLocalizations.of(context)!.lastName,
                                          hintText: AppLocalizations.of(context)!.lastNameHint,
                                          controller: _lastNameController,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!.dateOfBirth,
                                              style: GoogleFonts.poppins(fontSize: 18),
                                            ),
                                            const SizedBox(height: 5),
                                            SizedBox(
                                              width: 300,
                                              height: 60,
                                              child: FilledButton(
                                                onPressed: () async {
                                                  List<DateTime?>? results = await showCalendarDatePicker2Dialog(
                                                    context: context,
                                                    config: CalendarDatePicker2WithActionButtonsConfig(),
                                                    dialogSize: const Size(525, 400),
                                                    value: [DateTime.now()],
                                                    borderRadius: BorderRadius.circular(15),
                                                  );
                                                  if (results != null) {
                                                    setState(() {
                                                      _dateOfBirth = results[0];
                                                    });
                                                  }
                                                },
                                                style: ButtonStyle(
                                                  shape: WidgetStateProperty.all(
                                                    RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                  ),
                                                  backgroundColor: WidgetStateProperty.all(
                                                      AppColors.primaryColorTwo.withOpacity(0.5)),
                                                ),
                                                child: _dateOfBirth != null
                                                    ? Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          const Icon(Icons.calendar_month,
                                                              size: 30, color: Colors.black),
                                                          const SizedBox(width: 10),
                                                          Text(
                                                            "${_dateOfBirth!.day}/${_dateOfBirth!.month}/${_dateOfBirth!.year}",
                                                            style:
                                                                GoogleFonts.poppins(fontSize: 20, color: Colors.black),
                                                          ),
                                                        ],
                                                      )
                                                    : Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          const Icon(Icons.calendar_month,
                                                              size: 30, color: Colors.black),
                                                          const SizedBox(width: 10),
                                                          Text(
                                                            AppLocalizations.of(context)!.selectDateOfBirth,
                                                            style:
                                                                GoogleFonts.poppins(fontSize: 20, color: Colors.black),
                                                          ),
                                                        ],
                                                      ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        LabelledTextField(
                                          label: AppLocalizations.of(context)!.panNumber,
                                          hintText: AppLocalizations.of(context)!.panNumberHint,
                                          controller: _panController,
                                        ),
                                        CustomDropdown(
                                            label: AppLocalizations.of(context)!.gender,
                                            buttonLabel: _gender ?? AppLocalizations.of(context)!.selectGender,
                                            items: Genders.getGenders(),
                                            onChanged: (String? value) {
                                              setState(() {
                                                _gender = value;
                                              });
                                            })
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomDropdown(
                                          label: AppLocalizations.of(context)!.category,
                                          buttonLabel: _category ?? AppLocalizations.of(context)!.selectCategory,
                                          items: Categories.getCategories(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              _category = value;
                                            });
                                          },
                                        ),
                                        LabelledTextField(
                                          label: AppLocalizations.of(context)!.mobileNumber,
                                          hintText: AppLocalizations.of(context)!.mobileNumberHint,
                                          controller: _mobileController,
                                        ),
                                        LabelledTextField(
                                          label: AppLocalizations.of(context)!.email,
                                          hintText: AppLocalizations.of(context)!.emailHint,
                                          controller: _emailPersonalController,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        LabelledTextField(
                                          label: AppLocalizations.of(context)!.fatherName,
                                          hintText: AppLocalizations.of(context)!.enterFatherName,
                                          controller: _fatherNameController,
                                        ),
                                        CustomDropdown(
                                          label: AppLocalizations.of(context)!.educationQualification,
                                          buttonLabel: _educationQualification ??
                                              AppLocalizations.of(context)!.selectEducationQualification,
                                          items: EducationQualifications.getEducationQualifications(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              _educationQualification = value;
                                            });
                                          },
                                        ),
                                        LabelledTextField(
                                          label: AppLocalizations.of(context)!.netWorth,
                                          hintText: AppLocalizations.of(context)!.enterNetWorth,
                                          controller: _netWorthController,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomDropdown(
                                            label: AppLocalizations.of(context)!.nationality,
                                            buttonLabel:
                                                _nationality ?? AppLocalizations.of(context)!.selectNationality,
                                            items: Nationalities.getNationalities(),
                                            onChanged: (String? value) {
                                              setState(() {
                                                _nationality = value;
                                              });
                                            }),
                                        CustomDropdown(
                                          label: AppLocalizations.of(context)!.dependents,
                                          buttonLabel: _dependents ?? AppLocalizations.of(context)!.selectDependents,
                                          items: Dependents.getDependents(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              _dependents = value;
                                            });
                                          },
                                        ),
                                        CustomDropdown(
                                          label: AppLocalizations.of(context)!.maritalStatus,
                                          buttonLabel:
                                              _maritalStatus ?? AppLocalizations.of(context)!.selectMaritalStatus,
                                          items: MaritalStatus.getMaritalStatuses(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              _maritalStatus = value;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Divider(color: Colors.grey, thickness: 0.5),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  BackButtonCustom(onPressed: () => context.pop()),
                                  const SizedBox(width: 40),
                                  ProceedButtonCustom(onPressed: () {}),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
