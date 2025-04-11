import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for TextInputFormatter (controls text input)
import 'resultPage.dart'; // Import the ResultPage class (presumed to display conversion result)

void main() {
  runApp(const MyApp());
}

/// Root widget of the application. It sets up the MaterialApp and provides theming.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(), // The home page is the HomePage widget
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 224, 238, 245), // Set background color for the scaffold
      ),
    );
  }
}

/// HomePage widget where users input values, select bases, and trigger conversions.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController(); // Controller for the text input field

  String _selectedInputBase = 'Binary'; // Default selected input base
  String _selectedOutputBase = 'Decimal'; // Default selected output base

  // List of available bases for conversion
  final List<String> _bases = ['Binary', 'Octal', 'Decimal', 'Hexadecimal'];

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller when the widget is removed
    super.dispose();
  }

  /// Returns the input formatter based on the selected input base.
  List<TextInputFormatter> _getInputFormatter() {
    switch (_selectedInputBase) {
      case 'Binary':
        return [FilteringTextInputFormatter.allow(RegExp(r'[0-1]'))]; // Only allow 0 and 1 for binary
      case 'Octal':
        return [FilteringTextInputFormatter.allow(RegExp(r'[0-7]'))]; // Only allow digits 0-7 for octal
      case 'Decimal':
        return [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))]; // Only allow digits 0-9 for decimal
      case 'Hexadecimal':
        return [FilteringTextInputFormatter.allow(RegExp(r'[0-9A-Fa-f]'))]; // Only allow 0-9 and A-F for hexadecimal
      default:
        return [];
    }
  }

  /// Returns the appropriate keyboard type based on the selected input base.
  TextInputType _getKeyboardType() {
    switch (_selectedInputBase) {
      case 'Decimal':
      case 'Binary':
        return TextInputType.number; // Numeric keyboard for Decimal and Binary
      case 'Hexadecimal':
      case 'Octal':
        return TextInputType.text; // Regular keyboard for Hexadecimal and Octal
      default:
        return TextInputType.text;
    }
  }

  /// Navigates to the result page and passes the input data for conversion.
  void _navigateToResultPage(BuildContext context) {
    final input = _controller.text.trim();

    // Validation to ensure input is not empty and is valid for the selected base
    if (input.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid number for the selected input base')),
      );
      return;
    }

    // Navigate to ResultPage with the input data and selected bases
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          input: input,
          inputBase: _selectedInputBase,
          outputBase: _selectedOutputBase,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Base Converter"), centerTitle: true), // AppBar with title
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding for the body content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Binary Table widget showing conversion for binary numbers 0-15
            BinaryTable(),

            const SizedBox(height: 20),

            // TextField for user input
            Center(
              child: Container(
                width: 300,
                margin: const EdgeInsets.only(top: 20, bottom: 10),
                child: TextField(
                  controller: _controller, // Attach the controller to the input field
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter a number',
                  ),
                  keyboardType: _getKeyboardType(), // Dynamically set the keyboard type based on the input base
                  inputFormatters: _getInputFormatter(), // Dynamically set input formatters based on the input base
                ),
              ),
            ),

            // Dropdown for selecting the input base
            DropdownButton<String>(
              value: _selectedInputBase,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedInputBase = newValue!; // Update the selected input base
                  _controller.clear(); // Clear the input when the base changes
                });
              },
              items: _bases.map<DropdownMenuItem<String>>((String base) {
                return DropdownMenuItem<String>(
                  value: base,
                  child: Text(base),
                );
              }).toList(),
            ),

            const SizedBox(height: 10),

            // Dropdown for selecting the output base
            DropdownButton<String>(
              value: _selectedOutputBase,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOutputBase = newValue!; // Update the selected output base
                });
              },
              items: _bases.map<DropdownMenuItem<String>>((String base) {
                return DropdownMenuItem<String>(
                  value: base,
                  child: Text(base),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Row with buttons: Clear and Calculate
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _controller.clear(); // Clear the input field
                    });
                  },
                  child: const Text('Clear'),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: () => _navigateToResultPage(context), // Trigger the conversion and navigate
                  icon: const Icon(Icons.calculate, size: 24),
                  label: const Text(
                    'Calculate',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// BinaryTable widget displaying the conversions for numbers 0-15
class BinaryTable extends StatelessWidget {
  final List<Map<String, String>> values = List.generate(16, (i) {
    return {
      'decimal': i.toString(),
      'binary': i.toRadixString(2).padLeft(4, '0'),
      'octal': i.toRadixString(8),
      'hex': i.toRadixString(16).toUpperCase(),
    };
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.indigo.shade50,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.indigo.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  child: Table(
                    border: TableBorder.all(color: Colors.indigo),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      _buildHeaderRow(), // Header row for the table
                      ...values.map((val) => _buildDataRow(val)).toList(), // Data rows for each conversion
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

  /// Builds the header row for the binary table
  TableRow _buildHeaderRow() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.indigo.shade200),
      children: ['Decimal', 'Binary', 'Octal', 'Hex']
          .map((e) => Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  e,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ))
          .toList(),
    );
  }

  /// Builds a data row for each conversion value (Decimal, Binary, Octal, Hex)
  TableRow _buildDataRow(Map<String, String> row) {
    return TableRow(
      children: [
        row['decimal']!,
        row['binary']!,
        row['octal']!,
        row['hex']!,
      ]
          .map((val) => Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  val,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black87),
                ),
              ))
          .toList(),
    );
  }
}
