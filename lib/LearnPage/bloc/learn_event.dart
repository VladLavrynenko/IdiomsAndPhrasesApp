part of 'learn_bloc.dart';

@immutable
sealed class LearnEvent {}

class LoadLearnIdioms extends LearnEvent{}

class LoadedLearnIdioms extends LearnEvent{
  final List<dynamic> list;

  LoadedLearnIdioms ({required this.list});

  @override
  List<Object> get props => [list];
}

class ChangeModeLearnIdioms extends LearnEvent{
  final List<dynamic> list;

  ChangeModeLearnIdioms ({required this.list});

  @override
  List<Object> get props => [list];
}
