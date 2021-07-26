import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/gas_cubit.dart';
import 'bloc/timer_cubit.dart';
import 'views/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final TimerCubit _timer = TimerCubit(5);

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _timer),
        BlocProvider(create: (_) => GasCubit(_timer)),
      ],
      child: MaterialApp(
        title: 'Gas Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
        ),
        home: const DashboardPage(),
      ),
    );
  }
}
