import 'package:flutter/material.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({
    Key? key,
    required this.counter,
    required this.incrementCounter,
  }) : super(key: key);

  final int counter;
  final VoidCallback incrementCounter;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '$counter',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          ElevatedButton(
            onPressed: incrementCounter,
            child: const Text('Increment'),
          ),
        ],
      ),
    );
  }
}
