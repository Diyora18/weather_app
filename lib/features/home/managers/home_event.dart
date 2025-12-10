

sealed class HomeEvent{}

class LoadEvent extends HomeEvent{
  final String city;

  LoadEvent(this.city);

}