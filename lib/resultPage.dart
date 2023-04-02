import 'package:flutter/material.dart';
import 'main.dart';

class ResultScreen extends StatelessWidget {
  final String ans;

  const ResultScreen(this.ans, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      color: Colors.green,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('Result Window'),backgroundColor: Colors.green,),
        body: HomePage(ans),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String ans;
  const HomePage(this.ans, {super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Container(
          margin: const EdgeInsets.all(100),
          decoration: BoxDecoration(
            border: Border.all(),
            color: Colors.grey,
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Text(
              ans,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
        const Expanded(
          child: Divider(),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 270),
          color: Colors.green,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Calculator()));
            },
            child: const Text("Go Back"),
          ),
        ),
      ],
    );
  }
}
