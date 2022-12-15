import 'package:freezed_annotation/freezed_annotation.dart';

part 'operation_status.freezed.dart';

@freezed
class OperationStatus<T> with _$OperationStatus<T> {
  const factory OperationStatus.data(T data) = OperationStatusData;

  const factory OperationStatus.error() = OperationStatusError;

  const factory OperationStatus.loading() = OperationStatusLoading;
}
