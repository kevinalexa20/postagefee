import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:postagecheck/src/services/ongkir_service.dart';

import '../../model/city_model.dart';

part 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  OngkirService service;
  CityCubit(this.service) : super(CityInitial());

  Future<void> fetchCity(String provinceId) async {
    emit(CityLoading());
    try {
      final city = await service.fetchCity(provinceId);
      print(city);
      emit(CityLoaded(city));
    } catch (e) {
      emit(CityError(e.toString()));
    }
  }
}
