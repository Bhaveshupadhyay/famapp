abstract class DataState{}

class DataInitial extends DataState{}

class DataLoading extends DataState{}

class DataLoaded<T> extends DataState{
  final T data;

  DataLoaded({required this.data});
}

class DataFailed extends DataState{
  final String errorMsg;

  DataFailed({required this.errorMsg});
}