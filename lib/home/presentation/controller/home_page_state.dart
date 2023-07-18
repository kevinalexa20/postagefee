part of 'home_page_bloc.dart';

class HomePageState {
  final String provFromId;
  final String cityFromId;
  final String provToId;
  final String cityToId;

  HomePageState({
    required this.provFromId,
    required this.cityFromId,
    required this.provToId,
    required this.cityToId,
  });

  HomePageState copyWith({
    String? provFromId,
    String? cityFromId,
    String? provToId,
    String? cityToId,
  }) {
    return HomePageState(
      provFromId: provFromId ?? this.provFromId,
      cityFromId: cityFromId ?? this.cityFromId,
      provToId: provToId ?? this.provToId,
      cityToId: cityToId ?? this.cityToId,
    );
  }
}

// class HomePageInitial extends HomePageState {

// }

// class HomePageState {
//   final String provFromId;
//   final String cityFromId;
//   final String provToId;
//   final String cityToId;

//   HomePageState({
//     required this.provFromId,
//     required this.cityFromId,
//     required this.provToId,
//     required this.cityToId,
//   });
// }
