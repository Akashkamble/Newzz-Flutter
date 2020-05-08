import 'package:bloc/bloc.dart';

class HomeBloc extends Bloc<HomePageEvent, int> {
  @override
  get initialState => 0;

  @override
  Stream<int> mapEventToState(HomePageEvent event) async* {
    if (event is UpdatePageEvent) {
      yield event.index;
    }
  }

}

abstract class HomePageEvent {
  const HomePageEvent();
}

class UpdatePageEvent extends HomePageEvent {
  final int index;

  const UpdatePageEvent({
    this.index,
  });

  UpdatePageEvent copyWith({
    int index,
  }) {
    return UpdatePageEvent(
      index: index ?? this.index,
    );
  }
}