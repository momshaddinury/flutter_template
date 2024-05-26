abstract base class UseCase<Response, Request> {
  Future<Response> call(Request request);
}
