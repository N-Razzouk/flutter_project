part of 'user_settings_cubit.dart';

@immutable
sealed class UserSettingsState {}

final class UserSettingsInitial extends UserSettingsState {}

final class UserSettingsLoadingState extends UserSettingsState {}

final class UserSettingsLoadedState extends UserSettingsState {
  final bool isAuthorized;
  final double balance;

  UserSettingsLoadedState({
    required this.isAuthorized,
    required this.balance,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSettingsLoadedState &&
          runtimeType == other.runtimeType &&
          isAuthorized == other.isAuthorized &&
          balance == other.balance;

  @override
  int get hashCode => isAuthorized.hashCode ^ balance.hashCode;

  @override
  String toString() =>
      'UserSettingsLoadedState{isAuthorized: $isAuthorized, balance: $balance}';

  UserSettingsLoadedState copyWith({
    bool? isAuthorized,
    double? balance,
  }) {
    return UserSettingsLoadedState(
      isAuthorized: isAuthorized ?? this.isAuthorized,
      balance: balance ?? this.balance,
    );
  }
}

final class UserSettingsErrorState extends UserSettingsState {
  final String message;

  UserSettingsErrorState({
    required this.message,
  });
}
