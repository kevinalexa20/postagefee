part of 'home_page_bloc.dart';

abstract class HomePageEvent {}

class UpdateProvFromIdEvent extends HomePageEvent {
  final String provFromId;

  UpdateProvFromIdEvent(this.provFromId);
}

class UpdateCityFromIdEvent extends HomePageEvent {
  final String cityFromId;

  UpdateCityFromIdEvent(this.cityFromId);
}

class UpdateProvToIdEvent extends HomePageEvent {
  final String provToId;

  UpdateProvToIdEvent(this.provToId);
}

class UpdateCityToIdEvent extends HomePageEvent {
  final String cityToId;

  UpdateCityToIdEvent(this.cityToId);
}
