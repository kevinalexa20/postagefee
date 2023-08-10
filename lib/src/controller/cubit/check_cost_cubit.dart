import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:postagecheck/src/services/ongkir_service.dart';

import '../../model/cost_request_model.dart';

part 'check_cost_state.dart';

class CheckCostCubit extends Cubit<CheckCostState> {
  OngkirService service;
  CheckCostCubit(this.service) : super(CheckCostInitial());

  Future<void> getCosts(CostRequestModel requestModel) async {
    emit(CheckCostLoading(isLoading: true));
    try {
      final response = await service.checkCost(
        requestModel.origin,
        requestModel.destination,
        requestModel.weight,
        requestModel.courier,
      );
      if (response['code'] == 200) {
        emit(CheckCostLoaded(response['results'][0]['costs'][0]));
      } else {
        emit(CheckCostError(response['message']));
      }
    } catch (e) {
      emit(CheckCostError(e.toString()));
    }
  }

  // Future<void> getCosts(CostRequestModel requestModel, {required origin}) async {
  //   emit(CheckCostLoading(isLoading: true));
  //   try {
  //     final response = await service.checkCost(
  //       requestModel.origin,
  //       requestModel.destination,
  //       requestModel.weight,
  //       requestModel.courier,
  //     );
  //     if (response['code'] == 200) {
  //       emit(CheckCostLoaded(response['results'][0]['costs'][0]));
  //     } else {
  //       emit(CheckCostError(response['message']));
  //     }
  //   } catch (e) {
  //     emit(CheckCostError(e.toString()));
  //   }
  // }
}
