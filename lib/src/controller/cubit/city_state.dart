part of 'city_cubit.dart';

@immutable
abstract class CityState {}

class CityInitial extends CityState {}

class CityLoading extends CityState {}

class CityLoaded extends CityState {
  final List<CityModel> city;

  CityLoaded(this.city);
}

class CityError extends CityState {
  final String message;

  CityError(this.message);
}
