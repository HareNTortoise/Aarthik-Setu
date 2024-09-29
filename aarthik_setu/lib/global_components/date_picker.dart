import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class DatePickerButton extends StatefulWidget {
  final DateTime? current;
  final String label;
  final Function(DateTime) onDateSelected;

  const DatePickerButton({
    super.key,
    this.current,
    required this.label,
    required this.onDateSelected,
  });

  @override
  DatePickerButtonState createState() => DatePickerButtonState();
}

class DatePickerButtonState extends State<DatePickerButton> {
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
              List<DateTime?>? results = await showCalendarDatePicker2Dialog(
                context: context,
                config: CalendarDatePicker2WithActionButtonsConfig(),
                dialogSize: const Size(525, 400),
                value: [DateTime.now()],
                borderRadius: BorderRadius.circular(15),
              );
              if (results != null && results[0] != null) {
                widget.onDateSelected(results[0]!); // Notify parent of the selected date
              }
            },
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                        "${widget.current!.day}/${widget.current!.month}/${widget.current!.year}",
                        style: GoogleFonts.poppins(fontSize: 20, color: Colors.black),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.calendar_month, size: 30, color: Colors.black),
                      const SizedBox(width: 10),
                      AutoSizeText(
                        widget.label,
                        style: GoogleFonts.poppins(color: Colors.black),
                        maxFontSize: 20,
                        minFontSize: 18,
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
