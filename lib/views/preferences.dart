import 'package:flutter/material.dart';

class PrefPage extends StatelessWidget {
  const PrefPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferences'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        child: Column(
          children: const [
            _RefreshRateCard(),
          ],
        ),
      ),
    );
  }
}

class PrefCard extends StatelessWidget {
  final Icon icon;
  final Text title;
  final Text? subtitle;
  final Widget trailing;

  const PrefCard({
    Key? key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: SizedBox(
          height: 48,
          width: 32,
          child: icon,
        ),
        title: title,
        subtitle: subtitle,
        trailing: SizedBox(
          width: 256,
          child: trailing,
        ),
      ),
    );
  }
}

class _RefreshRateCard extends StatelessWidget {
  const _RefreshRateCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrefCard(
      icon: const Icon(Icons.alarm),
      title: const Text('Refresh every'),
      subtitle: const Text('5 seconds'),
      trailing: Slider(
        value: 5,
        min: 5,
        max: 60,
        onChanged: (_) {},
      ),
    );
  }
}
