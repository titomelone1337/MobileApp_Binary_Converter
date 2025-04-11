import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart'; // Import for confetti effects
import 'dart:math'; // For mathematical operations like PI

/// This page displays the result of the number base conversion with a confetti celebration.
class ResultPage extends StatefulWidget {
  final String input; // The input number as a string
  final String inputBase; // The base of the input number (Binary, Octal, Hexadecimal, or Decimal)
  final String outputBase; // The target base for conversion (Binary, Octal, Hexadecimal, or Decimal)

  const ResultPage({
    super.key,
    required this.input, // Required input number
    required this.inputBase, // Required input base
    required this.outputBase, // Required output base
  });

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late ConfettiController _confettiController; // Controller to manage confetti animation

  @override
  void initState() {
    super.initState();
    // Initialize the confetti controller with a duration of 3 seconds
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _confettiController.play(); // Start the confetti animation immediately
  }

  @override
  void dispose() {
    _confettiController.dispose(); // Dispose of the confetti controller when the widget is removed
    super.dispose();
  }

  /// Converts the input from the selected base to decimal (base 10).
  ///
  /// [input] is the number in the selected base as a string.
  /// [base] is the base of the input number (Binary, Octal, Hexadecimal, or Decimal).
  /// Returns the input number converted to decimal as a string.
  String _convertToDecimal(String input, String base) {
    switch (base) {
      case 'Binary':
        return int.parse(input, radix: 2).toString(); // Convert binary to decimal
      case 'Octal':
        return int.parse(input, radix: 8).toString(); // Convert octal to decimal
      case 'Hexadecimal':
        return int.parse(input, radix: 16).toString(); // Convert hexadecimal to decimal
      case 'Decimal':
      default:
        return input; // No conversion needed if already decimal
    }
  }

  /// Converts a decimal number to the selected output base.
  ///
  /// [decimalValue] is the number in decimal that needs to be converted.
  /// [base] is the target base (Binary, Octal, Hexadecimal, or Decimal).
  /// Returns the decimal number converted to the target base as a string.
  String _convertFromDecimal(int decimalValue, String base) {
    switch (base) {
      case 'Binary':
        return decimalValue.toRadixString(2); // Convert decimal to binary
      case 'Octal':
        return decimalValue.toRadixString(8); // Convert decimal to octal
      case 'Hexadecimal':
        return decimalValue.toRadixString(16).toUpperCase(); // Convert decimal to hexadecimal (uppercase)
      case 'Decimal':
      default:
        return decimalValue.toString(); // No conversion needed if already decimal
    }
  }

  @override
  Widget build(BuildContext context) {
    // Convert the input number to decimal first
    String decimalValueString = _convertToDecimal(widget.input, widget.inputBase);
    int decimalValue = int.parse(decimalValueString);

    // Convert the decimal number to the desired output base
    String result = _convertFromDecimal(decimalValue, widget.outputBase);

    return Scaffold(
      appBar: AppBar(title: const Text("Conversion Result")), // Title of the page
      body: Stack( // Stack layout allows for overlaying confetti on top of the content
        children: [
          // Centered content with the result of the conversion
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
                children: [
                  const Text(
                    '🎉 Congratulations 👑', // Celebration message
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple, // Color of the message
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Input number with base displayed
                  Text(
                    'Input: ${widget.input} (${widget.inputBase})',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  // Result of the conversion
                  Text(
                    'Converted to ${widget.outputBase}: $result',
                    style: const TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
          // Confetti widget placed at the top of the screen
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController, // Controller for managing the confetti effect
              blastDirection: pi / 2, // Direction of the confetti explosion
              maxBlastForce: 10, // Maximum force of the blast
              minBlastForce: 5, // Minimum force of the blast
              emissionFrequency: 0.05, // How often particles are emitted
              numberOfParticles: 20, // Number of confetti particles
              gravity: 0.3, // Gravity affecting the confetti fall
            ),
          ),
        ],
      ),
    );
  }
}
