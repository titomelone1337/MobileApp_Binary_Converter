# Binary Converter App

A simple Flutter application that asks the user which base they want to input (binary, decimal, etc.) and which base they want to see the result in (binary, decimal, hexadecimal, etc.). The app follows the **Model-View-Controller (MVC)** pattern and includes input validation logic to ensure users enter valid format inputs.

## Features

- Converts numbers between different bases (e.g., binary, decimal, hexadecimal).
- Supports user-defined input and output base (such as converting from decimal to binary or hexadecimal).
- Follows the **MVC (Model-View-Controller)** architectural pattern for a clean and maintainable codebase.
- Input validation to ensure only valid numbers in the correct base are entered.

## Structure

The app is divided into three main components, following the MVC pattern:

- **Model**: Contains the logic for converting between different number bases.
- **View**: Displays the user interface and communicates with the Controller.
- **Controller**: Manages user interactions, invokes the Model for conversion, and updates the View accordingly.

## Prerequisites

To run this project, ensure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)
- A code editor like [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio)

## How to Clone and Run the Project

Follow the steps below to clone and run the app locally:

### Step 1: Clone the repository

```bash
git clone https://github.com/your-username/binary-converter-app.git
cd binary-converter-app
flutter pub get
flutter run
