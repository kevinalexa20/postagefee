import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import "package:dio/dio.dart";

import '../../data/models/province_model.dart';

class HomePage extends StatelessWidget {
  final dio = Dio();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Postage Pro'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            DropdownSearch<Province>(
              items: const [],
              popupProps: PopupProps.menu(
                itemBuilder: (context, item, isSelected) =>
                    ListTile(title: Text("${item.province}")),
              ),
              itemAsString: (item) => item.province!,
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration:
                    InputDecoration(hintText: 'Select Province ...'),
              ),
              asyncItems: (String filter) async {
                final response = await dio.get(
                  "https://api.rajaongkir.com/starter/province",
                  queryParameters: {
                    "filter": filter,
                    "key": "e44ab0df69347b30971185dacfa399f4",
                  },
                );

                return Province.fromJsonList(
                    response.data["rajaongkir"]["results"]);
              },
            ),
          ],
        ));
  }
}
