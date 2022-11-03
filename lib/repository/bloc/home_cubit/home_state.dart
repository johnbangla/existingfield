part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
    List<Object> get props => [];
}

class HomeInitialState extends HomeState { }

class HomeLoadingState extends HomeState { }

class HomeLoadedState extends HomeState {
  final Module module;

  HomeLoadedState(this.module);

  @override
  List<Object> get props => [module];

}

class HomeErrorState extends HomeState {
    final error;

    HomeErrorState(this.error);

    @override
    List<Object> get props => [error];
}
