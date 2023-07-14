part of 'province_bloc.dart';

@immutable
class ProvinceState {
  final String provinceId;
  final List<Province> provinces;

  ProvinceState({required this.provinceId, required this.provinces});

  // copyWith({required String provinceId, required List<Province> provinces}) {}

  ProvinceState copyWith({
    String? provinceId,
    List<Province>? provinces,
  }) {
    return ProvinceState(
      provinceId: provinceId ?? this.provinceId,
      provinces: provinces ?? this.provinces,
    );
  }
}

// class ProvinceInitial extends ProvinceState {
//   ProvinceInitial({required super.provinceId, required super.provinces});
// }
