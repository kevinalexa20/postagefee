import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:postagecheck/src/services/ongkir_service.dart';

import '../../model/city_model.dart';

part 'city_destination_state.dart';

class CityDestinationCubit extends Cubit<CityDestinationState> {
  OngkirService service;
  CityDestinationCubit(this.service) : super(CityDestinationInitial());

  Future<void> fetchCity(String provinceId) async {
    emit(CityDestinationLoading());
    try {
      final city = await service.fetchCity(provinceId);
      print(city);
      emit(CityDestinationLoaded(city));
    } catch (e) {
      emit(CityDestinationError(e.toString()));
    }
  }
}
