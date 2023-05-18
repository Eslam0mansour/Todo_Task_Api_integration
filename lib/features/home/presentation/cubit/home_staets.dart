abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {}

class HomeErrorState extends HomeState {
  final String error;
  HomeErrorState(this.error);
}

class AddMazr3aLoadingState extends HomeState {}

class AddMazr3aSuccessState extends HomeState {}

class AddClientSuccessState extends HomeState {}

class AddMazr3aErrorState extends HomeState {}

class GetLocationDoneState extends HomeState {}

class GetLocationErrorState extends HomeState {}

class GetLocationLoadingState extends HomeState {}

class GetNewPlacesState extends HomeState {}

class GetNewPositionState extends HomeState {}

class MarkerCreatedState extends HomeState {}

class OnCameraMoveState extends HomeState {}