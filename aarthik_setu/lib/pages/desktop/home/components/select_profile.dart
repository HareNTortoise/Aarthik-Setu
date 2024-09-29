import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../constants/app_constants.dart';

class SelectProfile extends StatelessWidget {
  const SelectProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: AppConstants.desktopScaleWidth,
      child: Dialog(
        child: SizedBox(
          width: 500,
          height: 500,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text('Select Profile', style: TextStyle(fontSize: 32)),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),
                Text('You have no profiles.', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: 100,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () => context.pop(),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                        backgroundColor: MaterialStateProperty.all(Colors.redAccent[100]),
                        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20, color: Colors.white)),
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
                      ),
                      child: Text('Close', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
