enum Status { initial, loading, success, error }

extension StatusExtension on Status {
  bool get isInitial => this == .initial;
  bool get isLoading => this == .loading;
  bool get isSuccess => this == .success;
  bool get isError => this == .error;
}
