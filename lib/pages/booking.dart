import 'package:flutter/material.dart';
import '../models/service.dart';
import 'confirmation.dart';

class BookingPage extends StatefulWidget {
  final Service service;
  final String location;

  const BookingPage({super.key, required this.service, required this.location});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  // Fungsi untuk memilih tanggal
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Fungsi untuk memilih waktu
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking - ${widget.service.name}"),
      ),
      body: 
        Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Service: ${widget.service.name}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Location: ${widget.location}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              "Price: \${widget.service.price.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text(selectedDate == null
                  ? 'Select Date'
                  : 'Selected Date: ${selectedDate!.toLocal()}'.split(' ')[0]),
            ),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text(selectedTime == null
                  ? 'Select Time'
                  : 'Selected Time: ${selectedTime!.format(context)}'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (selectedDate != null && selectedTime != null)
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmationPage(
                            service: widget.service,
                            location: widget.location, // Mengirim lokasi ke konfirmasi
                            date: selectedDate!,
                            time: selectedTime!,
                          ),
                        ),
                      );
                    }
                  : null,
              child: const Text('Confirm Booking'),
            ),
          ],
        ),
      ),
    );
  }
}
