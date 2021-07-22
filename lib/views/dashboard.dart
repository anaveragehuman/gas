import 'package:flutter/material.dart';

import '../widgets/gascard.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gas Price (in Gwei)'),
      ),
      body: const _GasCards(),
    );
  }
}

class _GasCards extends StatelessWidget {
  const _GasCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 128, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          GasCard(
            iconData: Icons.bolt,
            title: 'Fast',
            color: Colors.deepOrange,
            gwei: 12,
          ),
          GasCard(
            iconData: Icons.drive_eta,
            title: 'Normal',
            color: Colors.blue,
            gwei: 10,
          ),
          GasCard(
            iconData: Icons.directions_walk,
            title: 'Slow',
            color: Colors.purple,
            gwei: 9,
          ),
        ],
      ),
    );
  }
}
