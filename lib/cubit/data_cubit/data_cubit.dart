import 'package:fampay/data/datasource/remote_db/api.dart';
import 'package:fampay/cubit/data_cubit/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/famx_page.dart';

class DataCubit extends Cubit<DataState>{
  DataCubit():super(DataInitial());

  Future<void> loadData() async {
    emit(DataLoading());
    try{
      List<FamxPayPage> list = await Api().fetchCards();
      if(isClosed) return;

      emit(DataLoaded<List<FamxPayPage>>(data: list));
    }
    catch(e){
      if(isClosed) return;
      emit(DataFailed(errorMsg: e.toString()));
    }
  }


}