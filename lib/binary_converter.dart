// binary_converter.dart
/// This class provides methods to convert between different number bases (Binary, Octal, Decimal, Hexadecimal)
/// and also validates inputs for correctness based on the selected base.
class BinaryConverter {
  
  /// Converts input from the selected base (Binary, Octal, Hexadecimal, Decimal) to Decimal.
  /// 
  /// [input] is the number in the selected base as a string.
  /// [base] is the base of the input number (Binary, Octal, Hexadecimal, or Decimal).
  /// Returns the decimal equivalent of the input number as a string.
  static String convertToDecimal(String input, String base) {
    switch (base) {
      case 'Binary':
        return int.parse(input, radix: 2).toString(); // Converts binary to decimal
      case 'Octal':
        return int.parse(input, radix: 8).toString(); // Converts octal to decimal
      case 'Hexadecimal':
        return int.parse(input, radix: 16).toString(); // Converts hexadecimal to decimal
      case 'Decimal':
      default:
        return input; // If the input is already in decimal, no conversion is needed
    }
  }

  /// Converts a decimal number to the selected base (Binary, Octal, Hexadecimal, Decimal).
  ///
  /// [decimalValue] is the number in decimal that needs to be converted.
  /// [base] is the target base for the conversion (Binary, Octal, Hexadecimal, or Decimal).
  /// Returns the number in the specified base as a string.
  static String convertFromDecimal(int decimalValue, String base) {
    switch (base) {
      case 'Binary':
        return decimalValue.toRadixString(2); // Converts decimal to binary
      case 'Octal':
        return decimalValue.toRadixString(8); // Converts decimal to octal
      case 'Hexadecimal':
        return decimalValue.toRadixString(16).toUpperCase(); // Converts decimal to hexadecimal
      case 'Decimal':
      default:
        return decimalValue.toString(); // If it's decimal, no conversion is needed
    }
  }

  /// Validates the input based on the selected base (Binary, Octal, Hexadecimal, Decimal).
  ///
  /// [input] is the number to be validated as a string.
  /// [base] is the base that the input number is supposed to conform to (Binary, Octal, Hexadecimal, or Decimal).
  /// Returns true if the input is valid for the given base, otherwise returns false.
  static bool validateInput(String input, String base) {
    // Rejects invalid characters such as negative signs, commas, or dots
    if (input.contains('-') || input.contains('.') || input.contains(',')) {
      return false;
    }

    switch (base) {
      case 'Binary':
        // Validates that input contains only '0' or '1' (Binary format)
        return RegExp(r'^[01]+$').hasMatch(input); 
      case 'Octal':
        // Validates that input contains only digits '0' through '7' (Octal format)
        return RegExp(r'^[0-7]+$').hasMatch(input); 
      case 'Hexadecimal':
        // Validates that input contains only digits '0' through '9' and letters 'A' through 'F' (Hexadecimal format)
        return RegExp(r'^[0-9A-Fa-f]+$').hasMatch(input); 
      case 'Decimal':
      default:
        // Validates that input contains only positive integers (Decimal format)
        return RegExp(r'^\d+$').hasMatch(input); 
    }
  }
}
