// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'login_state.dart';

class LoginStateMapper extends ClassMapperBase<LoginState> {
  LoginStateMapper._();

  static LoginStateMapper? _instance;
  static LoginStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LoginStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LoginState';
  @override
  Function get typeFactory => <T>(f) => f<LoginState<T>>();

  static bool _$rememberMe(LoginState v) => v.rememberMe;
  static const Field<LoginState, bool> _f$rememberMe =
      Field('rememberMe', _$rememberMe, opt: true, def: false);
  static Status _$type(LoginState v) => v.type;
  static const Field<LoginState, Status> _f$type =
      Field('type', _$type, opt: true, def: Status.initial);
  static String? _$error(LoginState v) => v.error;
  static const Field<LoginState, String> _f$error =
      Field('error', _$error, opt: true);

  @override
  final MappableFields<LoginState> fields = const {
    #rememberMe: _f$rememberMe,
    #type: _f$type,
    #error: _f$error,
  };

  static LoginState<T> _instantiate<T>(DecodingData data) {
    return LoginState(
        rememberMe: data.dec(_f$rememberMe),
        type: data.dec(_f$type),
        error: data.dec(_f$error));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin LoginStateMappable<T> {
  LoginStateCopyWith<LoginState<T>, LoginState<T>, LoginState<T>, T>
      get copyWith => _LoginStateCopyWithImpl<LoginState<T>, LoginState<T>, T>(
          this as LoginState<T>, $identity, $identity);
  @override
  String toString() {
    return LoginStateMapper.ensureInitialized()
        .stringifyValue(this as LoginState<T>);
  }
}

extension LoginStateValueCopy<$R, $Out, T>
    on ObjectCopyWith<$R, LoginState<T>, $Out> {
  LoginStateCopyWith<$R, LoginState<T>, $Out, T> get $asLoginState =>
      $base.as((v, t, t2) => _LoginStateCopyWithImpl<$R, $Out, T>(v, t, t2));
}

abstract class LoginStateCopyWith<$R, $In extends LoginState<T>, $Out, T>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({bool? rememberMe, Status? type, String? error});
  LoginStateCopyWith<$R2, $In, $Out2, T> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LoginStateCopyWithImpl<$R, $Out, T>
    extends ClassCopyWithBase<$R, LoginState<T>, $Out>
    implements LoginStateCopyWith<$R, LoginState<T>, $Out, T> {
  _LoginStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LoginState> $mapper =
      LoginStateMapper.ensureInitialized();
  @override
  $R call({bool? rememberMe, Status? type, Object? error = $none}) =>
      $apply(FieldCopyWithData({
        if (rememberMe != null) #rememberMe: rememberMe,
        if (type != null) #type: type,
        if (error != $none) #error: error
      }));
  @override
  LoginState<T> $make(CopyWithData data) => LoginState(
      rememberMe: data.get(#rememberMe, or: $value.rememberMe),
      type: data.get(#type, or: $value.type),
      error: data.get(#error, or: $value.error));

  @override
  LoginStateCopyWith<$R2, LoginState<T>, $Out2, T> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _LoginStateCopyWithImpl<$R2, $Out2, T>($value, $cast, t);
}
