import 'package:flutter/material.dart';

class FaraidCalculator extends StatefulWidget {
  const FaraidCalculator({super.key});

  @override
  State<FaraidCalculator> createState() => _FaraidCalculatorState();
}

class _FaraidCalculatorState extends State<FaraidCalculator> {
  final TextEditingController wealthController = TextEditingController();
  final TextEditingController sonsController = TextEditingController();
  final TextEditingController daughtersController = TextEditingController();
  final TextEditingController wivesController = TextEditingController();

  bool hasFather = false;
  bool hasMother = false;
  bool hasHusband = false;

  String result = "";

  void calculateFaraid() {
    double wealth = double.tryParse(wealthController.text) ?? 0;
    int sons = int.tryParse(sonsController.text) ?? 0;
    int daughters = int.tryParse(daughtersController.text) ?? 0;
    int wives = int.tryParse(wivesController.text) ?? 0;

    if (wealth <= 0) {
      setState(() {
        result = "Please enter a valid total wealth.";
      });
      return;
    }

    double remaining = wealth;
    Map<String, double> shares = {};

    // ---------- Fixed shares ----------
    if (hasFather) {
      shares["Father (1/6)"] = wealth * (1 / 6);
      remaining -= shares["Father (1/6)"]!;
    }

    if (hasMother) {
      if (sons > 0 || daughters > 0) {
        shares["Mother (1/6)"] = wealth * (1 / 6);
      } else {
        shares["Mother (1/3)"] = wealth * (1 / 3);
      }
      remaining -= shares.values.last;
    }

    if (hasHusband) {
      if (sons > 0 || daughters > 0) {
        shares["Husband (1/4)"] = wealth * (1 / 4);
      } else {
        shares["Husband (1/2)"] = wealth * (1 / 2);
      }
      remaining -= shares.values.last;
    } else if (wives > 0) {
      if (sons > 0 || daughters > 0) {
        shares["Wives (1/8 shared)"] = wealth * (1 / 8);
      } else {
        shares["Wives (1/4 shared)"] = wealth * (1 / 4);
      }
      remaining -= shares.values.last;
    }

    // ---------- Children (residuary part) ----------
    if (sons + daughters > 0) {
      int totalShares = (sons * 2) + daughters;
      double shareValue = remaining / totalShares;

      if (sons > 0) {
        shares["Each Son"] = shareValue * 2;
      }
      if (daughters > 0) {
        shares["Each Daughter"] = shareValue;
      }
    } else if (daughters > 0 && sons == 0) {
      if (daughters == 1) {
        shares["Daughter (1/2)"] = wealth * 0.5;
      } else {
        shares["Daughters (2/3 shared)"] = wealth * (2 / 3);
      }
    }

    // ---------- Wives share division ----------
    if (wives > 1 && shares.containsKey("Wives (1/8 shared)") ||
        shares.containsKey("Wives (1/4 shared)")) {
      String key = shares.containsKey("Wives (1/8 shared)")
          ? "Wives (1/8 shared)"
          : "Wives (1/4 shared)";
      double totalWivesShare = shares[key]!;
      shares["Each Wife"] = totalWivesShare / wives;
    }

    // ---------- Display results ----------
    StringBuffer output = StringBuffer();
    output.writeln("📊 Islamic Inheritance (Fara’id) Result\n");
    shares.forEach((key, value) {
      output.writeln("$key: ${value.toStringAsFixed(2)} Tk");
    });
    output.writeln(
      "\nRemaining wealth (if any): ${remaining < 0 ? 0 : remaining.toStringAsFixed(2)} Tk",
    );

    setState(() {
      result = output.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF006400), Color(0xFFB8860B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "🕌 Fara’id (Islamic Inheritance)",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(color: Colors.black45, offset: Offset(2, 2)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // ---- Input Card ----
                Card(
                  color: Colors.white.withOpacity(0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        buildTextField(
                          wealthController,
                          "Total Wealth (Tk)",
                          Icons.attach_money,
                        ),
                        buildTextField(
                          sonsController,
                          "Number of Sons",
                          Icons.male,
                        ),
                        buildTextField(
                          daughtersController,
                          "Number of Daughters",
                          Icons.female,
                        ),
                        buildTextField(
                          wivesController,
                          "Number of Wives",
                          Icons.favorite,
                        ),

                        const SizedBox(height: 10),
                        buildCheckbox(
                          "Father Alive",
                          hasFather,
                          (val) => setState(() => hasFather = val),
                        ),
                        buildCheckbox(
                          "Mother Alive",
                          hasMother,
                          (val) => setState(() => hasMother = val),
                        ),
                        buildCheckbox(
                          "Husband Alive",
                          hasHusband,
                          (val) => setState(() => hasHusband = val),
                        ),

                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: calculateFaraid,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[800],
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 30,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            "Calculate Fara’id",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // ---- Result Card ----
                if (result.isNotEmpty)
                  Card(
                    color: Colors.white.withOpacity(0.9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        result,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
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

  Widget buildTextField(
    TextEditingController controller,
    String label,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.green[900]),
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }

  Widget buildCheckbox(String title, bool value, Function(bool) onChanged) {
    return CheckboxListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      activeColor: Colors.green[800],
      value: value,
      onChanged: (v) => onChanged(v ?? false),
    );
  }
}
