import 'package:flutter/material.dart';

class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({super.key});

  @override
  State<TemperatureConverter> createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  final TextEditingController _temperatureController = TextEditingController();
  
  String _fromUnit = 'Celsius';
  String _toUnit = 'Fahrenheit';
  double? _convertedValue;

  final List<String> _units = ['Celsius', 'Fahrenheit', 'Kelvin'];

  IconData _getUnitIcon(String unit) {
    switch (unit) {
      case 'Celsius':
        return Icons.ac_unit;
      case 'Fahrenheit':
        return Icons.wb_sunny;
      case 'Kelvin':
        return Icons.science;
      default:
        return Icons.thermostat;
    }
  }

  Color _getUnitColor(String unit) {
    switch (unit) {
      case 'Celsius':
        return Colors.blue;
      case 'Fahrenheit':
        return Colors.orange;
      case 'Kelvin':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  void _convertTemperature() {
    final input = double.tryParse(_temperatureController.text);
    
    if (input == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid temperature value'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    double result;

    // Convert to Celsius first
    double celsius;
    switch (_fromUnit) {
      case 'Celsius':
        celsius = input;
        break;
      case 'Fahrenheit':
        celsius = (input - 32) * 5 / 9;
        break;
      case 'Kelvin':
        celsius = input - 273.15;
        break;
      default:
        celsius = input;
    }

    // Convert from Celsius to target unit
    switch (_toUnit) {
      case 'Celsius':
        result = celsius;
        break;
      case 'Fahrenheit':
        result = (celsius * 9 / 5) + 32;
        break;
      case 'Kelvin':
        result = celsius + 273.15;
        break;
      default:
        result = celsius;
    }

    setState(() {
      _convertedValue = result;
    });
  }

  void _swapUnits() {
    setState(() {
      final temp = _fromUnit;
      _fromUnit = _toUnit;
      _toUnit = temp;
      _convertedValue = null;
    });
  }

  void _reset() {
    setState(() {
      _temperatureController.clear();
      _convertedValue = null;
    });
  }

  @override
  void dispose() {
    _temperatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Unit Selection Cards
              Row(
                children: [
                  Expanded(
                    child: _UnitSelectorCard(
                      title: 'From',
                      unit: _fromUnit,
                      units: _units,
                      icon: _getUnitIcon(_fromUnit),
                      color: _getUnitColor(_fromUnit),
                      onUnitChanged: (unit) {
                        setState(() {
                          _fromUnit = unit;
                          _convertedValue = null;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Swap Button
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: IconButton(
                      onPressed: _swapUnits,
                      icon: const Icon(Icons.swap_horiz),
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                        padding: const EdgeInsets.all(16),
                      ),
                      iconSize: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _UnitSelectorCard(
                      title: 'To',
                      unit: _toUnit,
                      units: _units,
                      icon: _getUnitIcon(_toUnit),
                      color: _getUnitColor(_toUnit),
                      onUnitChanged: (unit) {
                        setState(() {
                          _toUnit = unit;
                          _convertedValue = null;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Input Field
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            _getUnitIcon(_fromUnit),
                            color: _getUnitColor(_fromUnit),
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Temperature Value',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _temperatureController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          hintText: 'Enter temperature',
                          suffixText: '°${_fromUnit[0]}',
                          prefixIcon: const Icon(Icons.input),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Convert Button
              ElevatedButton.icon(
                onPressed: _convertTemperature,
                icon: const Icon(Icons.autorenew, size: 24),
                label: const Text(
                  'Convert',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                ),
              ),
              const SizedBox(height: 16),

              // Reset Button
              OutlinedButton(
                onPressed: _reset,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                ),
                child: const Text(
                  'Reset',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 24),

              // Result Display
              if (_convertedValue != null)
                Card(
                  elevation: 6,
                  color: _getUnitColor(_toUnit).withValues(alpha: 0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _getUnitIcon(_toUnit),
                              color: _getUnitColor(_toUnit),
                              size: 32,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Converted Result',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: _getUnitColor(_toUnit),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Text(
                                _convertedValue!.toStringAsFixed(2),
                                style: const TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '°${_toUnit[0]}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _toUnit,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UnitSelectorCard extends StatelessWidget {
  final String title;
  final String unit;
  final List<String> units;
  final IconData icon;
  final Color color;
  final Function(String) onUnitChanged;

  const _UnitSelectorCard({
    required this.title,
    required this.unit,
    required this.units,
    required this.icon,
    required this.color,
    required this.onUnitChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: color.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color, width: 2),
              ),
              child: DropdownButton<String>(
                value: unit,
                isExpanded: true,
                icon: Icon(icon, color: color),
                underline: const SizedBox(),
                items: units.map((String unitOption) {
                  return DropdownMenuItem<String>(
                    value: unitOption,
                    child: Row(
                      children: [
                        Icon(
                          _getUnitIconForOption(unitOption),
                          size: 20,
                          color: color,
                        ),
                        const SizedBox(width: 8),
                        Text(unitOption),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    onUnitChanged(newValue);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getUnitIconForOption(String unitOption) {
    switch (unitOption) {
      case 'Celsius':
        return Icons.ac_unit;
      case 'Fahrenheit':
        return Icons.wb_sunny;
      case 'Kelvin':
        return Icons.science;
      default:
        return Icons.thermostat;
    }
  }
}

