import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postagecheck/src/controller/cubit/city_cubit.dart';
import 'package:postagecheck/src/controller/cubit/province_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // FUNGSI YANG DIGUNAKAN UNTUK FETCH DATA PROVINCE
    context.read<ProvinceCubit>().fetchProvince();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Postage Check'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BlocBuilder<ProvinceCubit, ProvinceState>(
              builder: (context, state) {
                if (state is ProvinceLoaded) {
                  return DropdownSearch(
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: "Provinsi",
                        hintText: "Silahkan pilih provinsi ...",
                      ),
                    ),
                    onChanged: (value) {
                      if (value != null) {
                        context.read<CityCubit>().fetchCity(value.provinceId!);
                      }
                    },
                    itemAsString: (item) => item.province!,
                    items: state.province.map((e) => e).toList(),
                  );
                }
                if (state is ProvinceError) {
                  return Text(state.message);
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<CityCubit, CityState>(
              builder: (context, state) {
                if (state is CityLoaded) {
                  return DropdownSearch(
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: "Kota/Kabupaten",
                        hintText: "Silahkan pilih kota/kabupaten ... ",
                      ),
                    ),
                    items: state.city.map((e) => e.cityName).toList(),
                  );
                }
                if (state is CityLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is CityError) {
                  return Text(state.message);
                }
                return const Center(
                  child: SizedBox(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
