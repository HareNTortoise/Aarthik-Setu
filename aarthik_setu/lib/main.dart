import 'package:aarthik_setu/bloc/auth/auth_bloc.dart';
import 'package:aarthik_setu/constants/colors.dart';
import 'package:aarthik_setu/routes/router.dart';
import 'package:aarthik_setu/services/auth/google.dart';
import 'package:aarthik_setu/services/auth/phone.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'constants/app_constants.dart';
import 'firebase_options.dart';

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
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
                googleAuthServices: RepositoryProvider.of<GoogleAuth>(context),
                phoneAuthServices: RepositoryProvider.of<PhoneAuth>(context)),
          ),
        ],
        child: MaterialApp.router(
          title: AppConstants.appName,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColorTwo),
            useMaterial3: true,
          ),
          routerConfig: router,
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
