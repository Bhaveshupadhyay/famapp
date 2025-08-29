import 'package:flutter_bloc/flutter_bloc.dart';

class SliderCubit extends Cubit<bool>{
  SliderCubit() : super(false);

  void changeSliderState(){
    emit(!state);
  }
}