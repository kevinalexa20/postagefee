part of 'province_bloc.dart';

@immutable
abstract class ProvinceEvent {}

class UpdateProvinceIdEvent extends ProvinceEvent {
  final String provinceId;

  UpdateProvinceIdEvent(this.provinceId);
}
