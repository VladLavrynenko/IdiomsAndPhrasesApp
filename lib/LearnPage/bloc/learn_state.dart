part of 'learn_bloc.dart';

@immutable
sealed class LearnState {}

final class LearnInitial extends LearnState {}

final class LearnLoaded extends LearnState {
  final List<dynamic> list;

  LearnLoaded ({required this.list});

  @override
  List<Object> get props => [list];
}
