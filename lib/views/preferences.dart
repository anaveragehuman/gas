import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/pref_cubit.dart';

class PrefPage extends StatelessWidget {
  PrefPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onWillPop: () async {
        _formKey.currentState!
          ..validate()
          ..save();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Preferences'),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
          child: Column(
            children: const [
              _RefreshRateCard(),
              _EtherscanKeyCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class PrefCard<T> extends StatelessWidget {
  final Icon icon;
  final Text Function(T?) title;
  final Text Function(T?)? subtitle;
  final T? Function(PrefState) initialValue;
  final void Function(PrefCubit, T?) onSaved;
  final Widget Function(FormFieldState<T>) trailing;

  const PrefCard({
    Key? key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.initialValue,
    required this.onSaved,
    required this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: BlocBuilder<PrefCubit, PrefState>(
        builder: (BuildContext context, state) {
          return FormField<T>(
            initialValue: initialValue(state),
            onSaved: (newValue) => onSaved(context.read<PrefCubit>(), newValue),
            builder: (field) {
              return ListTile(
                leading: SizedBox(
                  height: 48,
                  width: 32,
                  child: icon,
                ),
                title: title(field.value),
                subtitle: subtitle?.call(field.value),
                trailing: SizedBox(
                  width: 256,
                  child: trailing(field),
                ),
              );
            },
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
    return PrefCard<int>(
      icon: const Icon(Icons.alarm),
      title: (_) => const Text('Refresh every'),
      subtitle: (value) => Text('$value seconds'),
      initialValue: (state) => state.refreshRate,
      onSaved: (prefCubit, newValue) => prefCubit.setRefreshRate(newValue!),
      trailing: (state) => Slider(
        value: state.value!.toDouble(),
        min: 5,
        max: 60,
        onChanged: (newValue) => state.didChange(newValue.toInt()),
      ),
    );
  }
}

class _EtherscanKeyCard extends StatefulWidget {
  const _EtherscanKeyCard({Key? key}) : super(key: key);

  @override
  State<_EtherscanKeyCard> createState() => _EtherscanKeyCardState();
}

class _EtherscanKeyCardState extends State<_EtherscanKeyCard> {
  bool initialized = false;
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      _controller.text = context.read<PrefCubit>().state.etherscanKey ?? '';
      initialized = true;
    }

    return PrefCard<String>(
      icon: const Icon(Icons.vpn_key),
      title: (_) => const Text('API Key'),
      subtitle: (_) => const Text('Etherscan'),
      initialValue: (_) => null,
      onSaved: (prefCubit, _) {
        final text = _controller.text;
        prefCubit.setEtherscanKey(text.isEmpty ? null : text);
      },
      trailing: (_) => TextField(
        controller: _controller,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[A-Z\d]')),
        ],
        textCapitalization: TextCapitalization.characters,
        decoration: const InputDecoration(
          isDense: true,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
