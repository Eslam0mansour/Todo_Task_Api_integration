
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/features/home/cubit/home_staets.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

}
