import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:postagecheck/src/controller/cubit/city_cubit.dart';
import 'package:postagecheck/src/controller/cubit/province_cubit.dart';

import '../../controller/cubit/check_cost_cubit.dart';
import '../../controller/cubit/city_destination_cubit.dart';
import '../../controller/cubit/city_origin_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TextEditingController _weightController = TextEditingController();
  TextEditingController? _weightController;
  FocusNode _weightFocusNode = FocusNode();

  bool _autoValidate = false;

  @override
  void initState() {
    super.initState();
    _weightController = TextEditingController();
    _weightFocusNode = FocusNode();
    _autoValidate = false;
    // FUNGSI YANG DIGUNAKAN UNTUK FETCH DATA PROVINCE
    context.read<ProvinceCubit>().fetchProvince();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/postagepro.svg',
          width: 245,
          height: 44,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFE3F0FE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(29.0),
        child: Column(
          children: [
            // const SizedBox(height: 10),
            Text(
              'Asal',
              style: GoogleFonts.notoSans(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF421D54),
              ),
            ),
            BlocBuilder<ProvinceCubit, ProvinceState>(
              builder: (context, state) {
                if (state is ProvinceLoaded) {
                  return DropdownSearch(
                    popupProps: const PopupProps.menu(
                      showSearchBox: true,
                    ),
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      baseStyle: TextStyle(
                        color: Color(0xFF421D54),
                        fontSize: 20,
                      ),
                      dropdownSearchDecoration: InputDecoration(
                        label: Text("Provinsi"),
                        // labelText: "Provinsi",
                        labelStyle: TextStyle(
                          color: Color(0xFF421D54),
                          fontSize: 16,
                        ),
                        hintText: "Silahkan pilih provinsi ...",
                        hintStyle: TextStyle(
                          color: Color(0xFF421D54),
                          fontSize: 16,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFC94A38),
                          ),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      if (value != null) {
                        context
                            .read<CityOriginCubit>()
                            .fetchCityOrigin(value.provinceId!);
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
            BlocBuilder<CityOriginCubit, CityOriginState>(
              builder: (context, state) {
                if (state is CityOriginLoaded) {
                  return DropdownSearch(
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      baseStyle: TextStyle(
                        color: Color(0xFF421D54),
                        fontSize: 20,
                      ),
                      dropdownSearchDecoration: InputDecoration(
                        labelText: "Kota/Kabupaten",
                        hintText: "Silahkan pilih kota/kabupaten ... ",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFC94A38),
                          ),
                        ),
                      ),
                    ),
                    items: state.cityOrigin.map((e) => e.cityName).toList(),
                  );
                }
                if (state is CityOriginLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is CityOriginError) {
                  return Text(state.message);
                }
                return const Center(
                  child: SizedBox(),
                );
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Tujuan',
              style: GoogleFonts.notoSans(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF421D54),
              ),
            ),
            BlocBuilder<ProvinceCubit, ProvinceState>(
              builder: (context, state) {
                if (state is ProvinceLoaded) {
                  return DropdownSearch(
                    popupProps: const PopupProps.menu(
                      showSearchBox: true,
                    ),
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      baseStyle: TextStyle(
                        color: Color(0xFF421D54),
                        fontSize: 20,
                      ),
                      dropdownSearchDecoration: InputDecoration(
                        label: Text("Provinsi"),
                        // labelText: "Provinsi",
                        labelStyle: TextStyle(
                          color: Color(0xFF421D54),
                          fontSize: 16,
                        ),
                        hintText: "Silahkan pilih provinsi ...",
                        hintStyle: TextStyle(
                          color: Color(0xFF421D54),
                          fontSize: 16,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFC94A38),
                          ),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      if (value != null) {
                        context
                            .read<CityDestinationCubit>()
                            .fetchCity(value.provinceId!);
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
            BlocBuilder<CityDestinationCubit, CityDestinationState>(
              builder: (context, state) {
                if (state is CityDestinationLoaded) {
                  return DropdownSearch(
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      baseStyle: TextStyle(
                        color: Color(0xFF421D54),
                        fontSize: 20,
                      ),
                      dropdownSearchDecoration: InputDecoration(
                        labelText: "Kota/Kabupaten",
                        hintText: "Silahkan pilih kota/kabupaten ... ",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFC94A38),
                          ),
                        ),
                      ),
                    ),
                    items:
                        state.cityDestination.map((e) => e.cityName).toList(),
                  );
                }
                if (state is CityDestinationLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is CityDestinationError) {
                  return Text(state.message);
                }
                return const Center(
                  child: SizedBox(),
                );
              },
            ),
            const SizedBox(height: 30),
            Text(
              'Berat (gram)',
              style: GoogleFonts.notoSans(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF421D54),
              ),
            ),

            Form(
              autovalidateMode: _autoValidate
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              child: TextFormField(
                controller: _weightController,
                focusNode: _weightFocusNode,
                decoration: const InputDecoration(
                  labelText: "Berat",
                  hintText: "Masukkan berat paket ... ",
                  suffixText: "gram",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFC94A38),
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),

            const SizedBox(height: 30),
            DropdownSearch<Map<String, dynamic>>(
              items: const [
                {
                  "code": "JNE",
                  "name": "Jalur Nugraha Ekakurir (JNE)",
                },
                {
                  "code": "POS",
                  "name": "POS Indonesia (POS)",
                },
                {
                  "code": "TIKI",
                  "name": "Citra Van Titipan Kilat (TIKI)",
                }
              ],
              popupProps: PopupProps.menu(
                showSearchBox: true,
                itemBuilder: (context, dynamic item, bool isSelected) {
                  return ListTile(
                    selected: isSelected,
                    title: Text(item['name']),
                  );
                },
              ),
              dropdownDecoratorProps: const DropDownDecoratorProps(
                baseStyle: TextStyle(
                  color: Color(0xFF421D54),
                  fontSize: 20,
                ),
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Kurir",
                  hintText: "Silahkan pilih kurir ... ",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFC94A38),
                    ),
                  ),
                ),
              ),
              dropdownBuilder: (context, dynamic selectedItem) {
                return Text(
                  (selectedItem != null ? selectedItem['name'] : ""),
                  style: const TextStyle(
                    color: Color(0xFF421D54),
                    fontSize: 20,
                  ),
                );
              },
            ),
            const SizedBox(height: 13),
            BlocBuilder<CheckCostCubit, CheckCostState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFC94A38),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(400, 50),
                  ),
                  child: Text(
                    'Cek Ongkir',
                    style: GoogleFonts.notoSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFE3F0FE),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
