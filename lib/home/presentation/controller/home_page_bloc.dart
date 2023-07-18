import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:postagecheck/home/data/model/city_model.dart';
import 'package:postagecheck/home/data/model/province_model.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc()
      : super(HomePageState(
            provFromId: '', cityFromId: '', provToId: '', cityToId: ''));

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    if (event is UpdateProvFromIdEvent) {
      yield state.copyWith(provFromId: event.provFromId);
    } else if (event is UpdateCityFromIdEvent) {
      yield state.copyWith(cityFromId: event.cityFromId);
    } else if (event is UpdateProvToIdEvent) {
      yield state.copyWith(provToId: event.provToId);
    } else if (event is UpdateCityToIdEvent) {
      yield state.copyWith(cityToId: event.cityToId);
    }
  }
}

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeState());
  final dio = Dio();

  void selectProvince(Province province) {
    emit(state.copyWith(selectedProvince: province));
    loadCities(province.provinceId!);
  }

  void loadCities(String provinceId) async {
    try {
      final response = await dio.get(
        "https://api.rajaongkir.com/starter/city?province=$provinceId",
        queryParameters: {
          "key": "e44ab0df69347b30971185dacfa399f4",
        },
      );

      final cities = City.fromJsonList(response.data["rajaongkir"]["results"]);
      emit(state.copyWith(cities: cities));
    } catch (e) {
      // Handle error jika ada
    }
  }
}

class HomeState {
  final List<Province> provinces;
  final List<City> cities;
  final Province? selectedProvince;

  HomeState({
    this.provinces = const [],
    this.cities = const [],
    this.selectedProvince,
  });

  HomeState copyWith({
    List<Province>? provinces,
    List<City>? cities,
    Province? selectedProvince,
  }) {
    return HomeState(
      provinces: provinces ?? this.provinces,
      cities: cities ?? this.cities,
      selectedProvince: selectedProvince ?? this.selectedProvince,
    );
  }
}
