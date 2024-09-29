import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:google_fonts/google_fonts.dart';

class MonthPickerButton extends StatefulWidget {
  final DateTime? current;
  final String label;
  final Function(DateTime) onMonthSelected;

  const MonthPickerButton({
    super.key,
    this.current,
    required this.label,
    required this.onMonthSelected,
  });

  @override
  MonthPickerButtonState createState() => MonthPickerButtonState();
}

class MonthPickerButtonState extends State<MonthPickerButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.poppins(fontSize: 18),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: 300,
          height: 60,
          child: FilledButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      width: 600,
                      height: 600,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SfDateRangePicker(
                        onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                          widget.onMonthSelected(args.value);
                        },
                        selectionTextStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        allowViewNavigation: false,
                        view: DateRangePickerView.year,
                        showNavigationArrow: false,
                        navigationMode: DateRangePickerNavigationMode.none,
                      ),
                    ),
                  );
                },
              );
            },
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              backgroundColor: WidgetStateProperty.all(
                Colors.blue.withOpacity(0.5),
              ),
            ),
            child: widget.current != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.calendar_month, size: 30, color: Colors.black),
                      const SizedBox(width: 10),
                      Text(
                        "${widget.current!.month}",
                        style: GoogleFonts.poppins(fontSize: 20, color: Colors.black),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.calendar_month, size: 30, color: Colors.black),
                      const SizedBox(width: 10),
                      Text(
                        "Month",
                        style: GoogleFonts.poppins(fontSize: 20, color: Colors.black),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
