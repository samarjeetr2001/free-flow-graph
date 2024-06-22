enum DataRetrievalStatus {
  loading,
  loaded,
  error;

  bool get hasError => this == error;
  bool get isLoading => this == loading;
}
