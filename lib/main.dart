import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp(
  
));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'my calculator app',
      theme: ThemeData(),
      home: Calculator(),
    );
  }
}


class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  //Light Dark Mode Switch
  bool _switch = false;
  ThemeData _dark = ThemeData(brightness: Brightness.dark, primaryColor: Colors.white);
  ThemeData _light = ThemeData(brightness: Brightness.light, primaryColor: Colors.grey[800]);


  String equation = ''; //This is the text on calculator screen
  String expression = ''; //The function key for solving equations
  String result = '0';  //This is the result of our expression
  double equationSize = 32;
  double resultSize = 48;


  //CALCULATOR BUTTON PRESS FUNCTION
  clickButton(String btnValue){
    setState(() {
      if(btnValue == 'C'){
        equation = '0';
        result = '';
      }else if(btnValue == 'AC'){
        equation = '0';
        result = '';
        expression = '';
      }else if(btnValue == 'DEL'){
        equationSize = equationSize;
        resultSize = resultSize;
        equation = equation.substring(0, equation.length - 1);
        if(equation == ''){
          equation = '0'; //after backspacing the character and removing the
          //last, instead of leaving an empty screen, set equation (text) to 0
        }
      }else if(btnValue == '═'){
        equationSize = equationSize;
        resultSize = resultSize;

        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('—', '-');

        try{
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = 'Error';
        }

      }else{
        equationSize = equationSize;
        //resultSize = 22;
        if(equation == '0'){
          equation = btnValue;
        }else {
          equation = equation + btnValue;
        }
      }
    });
  }


  //CREATING A METHOD FOR CALCULATOR BUTTON
  Widget calculatorButton(String btnValue, double buttonHeight, double textSize, Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      //width: MediaQuery.of(context).size.width * 0.1 * buttonWidth,
      color: buttonColor,
      child: FlatButton(
        //padding: EdgeInsets.all(5.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(
            width: 1, color: Colors.grey[200], style: BorderStyle.solid,
          ),
        ),
        onPressed: () {
          clickButton(btnValue);
        },
        child: Text(
          btnValue,
          style: TextStyle(
            color: Colors.grey[900],
            fontSize: textSize,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _switch ? _dark : _light,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //SizedBox(height: 10.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Switch Mode',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Switch(value: _switch, onChanged: (_newswitch){
                      setState(() {
                        _switch = _newswitch;
                      });
                    })
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 15, 10, 20),
              child: Text(
                result,
                style: TextStyle(
                  fontSize: resultSize,
                  inherit: true, //Colors.grey[800],
                  fontWeight: FontWeight.w300,
                ),
              ),
              alignment: Alignment.centerRight,
            ),

            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 50),
              child: Text(
                equation,
                style: TextStyle(
                  fontSize: equationSize,
                  inherit: true, //Colors.grey[800],
                  fontWeight: FontWeight.w300,
                ),
              ),
              alignment: Alignment.centerRight,
            ),

            //Expanded(
            //child: Divider(),
            //),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          calculatorButton('C', 1, 22, Colors.grey[100],),
                          calculatorButton('AC', 1, 19, Colors.grey[100],),
                          calculatorButton('DEL', 1, 18, Colors.grey[100],),
                        ],
                      ),

                      TableRow(
                        children: [
                          calculatorButton('7', 1, 22, Colors.grey[100],),
                          calculatorButton('8', 1, 22, Colors.grey[100],),
                          calculatorButton('9', 1, 22, Colors.grey[100],),
                        ],
                      ),

                      TableRow(
                        children: [
                          calculatorButton('4', 1, 22, Colors.grey[100],),
                          calculatorButton('5', 1, 22, Colors.grey[100],),
                          calculatorButton('6', 1, 22, Colors.grey[100],),
                        ],
                      ),

                      TableRow(
                        children: [
                          calculatorButton('1', 1, 22, Colors.grey[100],),
                          calculatorButton('2', 1, 22, Colors.grey[100],),
                          calculatorButton('3', 1, 22, Colors.grey[100],),
                        ],
                      ),

                      TableRow(
                        children: [
                          calculatorButton('0', 1, 22, Colors.grey[100],),
                          calculatorButton('.', 1, 22, Colors.grey[100],),
                          calculatorButton('00', 1, 22, Colors.grey[100],),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width * .25,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          calculatorButton('/', 1, 24, Colors.blueGrey[200]),
                        ],
                      ),

                      TableRow(
                        children: [
                          calculatorButton('x', 1, 24, Colors.blueGrey[200]),
                        ],
                      ),

                      TableRow(
                        children: [
                          calculatorButton('—', 1, 24, Colors.blueGrey[200]),
                        ],
                      ),

                      TableRow(
                        children: [
                          calculatorButton('+', 1, 24, Colors.blueGrey[200]),
                        ],
                      ),

                      TableRow(
                        children: [
                          calculatorButton('═', 1, 26, Colors.blueGrey[300]),
                        ],
                      ),
                    ],
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