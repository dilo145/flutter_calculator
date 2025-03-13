import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = "0";
  String _output = "0";
  String inputDisplay = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  List<String> calculationHistory = [];

  String calculateResult() {
    if (operand.isEmpty) {
      return _output;
    }

    try {
      double result = 0;
      double secondNum = double.parse(_output);

      if (operand == "+") {
        result = num1 + secondNum;
      } else if (operand == "-") {
        result = num1 - secondNum;
      } else if (operand == "*") {
        result = num1 * secondNum;
      } else if (operand == "/") {
        if (secondNum == 0) {
          return "Erreur";
        }
        result = num1 / secondNum;
      }

      if (result == result.toInt()) {
        return result.toInt().toString();
      }
      return result.toString();
    } catch (e) {
      return "Erreur";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator Flutter'),
        toolbarHeight: 40.0,
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              _showHistoryDialog(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.12,
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.bottomRight,
              child: Text(
                inputDisplay,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.14,
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1))
              ),
              child: Text(
                output,
                style: TextStyle(
                  fontSize: 46,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 15.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 20,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    List<String> buttons = [
                      'C', '%', '⌫', '/',
                      '7', '8', '9', '*',
                      '4', '5', '6', '-',
                      '1', '2', '3', '+',
                      '±', '0', '.', '='
                    ];

                    _buttonPressed(String buttonText) {
                      if (buttonText == "C") {
                        _output = "0";
                        num1 = 0.0;
                        num2 = 0.0;
                        operand = "";
                        inputDisplay = "0";
                        output = "0";
                      } else if (buttonText == "⌫") {
                        if (operand.isEmpty) {
                          if (_output.length > 1) {
                            _output = _output.substring(0, _output.length - 1);
                            inputDisplay = _output;
                          } else {
                            _output = "0";
                            inputDisplay = "0";
                          }
                        } else {
                          if (_output.length > 1) {
                            _output = _output.substring(0, _output.length - 1);
                            inputDisplay = formatNumber(num1) + operand + _output;
                          } else {
                            _output = "0";
                            inputDisplay = formatNumber(num1) + operand + "0";
                          }
                        }
                        output = calculateResult();
                      } else if (buttonText == "±") {
                        if (_output != "0") {
                          if (_output.startsWith('-')) {
                            _output = _output.substring(1);
                          } else {
                            _output = '-' + _output;
                          }

                          if (operand.isEmpty) {
                            inputDisplay = _output;
                          } else {
                            inputDisplay = formatNumber(num1) + operand + _output;
                          }
                          output = calculateResult();
                        }
                      } else if (buttonText == "%") {
                        if (_output != "0") {
                          double inputValue = double.parse(_output);
                          double percentage = inputValue / 100;

                          if (operand.isEmpty) {
                            inputDisplay = _output + "%";
                            output = formatNumber(percentage);
                            _output = output;
                          } else {
                            double percentOfNum1 = num1 * percentage;

                            if (operand == "+" || operand == "-") {
                              inputDisplay = formatNumber(num1) + operand + formatNumber(inputValue) + "%";
                              _output = formatNumber(percentOfNum1);

                              if (operand == "+") {
                                output = formatNumber(num1 + percentOfNum1);
                              } else {
                                output = formatNumber(num1 - percentOfNum1);
                              }
                            } else {
                              inputDisplay = formatNumber(num1) + operand + formatNumber(inputValue) + "%";
                              _output = formatNumber(percentage);
                              output = calculateResult();
                            }
                          }
                        }
                      } else if (buttonText == "." && !_output.contains(".")) {
                        _output = _output + ".";

                        if (operand.isEmpty) {
                          inputDisplay = _output;
                        } else {
                          inputDisplay = formatNumber(num1) + operand + _output;
                        }
                      } else if (buttonText == "+" ||
                          buttonText == "-" ||
                          buttonText == "/" ||
                          buttonText == "*") {
                        num1 = double.parse(_output);
                        operand = buttonText;
                        inputDisplay = formatNumber(num1) + operand;
                        _output = "0";
                      } else if (buttonText == "=") {
                        num2 = double.parse(_output);
                        String result = calculateResult();

                        calculationHistory.add('$inputDisplay = $result');
                        if (calculationHistory.length > 20) {
                          calculationHistory.removeAt(0);
                        }

                        _output = result;
                        num1 = 0.0;
                        num2 = 0.0;
                        operand = "";
                        inputDisplay = result;
                        output = result;
                      } else {
                        if (_output == "0") {
                          _output = "";
                        }
                        _output = _output + buttonText;

                        if (operand.isEmpty) {
                          inputDisplay = _output;
                        } else {
                          inputDisplay = formatNumber(num1) + operand + _output;
                        }

                        output = calculateResult();
                      }

                      setState(() {
                      });
                    }

                    Color getButtonColor(String buttonText) {
                      if (buttonText == "C" || buttonText == "⌫" || buttonText == "%") {
                        return Colors.redAccent;
                      } else if (buttonText == "+" || buttonText == "-" ||
                               buttonText == "*" || buttonText == "/" ||
                               buttonText == "=") {
                        return Colors.blueAccent;
                      } else {
                        return Colors.grey[300]!;
                      }
                    }

                    return Container(
                      child: ElevatedButton(
                        onPressed: () {
                          _buttonPressed(buttons[index]);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: getButtonColor(buttons[index]),
                          foregroundColor: getButtonColor(buttons[index]) == Colors.grey[300] ?
                                          Colors.black : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(buttons[index], style: TextStyle(fontSize: 24)),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
      bottomNavigationBar: null,
    );
  }

  void _showHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Calculation History'),
          content: Container(
            width: double.maxFinite,
            height: 300,
            child: calculationHistory.isEmpty
                ? Center(child: Text('No history yet'))
                : ListView.builder(
                    itemCount: calculationHistory.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          calculationHistory[calculationHistory.length - 1 - index],
                          style: TextStyle(fontSize: 18),
                        ),
                        onTap: () {
                          String historyEntry = calculationHistory[calculationHistory.length - 1 - index];
                          if (historyEntry.contains('=')) {
                            List<String> parts = historyEntry.split('=');
                            inputDisplay = parts[0].trim();
                            output = parts[1].trim();
                            _output = output;
                            operand = "";
                          }
                          Navigator.of(context).pop();
                          setState(() {});
                        },
                      );
                    },
                  ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Clear History'),
              onPressed: () {
                calculationHistory.clear();
                Navigator.of(context).pop();
                setState(() {});
              },
            ),
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String formatNumber(double number) {
    String formatted = number.toString();
    if (formatted.endsWith('.0')) {
      formatted = formatted.substring(0, formatted.length - 2);
    }
    return formatted;
  }
}