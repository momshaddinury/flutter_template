// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'logout_state.dart';

class LogoutStateMapper extends ClassMapperBase<LogoutState> {
  LogoutStateMapper._();

  static LogoutStateMapper? _instance;
  static LogoutStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LogoutStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LogoutState';

  static Status _$type(LogoutState v) => v.type;
  static const Field<LogoutState, Status> _f$type =
      Field('type', _$type, opt: true, def: Status.initial);
  static String? _$error(LogoutState v) => v.error;
  static const Field<LogoutState, String> _f$error =
      Field('error', _$error, opt: true);

  @override
  final MappableFields<LogoutState> fields = const {
    #type: _f$type,
    #error: _f$error,
  };

  static LogoutState _instantiate(DecodingData data) {
    return LogoutState(type: data.dec(_f$type), error: data.dec(_f$error));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin LogoutStateMappable {
  LogoutStateCopyWith<LogoutState, LogoutState, LogoutState> get copyWith =>
      _LogoutStateCopyWithImpl<LogoutState, LogoutState>(
          this as LogoutState, $identity, $identity);
  @override
  String toString() {
    return LogoutStateMapper.ensureInitialized()
        .stringifyValue(this as LogoutState);
  }
}

extension LogoutStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LogoutState, $Out> {
  LogoutStateCopyWith<$R, LogoutState, $Out> get $asLogoutState =>
      $base.as((v, t, t2) => _LogoutStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LogoutStateCopyWith<$R, $In extends LogoutState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({Status? type, String? error});
  LogoutStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LogoutStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LogoutState, $Out>
    implements LogoutStateCopyWith<$R, LogoutState, $Out> {
  _LogoutStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LogoutState> $mapper =
      LogoutStateMapper.ensureInitialized();
  @override
  $R call({Status? type, Object? error = $none}) => $apply(FieldCopyWithData(
      {if (type != null) #type: type, if (error != $none) #error: error}));
  @override
  LogoutState $make(CopyWithData data) => LogoutState(
      type: data.get(#type, or: $value.type),
      error: data.get(#error, or: $value.error));

  @override
  LogoutStateCopyWith<$R2, LogoutState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _LogoutStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
