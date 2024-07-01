import 'package:bloc/bloc.dart';
import 'package:idioms_and_phrases/model/ScreensModes.dart';
import 'package:meta/meta.dart';

part 'learn_event.dart';
part 'learn_state.dart';

class LearnBloc extends Bloc<LearnEvent, LearnState> {
  LearnBloc() : super(LearnInitial()) {
    on<LoadLearnIdioms>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(LearnLoaded(list: <dynamic>[]));
    });

    on<LoadedLearnIdioms>((event, emit) {
      if (state is LearnLoaded) {
        final currentState = state as LearnLoaded;
        print("EVENT: LoadedLearnIdioms");
        print(event.list);
        emit(LearnLoaded(list: event.list));
      }
    });

    on<ChangeModeLearnIdioms>((event, emit) {
      if (state is LearnLoaded) {
        final currentState = state as LearnLoaded;
        emit(LearnLoaded(list: event.list));
      }
    });
  }
}

