import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class GovernmentSchemesFinder extends StatefulWidget {
  const GovernmentSchemesFinder({super.key});

  @override
  State<GovernmentSchemesFinder> createState() => _GovernmentSchemesFinderState();
}

class _GovernmentSchemesFinderState extends State<GovernmentSchemesFinder> {
  bool _isUsingGenAI = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 800,
              height: 60,
              child: SearchBar(
                textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 20)),
                leading: const Icon(Icons.search),
                padding: WidgetStateProperty.all(const EdgeInsets.only(left: 20)),
                backgroundColor: WidgetStateProperty.all(Colors.white),
                trailing: [
                  if (!_isUsingGenAI)
                    RawMaterialButton(
                      onPressed: () {
                        setState(() {
                          _isUsingGenAI = true;
                        });
                      },
                      fillColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                      child: SvgPicture.asset(
                        "lib/assets/gemini.svg",
                        width: 25,
                      ),
                    )
                  else
                    RawMaterialButton(
                      onPressed: () {},
                      fillColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                      child: SvgPicture.asset(
                        "lib/assets/google.svg",
                        width: 25,
                      ),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
