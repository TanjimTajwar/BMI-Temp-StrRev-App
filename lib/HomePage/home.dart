import 'package:flutter/material.dart';

import '../TaskFor_5_11_2025/atm_simulator.dart';
import '../TaskFor_5_11_2025/faraid_calculator.dart';
import '../TaskFor_5_11_2025/hijri_age_calculator.dart';
import '../TaskFor_5_11_2025/loan_calculator.dart';

import '../TaskFor_3_11_2025/bmi_calculator.dart';
import '../TaskFor_3_11_2025/string_reverser.dart';
import '../TaskFor_3_11_2025/temperature_converter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF00796B),
              Color(0xFF26A69A),
              Color(0xFF80CBC4),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 🌟 App Title
                Text(
                  'Welcome Multi App',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: const Offset(2, 2),
                        blurRadius: 6,
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'My Task for 6th Semester',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // 💵 ATM Simulator
                _FeatureCard(
                  title: 'ATM Simulator',
                  icon: Icons.account_balance,
                  color: Colors.deepPurple,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ATMSimulator(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // ⚖️ Faraid Calculator
                _FeatureCard(
                  title: 'Faraid (Islamic Inheritance)',
                  icon: Icons.family_restroom,
                  color: Colors.teal,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FaraidCalculator(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // 🌙 Hijri Age Calculator
                _FeatureCard(
                  title: 'Hijri Age Calculator',
                  icon: Icons.calendar_month,
                  color: Colors.indigo,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HijriAgeCalculator(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // 💰 Loan Calculator
                _FeatureCard(
                  title: 'Loan Monthly Payment',
                  icon: Icons.calculate,
                  color: Colors.orangeAccent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoanCalculator(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // 🧍 BMI Calculator
                _FeatureCard(
                  title: 'BMI Calculator',
                  icon: Icons.monitor_weight,
                  color: Colors.green,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BMICalculator(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // 🔤 String Reverser
                _FeatureCard(
                  title: 'String Reverser',
                  icon: Icons.text_fields,
                  color: Colors.pinkAccent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StringReverser(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // 🌡️ Temperature Converter
                _FeatureCard(
                  title: 'Temperature Converter',
                  icon: Icons.thermostat,
                  color: Colors.cyan,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TemperatureConverter(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 🌟 Custom Feature Card Widget
class _FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color,
                color.withOpacity(0.85),
              ],
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 38,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white.withOpacity(0.8),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
