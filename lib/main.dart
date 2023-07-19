import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postagecheck/src/controller/cubit/city_cubit.dart';
import 'package:postagecheck/src/services/ongkir_service.dart';

import 'core/utils/routes.dart';
import 'home/presentation/controller/home_page_bloc.dart';
import 'home/presentation/controller/province/bloc/province_bloc.dart';
import 'src/controller/cubit/province_cubit.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(),
        ),
        BlocProvider<ProvinceBloc>(
          create: (_) => ProvinceBloc(),
        ),
        // TODO: Menambahkan 2 CUBIT
        BlocProvider(
          create: (context) => ProvinceCubit(OngkirService()),
        ),
        BlocProvider(
          create: (context) => CityCubit(OngkirService()),
        ),
        BlocProvider<HomePageBloc>(
          create: (_) => HomePageBloc(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: appRouter,
      ),
    );
  }
}
