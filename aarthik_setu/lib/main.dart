import 'package:aarthik_setu/bloc/auth/auth_bloc.dart';
import 'package:aarthik_setu/bloc/chatbot/chatbot_bloc.dart';
import 'package:aarthik_setu/constants/colors.dart';
import 'package:aarthik_setu/repository/business_profile.dart';
import 'package:aarthik_setu/repository/chatbot.dart';
import 'package:aarthik_setu/repository/form_filler.dart';
import 'package:aarthik_setu/repository/govt_schemes.dart';
import 'package:aarthik_setu/repository/personal_profile.dart';
import 'package:aarthik_setu/routes/router.dart';
import 'package:aarthik_setu/services/auth/google.dart';
import 'package:aarthik_setu/services/auth/phone.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'bloc/audio_filler/audio_filler_bloc.dart';
import 'bloc/home/home_bloc.dart';
import 'bloc/l10n/l10n_bloc.dart';
import 'constants/app_constants.dart';
import 'cubit/phone_form_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'firebase_options.dart';
import 'l10n/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AarthikSetu());
}

class AarthikSetu extends StatelessWidget {
  const AarthikSetu({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => GoogleAuth()),
        RepositoryProvider(create: (context) => PhoneAuth()),
        RepositoryProvider(create: (context) => PersonalProfileRepository()),
        RepositoryProvider(create: (context) => BusinessProfileRepository()),
        RepositoryProvider(create: (context) => GovernmentSchemesRepository()),
        RepositoryProvider(create: (context) => ChatBotRepository()),
        RepositoryProvider(create: (context) => FormFillerRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
                googleAuthServices: RepositoryProvider.of<GoogleAuth>(context),
                phoneAuthServices: RepositoryProvider.of<PhoneAuth>(context)),
          ),
          BlocProvider(create: (context) => PhoneFormCubit()),
          BlocProvider(create: (context) => L10nBloc()),
          BlocProvider(
            create: (context) => HomeBloc(
              personalProfileRepository: RepositoryProvider.of<PersonalProfileRepository>(context),
              businessProfileRepository: RepositoryProvider.of<BusinessProfileRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => AudioFillerBloc(),
          ),
          BlocProvider(
            create: (context) => ChatBotBloc(
              chatBotRepository: RepositoryProvider.of<ChatBotRepository>(context),
            ),
          ),
        ],
        child: MaterialApp.router(
          title: AppConstants.appName,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColorTwo),
            useMaterial3: true,
          ),
          routerConfig: router,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: L10nAll.all,
          builder: (context, child) => ResponsiveBreakpoints.builder(
            child: child!,
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            ],
          ),
        ),
      ),
    );
  }
}
