part of 'province_bloc.dart';

class ProvinceState {
  final String provinceId;
  final List<ProvinceModel> provinces;
  final List<City> cities;

  const ProvinceState(
      {required this.provinceId,
      required this.provinces,
      required this.cities});

  // copyWith({required String provinceId, required List<Province> provinces}) {}

  ProvinceState copyWith({
    String? provinceId,
    List<ProvinceModel>? provinces,
    List<City>? cities,
  }) {
    return ProvinceState(
      provinceId: provinceId ?? this.provinceId,
      provinces: provinces ?? this.provinces,
      cities: cities ?? this.cities,
    );
  }
}

// class ProvinceInitial extends ProvinceState {
//   ProvinceInitial({required super.provinceId, required super.provinces});
// }
