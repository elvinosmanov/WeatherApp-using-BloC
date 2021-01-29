import 'package:bloc/bloc.dart';
import 'package:demo/data/model/weather.dart';
import 'package:demo/data/weather_repository.dart';
import 'package:equatable/equatable.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;
  WeatherCubit(this._weatherRepository) : super(WeatherInitial());

  Future<void> getWeather(String cityName) async {
    try {
      emit(WeatherLoading());
      Weather weather = await _weatherRepository.fetchWeather(cityName);
      emit(WeatherLoaded(weather));
    } on NetworkException {
      emit(WeatherError('Could not fetcher.... Are you online?'));
    }
  }
}
