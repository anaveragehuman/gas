import 'package:flutter/material.dart';

import '../widgets/gascard.dart';
import '../widgets/status_indicator.dart';
import '../widgets/timer_appbar.dart';
import 'preferences.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gas Price (in Gwei)'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: TimerProgressBar(),
        ),
      ),
      body: Stack(
        children: const [
          StatusIndicator(),
          _GasCards(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push<void>(
          context,
          MaterialPageRoute(builder: (_) => PrefPage()),
        ),
        child: const Icon(Icons.settings),
      ),
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
        children: [
          GasCard(
            iconData: Icons.bolt,
            title: 'Fast',
            color: Colors.deepOrange,
            gwei: (info) => info.fast,
          ),
          GasCard(
            iconData: Icons.drive_eta,
            title: 'Normal',
            color: Colors.blue,
            gwei: (info) => info.normal,
          ),
          GasCard(
            iconData: Icons.directions_walk,
            title: 'Slow',
            color: Colors.purple,
            gwei: (info) => info.slow,
          ),
        ],
      ),
    );
  }
}
