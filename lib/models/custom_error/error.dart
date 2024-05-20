import 'package:freezed_annotation/freezed_annotation.dart';

part 'error.freezed.dart';

@freezed
class CustomError with _$CustomError {
  const factory CustomError({
    @Default('') String errMsg,
  }) = _CustomError;
}
