import 'package:aarthik_setu/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class GovernmentSchemesFinder extends StatefulWidget {
  const GovernmentSchemesFinder({super.key});

  @override
  State<GovernmentSchemesFinder> createState() => _GovernmentSchemesFinderState();
}

class _GovernmentSchemesFinderState extends State<GovernmentSchemesFinder> {
  bool _isUsingGenAI = false;
  bool _isTransitioning = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: _isUsingGenAI ? 1000 : 800,
            height: _isUsingGenAI ? 275 : 60,
            onEnd: () {
              setState(() {
                _isTransitioning = false;
              });
            },
            child: _isUsingGenAI
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Container(
                      padding: _isTransitioning ? null : const EdgeInsets.only(left: 20, right: 20, top: 40),
                      child: Column(
                        children: [
                          TextField(
                            maxLines: _isTransitioning ? 1 : 5,
                            decoration: InputDecoration(
                              hintText: _isTransitioning ? null : 'Search for government schemes using generative AI',
                              hintStyle: GoogleFonts.poppins(fontSize: 20, color: Colors.grey),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(left: 20),
                            ),
                            style: GoogleFonts.poppins(fontSize: 20),
                          ),
                          if (!_isTransitioning)
                            Column(
                              children: [
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _isUsingGenAI = false;
                                            _isTransitioning = true;
                                          });
                                        },
                                        icon: const Icon(Icons.arrow_back_ios_new_outlined),
                                        style: ButtonStyle(
                                          padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
                                          backgroundColor: WidgetStateProperty.all(AppColors.primaryColorTwo.withOpacity(0.5)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    SizedBox(
                                      height: 50,
                                      child: FilledButton.tonal(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          padding: WidgetStateProperty.all(
                                              const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                                          backgroundColor:
                                              WidgetStateProperty.all(AppColors.primaryColorOne.withOpacity(0.8)),
                                        ),
                                        child: Text(
                                          'Search',
                                          style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  )
                : SearchBar(
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
                              _isTransitioning = true;
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
    );
  }
}
