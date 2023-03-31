import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'resultPage.dart';

void main(){
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator App',
      color: Colors.green,
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  Color col = Colors.grey;
  Color col2 = Colors.grey;
  Color col3 = Colors.grey;


  String equation = "0";
  String result = "0";

  String firstOperand = "0";
  String secondOperand = "0";
  String operator = "0";
  bool flag = false;
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText){
    setState(() {
      if(!flag && (buttonText!='+' && buttonText!='-' &&
          buttonText != '*' && buttonText
          != '÷' )) {
        col2 = Colors.green;
        if(firstOperand== '0'){
          firstOperand=buttonText;
        }
        else {
          firstOperand+=buttonText;
        }
      }
      if(buttonText == '*' || buttonText
          == '÷' || buttonText == '+' || buttonText == '-') {
        setState(() {
          flag = true;
          operator = buttonText;
          col = Colors.green;
        });
      }
      if(flag == true) {
        if((buttonText!='+' && buttonText!='-' &&
            buttonText != '*' && buttonText
            != '÷' )) {
          col3 = Colors.green;
          if (secondOperand == '0') {
            secondOperand = buttonText;
          }
          else {
            secondOperand += buttonText;
          }
        }
      }
      if(buttonText == "Clr"){
        firstOperand = '0';
        secondOperand = '0';
        flag = false;
        equation = "0";
        result = "0";
        operator = "";
        col = Colors.grey;
        col2 = Colors.grey;
        col3 = Colors.grey;
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      }

      else if(buttonText == "="){

        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;

        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        Parser p = Parser();
        Expression exp = p.parse(expression);

        ContextModel cm = ContextModel();
        result = '${exp.evaluate(EvaluationType.REAL, cm)}';

        Navigator.push(context, MaterialPageRoute(builder: (context) => ResultScreen(result)));

      }

      else{
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if(equation == "0"){
          equation = buttonText;
        }else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: Colors.green,
      child: ElevatedButton (
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white
            ),
          )
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(title: const Text('Calculator App'),backgroundColor: Colors.green,),
      body: Column(
        children: <Widget>[


          Container(
            decoration: BoxDecoration(
              border: Border.all(),
              color: col2,
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(firstOperand, style: TextStyle(fontSize: equationFontSize),),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
              color: col,
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(operator, style: TextStyle(fontWeight: FontWeight.bold, fontSize: equationFontSize),),
          ),

          Container(
            decoration: BoxDecoration(
              border: Border.all(),
              color: col3,
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(secondOperand, style: TextStyle(fontSize: resultFontSize),),
          ),



          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.green,
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("+", 1.5, Colors.black),
                          buildButton("-", 1.5, Colors.black),
                          buildButton("/", 1.5, Colors.black),
                        ]
                    ),


                    TableRow(
                        children: [
                          buildButton("1", 1.5, Colors.black),
                          buildButton("2", 1.5, Colors.black),
                          buildButton("3", 1.5, Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("5", 1.5, Colors.black),
                          buildButton("6", 1.5, Colors.black),
                          buildButton("7", 1.5, Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("9", 1.5, Colors.black),
                          buildButton("0", 1.5, Colors.black),
                          buildButton("=", 1.5, Colors.black),
                        ]
                    ),
                  ],
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                color: Colors.green,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("*", 1.5, Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("4", 1.5, Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("8", 1.5, Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("Clr", 1.5, Colors.black),
                        ]
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}