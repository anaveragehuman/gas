import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'bloc/gas_cubit.dart';
import 'bloc/pref_cubit.dart';
import 'bloc/timer_cubit.dart';
import 'views/dashboard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final PrefCubit _prefs = PrefCubit();
  static final TimerCubit _timer = TimerCubit(_prefs);

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _prefs),
        BlocProvider(create: (_) => _timer),
        BlocProvider(create: (_) => GasCubit(_prefs, _timer)),
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
