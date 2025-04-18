abstract class Failure {
  const Failure(
    this.name,
    this.code,
    this.error,
  );

  final String? name;
  final String? code;
  final dynamic error;

  @override
  String toString() {
    return {
      'name': name,
      'code': code,
      'error': error,
    }.toString();
  }
}

/// Client Error Responses
class BadRequest extends Failure {
  const BadRequest(
    dynamic error,
  ) : super('Bad Request', '400', error);
}

class Unauthorized extends Failure {
  const Unauthorized(
    dynamic error,
  ) : super('Unauthorized', '401', error);
}

class Forbidden extends Failure {
  const Forbidden(
    dynamic error,
  ) : super('Forbidden', '403', error);
}

class NotFound extends Failure {
  const NotFound(
    dynamic error,
  ) : super('Not Found', '404', error);
}

class MethodNotAllowed extends Failure {
  const MethodNotAllowed(
    dynamic error,
  ) : super('Method Not Allowed', '405', error);
}

class NotAcceptable extends Failure {
  const NotAcceptable(
    dynamic error,
  ) : super('Not Acceptable', '406', error);
}

class RequestTimeout extends Failure {
  const RequestTimeout(
    dynamic error,
  ) : super('Request Timeout', '408', error);
}

class Conflict extends Failure {
  const Conflict(
    dynamic error,
  ) : super('Conflict', '409', error);
}

class Gone extends Failure {
  const Gone(
    dynamic error,
  ) : super('Gone', '410', error);
}

class LengthRequired extends Failure {
  const LengthRequired(
    dynamic error,
  ) : super('Length Required', '411', error);
}

class PreconditionFailed extends Failure {
  const PreconditionFailed(
    dynamic error,
  ) : super('Precondition Failed', '412', error);
}

class PayloadTooLarge extends Failure {
  const PayloadTooLarge(
    dynamic error,
  ) : super('Payload Too Large', '413', error);
}

class URITooLong extends Failure {
  const URITooLong(
    dynamic error,
  ) : super('URI Too Long', '414', error);
}

class UnsupportedMediaType extends Failure {
  const UnsupportedMediaType(
    dynamic error,
  ) : super('Unsupported Media Type', '415', error);
}

class RangeNotSatisfiable extends Failure {
  const RangeNotSatisfiable(
    dynamic error,
  ) : super('Range Not Satisfiable', '416', error);
}

class ExpectationFailed extends Failure {
  const ExpectationFailed(
    dynamic error,
  ) : super('Expectation Failed', '417', error);
}

class UnprocessableEntity extends Failure {
  const UnprocessableEntity(
    dynamic error,
  ) : super('Unprocessable Entity', '422', error);
}

class TooManyRequests extends Failure {
  const TooManyRequests(
    dynamic error,
  ) : super('Too Many Requests', '429', error);
}

/// Server Error Responses
class InternalServerError extends Failure {
  const InternalServerError(
    dynamic error,
  ) : super('Internal Server Error', '500', error);
}

class NotImplemented extends Failure {
  const NotImplemented(
    dynamic error,
  ) : super('Not Implemented', '501', error);
}

class BadGateway extends Failure {
  const BadGateway(
    dynamic error,
  ) : super('Bad Gateway', '502', error);
}

class ServiceUnavailable extends Failure {
  const ServiceUnavailable(
    dynamic error,
  ) : super('Service Unavailable', '503', error);
}

class GatewayTimeout extends Failure {
  const GatewayTimeout(
    dynamic error,
  ) : super('Gateway Timeout', '504', error);
}

class Unexpected extends Failure {
  const Unexpected(
    dynamic error,
  ) : super('Unknown Error', '500', error);
}
