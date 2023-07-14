import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:postagecheck/home/data/model/city_model.dart';
import 'package:postagecheck/home/data/model/province_model.dart';

part 'province_event.dart';
part 'province_state.dart';

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  final Dio dio = Dio();
  final _provinceStreamController = StreamController<ProvinceState>();

  ProvinceBloc()
      : super(ProvinceState(provinceId: '', provinces: [], cities: [])) {
    on<UpdateProvinceIdEvent>((event, emit) async {
      emit(await _fetchProvinces(event.provinceId));
    });
  }

  Stream<ProvinceState> get provinceStream => _provinceStreamController.stream
      .asBroadcastStream()
      .asyncMap((_) => _fetchProvinces(state.provinceId));

  Future<ProvinceState> _fetchProvinces(String provinceId) async {
    try {
      final response = await dio.get(
        "https://api.rajaongkir.com/starter/province",
        queryParameters: {
          "key": "e44ab0df69347b30971185dacfa399f4",
          "province": provinceId,
        },
      );

      final provinces =
          Province.fromJsonList(response.data["rajaongkir"]["results"]);

      return state.copyWith(provinceId: provinceId, provinces: provinces);
    } catch (e) {
      // Handle error
      throw Exception("Failed to fetch provinces: $e");
    }
  }

  @override
  Stream<ProvinceState> mapEventToState(ProvinceEvent event) async* {
    if (event is UpdateProvinceIdEvent) {
      yield* _mapUpdateProvinceIdEventToState(event);
    }
  }

  Stream<ProvinceState> _mapUpdateProvinceIdEventToState(
      UpdateProvinceIdEvent event) async* {
    try {
      // Panggil API untuk mendapatkan daftar kota berdasarkan provinceId
      final response = await dio.get(
        "https://api.rajaongkir.com/starter/city?province=${event.provinceId}",
        queryParameters: {
          "key": "e44ab0df69347b30971185dacfa399f4",
        },
      );

      final cities = City.fromJsonList(response.data["rajaongkir"]["results"]);

      yield state.copyWith(provinceId: event.provinceId, cities: cities);
    } catch (e) {
      // Handle error
    }
  }

  @override
  Future<void> close() {
    _provinceStreamController.close();
    return super.close();
  }
}
















// class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
//   final Dio dio = Dio();

//   ProvinceBloc() : super(ProvinceState(provinceId: '', provinces: []));

//   @override
//   Stream<ProvinceState> mapEventToState(ProvinceEvent event) async* {
//     if (event is UpdateProvinceIdEvent) {
//       yield* _mapUpdateProvinceIdEventToState(event);
//     }
//   }

//   Stream<ProvinceState>  _mapUpdateProvinceIdEventToState(
//       UpdateProvinceIdEvent event) async* {
//     try {
//       final response = await dio.get(
//         "https://api.rajaongkir.com/starter/province",
//         queryParameters: {
//           "key": "e44ab0df69347b30971185dacfa399f4",
//           "province": event.provinceId,
//         },
//       );

//       final provinces = Province.fromJsonList(
//           response.data["rajaongkir"]["results"]);

//       yield state.copyWith(provinceId: event.provinceId, provinces: provinces);
//     } catch (e) {
//       // Handle error
//     }
//   }
// }


// class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
//   final dio = Dio();

//   // ProvinceBloc() : super(ProvinceState(provinceId: '', provinces: []));

//   ProvinceBloc() : super(ProvinceInitial(provinceId: '', provinces: [])) {
//     on<ProvinceEvent>((event, emit) {
//       // TODO: implement event handler
      
//     });
//   }
// }
