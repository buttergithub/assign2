import 'package:flutter/material.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Calculator(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark, // Dark mode theme
      ),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _input = "";
  double _num1 = 0.0;
  double _num2 = 0.0;
  String _operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _input = "";
      _num1 = 0.0;
      _num2 = 0.0;
      _operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "/" ||
        buttonText == "*") {
      _num1 = double.parse(_input);
      _operand = buttonText;
      _input = "";
    } else if (buttonText == ".") {
      if (_input.contains(".")) {
        return;
      } else {
        _input = _input + buttonText;
      }
    } else if (buttonText == "=") {
      _num2 = double.parse(_input);

      if (_operand == "+") {
        _output = (_num1 + _num2).toString();
      }
      if (_operand == "-") {
        _output = (_num1 - _num2).toString();
      }
      if (_operand == "*") {
        _output = (_num1 * _num2).toString();
      }
      if (_operand == "/") {
        _output = (_num1 / _num2).toString();
      }

      _num1 = 0.0;
      _num2 = 0.0;
      _operand = "";
    } else {
      _input = _input + buttonText;
    }

    setState(() {
      _output = double.parse(_input).toString();
    });
  }

  Widget buildButton(String buttonText, Color buttonColor, Color textColor) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5.0),
        child: ElevatedButton(
          onPressed: () => buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20.0),
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Calculator"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 12.0,
              ),
              child: Text(
                _input,
                style: const TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Expanded(
              child: Divider(),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    buildButton("7", Colors.grey[800]!, Colors.white),
                    buildButton("8", Colors.grey[800]!, Colors.white),
                    buildButton("9", Colors.grey[800]!, Colors.white),
                    buildButton("/", Colors.purple[700]!, Colors.white),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton("4", Colors.grey[800]!, Colors.white),
                    buildButton("5", Colors.grey[800]!, Colors.white),
                    buildButton("6", Colors.grey[800]!, Colors.white),
                    buildButton("*", Colors.purple[700]!, Colors.white),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton("1", Colors.grey[800]!, Colors.white),
                    buildButton("2", Colors.grey[800]!, Colors.white),
                    buildButton("3", Colors.grey[800]!, Colors.white),
                    buildButton("-", Colors.purple[700]!, Colors.white),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton(".", Colors.grey[800]!, Colors.white),
                    buildButton("0", Colors.grey[800]!, Colors.white),
                    buildButton("00", Colors.grey[800]!, Colors.white),
                    buildButton("+", Colors.purple[700]!, Colors.white),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton("C", Colors.lightGreen[700]!, Colors.white),
                    buildButton("=", Colors.yellowAccent[700]!, Colors.white),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}