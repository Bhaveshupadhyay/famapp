import 'package:fampay/data/datasource/local_db/local_db.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/saved_card.dart';

class SavedCardCubit extends Cubit<SavedCardState>{
  SavedCardCubit():super(SavedCardInitial());

  bool _isAppReloaded=true;

  Future<void> loadSavedCard({required int cardId}) async {
    emit(SavedCardLoading());
    final card= await LocalDb.instance.getCard(cardId);
    if(card!=null){
      emit(SavedCardLoaded(savedCard: card,isAppReloaded: _isAppReloaded));
    }
    else{
      emit(SavedCardNotExist());
    }
    _isAppReloaded=false;
  }

  Future<void> saveCard({required SavedCard saveCard}) async {
    final localDb=LocalDb.instance;
    await localDb.upsertCard(saveCard);
    final updatedSavedCard= await localDb.getCard(saveCard.cardId);
    if(updatedSavedCard!=null){
      emit(SavedCardLoaded(savedCard: updatedSavedCard,isAppReloaded: _isAppReloaded));
    }
    _isAppReloaded=false;
  }


  @override
  Future<void> close() {
    LocalDb.instance.close();
    return super.close();
  }
}

sealed class SavedCardState{}

class SavedCardInitial extends SavedCardState{}
class SavedCardLoading extends SavedCardState{}
class SavedCardLoaded extends SavedCardState{
  final SavedCard savedCard;
  final bool isAppReloaded;

  SavedCardLoaded({required this.savedCard,required this.isAppReloaded,});
}
class SavedCardNotExist extends SavedCardState{}
class SavedCardSaved extends SavedCardState{
  final SavedCard savedCard;

  SavedCardSaved({required this.savedCard});
}