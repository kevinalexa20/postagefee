import 'dart:async';
import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import "package:dio/dio.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postagecheck/home/data/model/city_model.dart';
import 'package:postagecheck/home/data/model/province_model.dart';

import '../controller/province/bloc/province_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProvinceBloc _provinceBloc = ProvinceBloc();
  final dio = Dio();

  @override
  void dispose() {
    _provinceBloc.close();
    super.dispose();
  }

  // StreamController<List<Province>> _provinceStreamController =
  //     StreamController<List<Province>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Postage Pro'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text('From',
                style: TextStyle(
                  fontSize: 24,
                )),
            const SizedBox(height: 15),
            BlocBuilder<ProvinceBloc, ProvinceState>(
              bloc: _provinceBloc,
              builder: (context, state) {
                return DropdownSearch<Province>(
                  items: state.provinces,
                  // items: const [],
                  popupProps: PopupProps.menu(
                    itemBuilder: (context, item, isSelected) =>
                        ListTile(title: Text("${item.province}")),
                    showSearchBox: true,
                  ),
                  itemAsString: (item) => item.province!,
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      hintText: 'Select Province ...',
                      // suffixIcon: Icon(Icons.search),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                    ),
                  ),

                  asyncItems: (String filter) async {
                    final response = await dio.get(
                      "https://api.rajaongkir.com/starter/province",
                      queryParameters: {
                        "key": "e44ab0df69347b30971185dacfa399f4",
                      },
                    );

                    final provinces = Province.fromJsonList(
                        response.data["rajaongkir"]["results"]);

                    return provinces;
                  },

                  // asyncItems: (String filter) async {
                  //   _provinceBloc.add(UpdateProvinceIdEvent(filter));
                  //   final state = await _provinceBloc.provinceStream.first;
                  //   return state.provinces;
                  // },
                );
              },
            ),
            SizedBox(height: 20),
            BlocBuilder<ProvinceBloc, ProvinceState>(
              bloc: _provinceBloc,
              builder: (context, state) {
                return DropdownSearch<City>(
                    items: const [],
                    popupProps: PopupProps.menu(
                      itemBuilder: (context, item, isSelected) => ListTile(
                          title: Text("${item.type} ${item.cityName}")),
                      showSearchBox: true,
                    ),
                    itemAsString: (item) => item.cityName!,
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        hintText: 'Select City ...',
                        // suffixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                      ),
                    ),
                    asyncItems: (String filter) async {
                      final response = await dio.get(
                        "https://api.rajaongkir.com/starter/city?province=${state.provinceId}",
                        queryParameters: {
                          "key": "e44ab0df69347b30971185dacfa399f4",
                        },
                      );

                      return City.fromJsonList(
                          response.data["rajaongkir"]["results"]);
                    }

                    // asyncItems: (String filter) async {
                    //   if (state.provinceId.isNotEmpty) {
                    //     final response = await dio.get(
                    //       "https://api.rajaongkir.com/starter/city?province=${state.provinceId}",
                    //       queryParameters: {
                    //         "key": "e44ab0df69347b30971185dacfa399f4",
                    //       },
                    //     );

                    //     return City.fromJsonList(
                    //         response.data["rajaongkir"]["results"]);
                    //   }

                    //   return [];
                    // },

                    // asyncItems: (String filter) async {
                    //   final response = await dio.get(
                    //     "https://api.rajaongkir.com/starter/city?province=${state.provinceId}",
                    //     queryParameters: {
                    //       "key": "e44ab0df69347b30971185dacfa399f4",
                    //     },
                    //   );

                    //   return City.fromJsonList(
                    //       response.data["rajaongkir"]["results"]);
                    // },
                    );
              },
            ),
            SizedBox(height: 55),
            const Text('To',
                style: TextStyle(
                  fontSize: 24,
                )),
            const SizedBox(height: 15),
            BlocBuilder<ProvinceBloc, ProvinceState>(
              bloc: _provinceBloc,
              builder: (context, state) {
                return DropdownSearch<Province>(
                  items: state.provinces,
                  // items: const [],
                  popupProps: PopupProps.menu(
                    itemBuilder: (context, item, isSelected) =>
                        ListTile(title: Text("${item.province}")),
                    showSearchBox: true,
                  ),
                  itemAsString: (item) => item.province!,
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      hintText: 'Select Province ...',
                      // suffixIcon: Icon(Icons.search),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                    ),
                  ),
                  asyncItems: (String filter) async {
                    _provinceBloc.add(UpdateProvinceIdEvent(filter));
                    final state = await _provinceBloc.provinceStream.first;
                    return state.provinces;
                  },
                );
              },
            ),
            SizedBox(height: 20),
            BlocBuilder<ProvinceBloc, ProvinceState>(
              bloc: _provinceBloc,
              builder: (context, state) {
                return DropdownSearch<City>(
                  items: const [],
                  popupProps: PopupProps.menu(
                    itemBuilder: (context, item, isSelected) =>
                        ListTile(title: Text("${item.type} ${item.cityName}")),
                    showSearchBox: true,
                  ),
                  itemAsString: (item) => item.cityName!,
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      hintText: 'Select City ...',
                      // suffixIcon: Icon(Icons.search),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                    ),
                  ),
                  asyncItems: (String filter) async {
                    final response = await dio.get(
                      "https://api.rajaongkir.com/starter/city?province=${state.provinceId}",
                      queryParameters: {
                        "key": "e44ab0df69347b30971185dacfa399f4",
                      },
                    );

                    return City.fromJsonList(
                        response.data["rajaongkir"]["results"]);
                  },
                );
              },
            ),
            SizedBox(height: 55),
            const Text('Select Courier',
                style: TextStyle(
                  fontSize: 24,
                )),
            const SizedBox(height: 15),
            BlocBuilder<ProvinceBloc, ProvinceState>(
              bloc: _provinceBloc,
              builder: (context, state) {
                return DropdownSearch<Province>(
                  items: state.provinces,
                  // items: const [],
                  popupProps: PopupProps.menu(
                    itemBuilder: (context, item, isSelected) =>
                        ListTile(title: Text("${item.province}")),
                    showSearchBox: true,
                  ),
                  itemAsString: (item) => item.province!,
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      hintText: 'Select Province ...',
                      // suffixIcon: Icon(Icons.search),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                    ),
                  ),
                  asyncItems: (String filter) async {
                    _provinceBloc.add(UpdateProvinceIdEvent(filter));
                    final state = await _provinceBloc.provinceStream.first;
                    return state.provinces;
                  },
                );
              },
            ),
          ],
        ));
  }
}

//homepage controller nya belom selesai