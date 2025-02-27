import 'package:flutter/material.dart';
import 'package:flutter_calculator/constants/constants.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var inputUser = '';
  var result = '';

  double overSize() {
    if (result.length < 10) {
      return 62;
    } else {
      return 45;
    }
  }

  void buttonPressed(String text) {
    setState(() {
      if (inputUser.length < 43) {
        inputUser = inputUser + text;
      }
    });
  }

  Widget getRow(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(width: 0, color: Colors.transparent),
              ),
              backgroundColor: getBackgroundColor(text1)),
          onPressed: () {
            if (text1 == 'ac') {
              setState(() {
                inputUser = '';
                result = '';
              });
            } else {
              buttonPressed(text1);
            }
            ;
          },
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Text(
              text1,
              style: TextStyle(fontSize: 26, color: getOperatorColor(text1)),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(width: 0, color: Colors.transparent),
              ),
              backgroundColor: getBackgroundColor(text2)),
          onPressed: () {
            if (text2 == 'ce') {
              if (inputUser.length > 0) {
                setState(
                  () {
                    inputUser = inputUser.substring(0, inputUser.length - 1);
                  },
                );
              }
            } else {
              buttonPressed(text2);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Text(
              text2,
              style: TextStyle(fontSize: 26, color: getOperatorColor(text2)),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(width: 0, color: Colors.transparent),
              ),
              backgroundColor: getBackgroundColor(text3)),
          onPressed: () {
            buttonPressed(text3);
          },
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Text(
              text3,
              style: TextStyle(fontSize: 26, color: getOperatorColor(text3)),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(width: 0, color: Colors.transparent),
              ),
              backgroundColor: getBackgroundColor(text4)),
          onPressed: () {
            //calculate result
            var result_1 = '';
            if (text4 == '=') {
              setState(() {
                Parser parser = Parser();
                Expression expression = parser.parse(inputUser);
                ContextModel contextModel = ContextModel();
                double eval =
                    expression.evaluate(EvaluationType.REAL, contextModel);

                result_1 = eval.toString();

                if (result_1.length > 14) {
                  result = result_1.substring(0, 9) + ' E';
                } else {
                  result = eval.toString();
                }
              });
            } else {
              buttonPressed(text4);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Text(
              text4,
              style: TextStyle(fontSize: 26, color: getOperatorColor(text4)),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: backgroundGrayDark,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          inputUser,
                          textAlign: TextAlign.end,
                          style: TextStyle(color: textGreen, fontSize: 28),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          '$result',
                          style:
                              TextStyle(fontSize: overSize(), color: textGray),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                    color: backgroundGray,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        getRow('ac', 'ce', '%', '/'),
                        getRow('1', '2', '3', '*'),
                        getRow('4', '5', '6', '-'),
                        getRow('7', '8', '9', '+'),
                        getRow('00', '0', '.', '='),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool isOperator(String text) {
    var list = ['ac', 'ce', '%', '/', '*', '-', '+', '='];

    for (var item in list) {
      if (text == item) {
        return true;
      }
    }

    return false;
  }

  Color getBackgroundColor(String text) {
    if (isOperator(text)) {
      return backgroundGrayDark;
    } else {
      return Colors.transparent;
    }
  }

  Color getOperatorColor(String text) {
    if (isOperator(text)) {
      return textGreen;
    } else {
      return textGray;
    }
  }
}
