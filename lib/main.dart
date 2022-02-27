import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_track/user_page/bloc/cuentas_bloc.dart';

import 'user_page/bloc/picture_bloc.dart';
import 'user_page/profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FeatureDiscovery(
      recordStepsInSharedPreferences: false,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) {
              return PictureBloc();
            },
          ),
          BlocProvider(
            create: (BuildContext context) {
              return CuentasBloc()..add(LoadEvent());
            },
          ),
        ],
        child: MaterialApp(
          home: Profile(),
        ),
      ),
    );
  }
}
