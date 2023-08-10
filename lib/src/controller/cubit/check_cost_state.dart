part of 'check_cost_cubit.dart';

abstract class CheckCostState extends Equatable {
  const CheckCostState();

  @override
  List<Object> get props => [];
}

class CheckCostInitial extends CheckCostState {}

class CheckCostLoading extends CheckCostState {
  const CheckCostLoading({
    required this.isLoading,
  });

  final bool isLoading;

  @override
  List<Object> get props => [isLoading];
}

class CheckCostLoaded extends CheckCostState {
  CheckCostLoaded(this.cost);

  final Map<String, dynamic> cost;

  @override
  List<Object> get props => [cost];
}

class CheckCostError extends CheckCostState {
  CheckCostError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
