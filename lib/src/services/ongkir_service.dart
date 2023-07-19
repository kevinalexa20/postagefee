import 'package:dio/dio.dart';
import 'package:postagecheck/src/config/dio_client.dart';
import 'package:postagecheck/src/model/city_model.dart';

import '../../home/data/model/province_model.dart';

class OngkirService {
  Future<List<ProvinceModel>> fetchProvince() async {
    // ...
    try {
      final response = await dioClient.get('/province');
      final data = response.data['rajaongkir']['results'] as List;
      return data.map((e) => ProvinceModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<CityModel>> fetchCity(String provinceId) async {
    // ...
    try {
      final response = await dioClient.get('/city?province=$provinceId');
      final data = response.data['rajaongkir']['results'] as List;
      return data.map((e) => CityModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
