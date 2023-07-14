import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_bloc_state.dart';

class HomeBlocCubit extends Cubit<HomeBlocState> {
  HomeBlocCubit() : super(HomeBlocInitial());
}
