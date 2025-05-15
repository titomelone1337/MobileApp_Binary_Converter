// resultPage.dart
import 'package:flutter/material.dart';
import 'binary_converter.dart'; 
import 'package:confetti/confetti.dart'; // Optional: for celebration

class ResultPage extends StatefulWidget {
  final String input;
  final String inputBase;
  final String outputBase;

  const ResultPage({
    super.key,
    required this.input,
    required this.inputBase,
    required this.outputBase,
  });

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late final ConfettiController _confettiController;
  String? _convertedResult;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    _performConversion();
  }

  void _performConversion() {
    if (!BinaryConverter.validateInput(widget.input, widget.inputBase)) {
      setState(() {
        _errorMessage = "Invalid input for ${widget.inputBase} base.";
      });
      return;
    }

    try {
      final decimalValue = int.parse(BinaryConverter.convertToDecimal(widget.input, widget.inputBase));
      final result = BinaryConverter.convertFromDecimal(decimalValue, widget.outputBase);

      setState(() {
        _convertedResult = result;
        _errorMessage = null;
        _confettiController.play();
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Conversion failed: ${e.toString()}";
      });
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Conversion Result")),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: _errorMessage != null
                  ? Text(
                      _errorMessage!,
                      style: const TextStyle(fontSize: 20, color: Colors.red),
                      textAlign: TextAlign.center,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "🎉 Conversion Successful! 🎉",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "${widget.input} (${widget.inputBase}) =",
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "$_convertedResult (${widget.outputBase})",
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
            ),
          ),
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
          ),
        ],
      ),
    );
  }
}
