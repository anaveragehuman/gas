import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/pref_cubit.dart';

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
  final Text Function(PrefState) title;
  final Text Function(PrefState)? subtitle;
  final Widget Function(PrefState) trailing;

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
      child: BlocBuilder<PrefCubit, PrefState>(
        builder: (BuildContext context, state) {
          return ListTile(
            leading: SizedBox(
              height: 48,
              width: 32,
              child: icon,
            ),
            title: title(state),
            subtitle: subtitle?.call(state),
            trailing: SizedBox(
              width: 256,
              child: trailing(state),
            ),
          );
        },
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
      title: (_) => const Text('Refresh every'),
      subtitle: (state) => Text('${state.refreshRate} seconds'),
      trailing: (state) => Slider(
        value: state.refreshRate.toDouble(),
        min: 5,
        max: 60,
        onChanged: (double newValue) {
          context.read<PrefCubit>().setRefreshRate(newValue.round());
        },
      ),
    );
  }
}
