import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../../constants/colors.dart';
import '../../../../../global_components/labelled_text_field.dart';



class EnterGSTCredentials extends StatefulWidget {
  const EnterGSTCredentials({super.key});

  @override
  State<EnterGSTCredentials> createState() => _EnterGSTCredentialsState();
}

class _EnterGSTCredentialsState extends State<EnterGSTCredentials> {
  
  List<String> businesses = [];
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const SizedBox(height: 20),
        // const Text(
        //   "Upload Bank Statement (PDF)",
        //   style: TextStyle(fontSize: 24),
        // ),
        const SizedBox(height: 20),
        Row(
          children: [
            for (var i in businesses)
              Container(
                margin: const EdgeInsets.only(right: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  i,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            SizedBox(
              width: 250,
              height: 100,
              child: FilledButton.tonal(
                onPressed: () {
                  setState(() {
                    //  _formOpened = true;
                  });
                },
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(const EdgeInsets.all(20)),
                  shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                  backgroundColor:
                  WidgetStateProperty.all(AppColors.primaryColorOne.withOpacity(0.6)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add, color: Colors.black, size: 30),
                    const SizedBox(width: 10),
                    Text("Add Business", style: GoogleFonts.poppins(fontSize: 22)),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Divider(color: Colors.grey, thickness: 0.5),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            LabelledTextField(
              label: "GST Number*",
              hintText: "Enter GST Number",
              controller: TextEditingController(),
            ),
            LabelledTextField(
              label: "GST Username*",
              hintText: "Enter GST Username",
              controller: TextEditingController(),
            ),
          ],
        ),
        const SizedBox(height: 40),
        Divider(color: Colors.grey, thickness: 0.5),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 200,
              height: 50,
              child: FilledButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: HexColor("#568737")),
                  )),
                ),
                child: Text(
                  "Back",
                  style: TextStyle(fontSize: 20, color: HexColor("#568737")),
                ),
              ),
            ),
            const SizedBox(width: 40),
            SizedBox(
              width: 200,
              height: 50,
              child: FilledButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(HexColor("#568737")),
                ),
                onPressed: () {},
                child: const Text(
                  "Proceed",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
