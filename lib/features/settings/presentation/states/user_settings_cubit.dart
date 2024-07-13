import 'package:bloc/bloc.dart';
import 'package:ed/features/settings/domain/services/settings_service,.dart';
import 'package:flutter/material.dart';
part 'user_settings_state.dart';

class UserSettingsCubit extends Cubit<UserSettingsState> {
  UserSettingsCubit({required this.userSettingsService})
      : super(UserSettingsInitial());

  final UserSettingsService userSettingsService;

  void init() async {
    emit(UserSettingsLoadingState());
    final authorizationStatus =
        await userSettingsService.getAuthorizationStatus();

    final balance = await userSettingsService.getUserBalance();
    emit(
      UserSettingsLoadedState(
        isAuthorized: authorizationStatus,
        balance: balance,
      ),
    );
  }

  void authorizeUser() async {
    emit(UserSettingsLoadingState());
    await userSettingsService.authorizeUser();
    final authorizationStatus =
        await userSettingsService.getAuthorizationStatus();
    final balance = await userSettingsService.getUserBalance();
    emit(
      UserSettingsLoadedState(
        isAuthorized: authorizationStatus,
        balance: balance,
      ),
    );
  }

  void deauthorizeUser() async {
    emit(UserSettingsLoadingState());
    await userSettingsService.deauthorizeUser();
    final authorizationStatus =
        await userSettingsService.getAuthorizationStatus();
    final balance = await userSettingsService.getUserBalance();
    emit(
      UserSettingsLoadedState(
        isAuthorized: authorizationStatus,
        balance: balance,
      ),
    );
  }

  void depositMoney(double amount) async {
    emit(UserSettingsLoadingState());
    await userSettingsService.depositMoney(amount);
    final authorizationStatus =
        await userSettingsService.getAuthorizationStatus();
    final balance = await userSettingsService.getUserBalance();
    emit(
      UserSettingsLoadedState(
        isAuthorized: authorizationStatus,
        balance: balance,
      ),
    );
  }
}
