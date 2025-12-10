abstract class HomeEvent {}

class LoadEvent extends HomeEvent {
  final String city;
  LoadEvent(this.city);
}

class AddCityEvent extends HomeEvent {
  final String cityName;
  AddCityEvent(this.cityName);
}
