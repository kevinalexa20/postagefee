part of 'city_destination_cubit.dart';

abstract class CityDestinationState {
  // const CityDestinationState();

  // @override
  // List<Object> get props => [];
}

class CityDestinationInitial extends CityDestinationState {}

class CityDestinationLoading extends CityDestinationState {}

class CityDestinationLoaded extends CityDestinationState {
  final List<CityModel> cityDestination;

  CityDestinationLoaded(this.cityDestination);
}

class CityDestinationError extends CityDestinationState {
  final String message;

  CityDestinationError(this.message);
}
