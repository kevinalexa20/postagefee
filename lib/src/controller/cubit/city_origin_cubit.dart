import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:postagecheck/src/services/ongkir_service.dart';

import '../../model/city_model.dart';

part 'city_origin_state.dart';

class CityOriginCubit extends Cubit<CityOriginState> {
  OngkirService service;
  CityOriginCubit(this.service) : super(CityOriginInitial());

  Future<void> fetchCityOrigin(String provinceId) async {
    emit(CityOriginLoading());
    try {
      final cityOrigin = await service.fetchCity(provinceId);
      print(cityOrigin);
      emit(CityOriginLoaded(cityOrigin));
    } catch (e) {
      emit(CityOriginError(e.toString()));
    }
  }
}
