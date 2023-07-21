import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:postagecheck/src/services/ongkir_service.dart';

import '../../../home/data/model/province_model.dart';

part 'province_state.dart';

class ProvinceCubit extends Cubit<ProvinceState> {
  OngkirService service;
  ProvinceCubit(this.service) : super(ProvinceInitial());

  Future<void> fetchProvince() async {
    emit(ProvinceLoading());
    try {
      final province = await service.fetchProvince();
      emit(ProvinceLoaded(province: province));
    } catch (e) {
      emit(ProvinceError(message: e.toString()));
    }
  }
}
