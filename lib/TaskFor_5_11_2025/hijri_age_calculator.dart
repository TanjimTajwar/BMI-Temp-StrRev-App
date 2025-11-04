import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HijriAgeCalculator extends StatefulWidget {
  const HijriAgeCalculator({super.key});

  @override
  State<HijriAgeCalculator> createState() => _HijriAgeCalculatorState();
}

class _HijriAgeCalculatorState extends State<HijriAgeCalculator> {
  DateTime? birthDate;
  String result = "";
  String hijriResult = "";
  String remainingLife = "";

  void pickBirthDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        birthDate = selectedDate;
      });
    }
  }

  void calculateAge() {
    if (birthDate == null) {
      setState(() {
        result = "⚠️ Please select your birth date first.";
        hijriResult = "";
        remainingLife = "";
      });
      return;
    }

    DateTime now = DateTime.now();
    Duration diff = now.difference(birthDate!);
    int totalDays = diff.inDays;

    // Gregorian age calculation
    int years = totalDays ~/ 365;
    int remainingDays = totalDays % 365;

    // Convert Gregorian years to Hijri
    // 1 Gregorian year ≈ 365 days, 1 Hijri year ≈ 354.36 days
    double totalHijriYears = totalDays / 354.36;
    int hijriYears = totalHijriYears.floor();
    int hijriRemainingDays = ((totalHijriYears - hijriYears) * 354.36).round();

    // Calculate remaining life (assuming 63 Hijri years)
    double hijriLeft = 63 - totalHijriYears;
    int leftYears = hijriLeft.floor();
    int leftDays = ((hijriLeft - leftYears) * 354.36).round();

    setState(() {
      result =
          "🗓 Gregorian Age: $years years and $remainingDays days (${totalDays} days total)";
      hijriResult =
          "🌙 Hijri Age: $hijriYears years and $hijriRemainingDays days";
      remainingLife =
          "💫 Remaining Life (Assumed 63 Hijri Years): $leftYears years and $leftDays days left";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Age in Hijri Calendar"),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 10,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.greenAccent, Colors.teal, Colors.lightGreen],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Card(
              color: Colors.white.withOpacity(0.95),
              elevation: 15,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "🕌 Age in Hijri Calendar 🕌",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton.icon(
                      onPressed: () => pickBirthDate(context),
                      icon: const Icon(
                        Icons.calendar_month,
                        color: Colors.white,
                      ),
                      label: Text(
                        birthDate == null
                            ? "Select Birth Date"
                            : "Birth Date: ${DateFormat('dd MMM yyyy').format(birthDate!)}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 8,
                      ),
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: calculateAge,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 8,
                      ),
                      child: const Text(
                        "Calculate Age",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    if (result.isNotEmpty)
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.lightGreenAccent,
                              Colors.tealAccent,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              result,
                              style: const TextStyle(
                                fontSize: 17,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              hijriResult,
                              style: const TextStyle(
                                fontSize: 17,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              remainingLife,
                              style: const TextStyle(
                                fontSize: 17,
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
