import 'package:ed/features/settings/domain/repository/settings_repository.dart';
import 'package:ed/features/settings/domain/services/settings_service,.dart';

class UserSettingsServiceImpl extends UserSettingsService {
  final UserSettingsRepository settingsRepository;

  UserSettingsServiceImpl({
    required this.settingsRepository,
  });

  @override
  Future<void> authorizeUser() async =>
      await settingsRepository.authorizeUser();

  @override
  Future<void> deauthorizeUser() async =>
      await settingsRepository.deauthorizeUser();

  @override
  Future<void> depositMoney(double amount) async =>
      await settingsRepository.depositMoney(amount);

  @override
  Future<bool> getAuthorizationStatus() async =>
      await settingsRepository.getAuthorizationStatus();

  @override
  Future<double> getUserBalance() async =>
      await settingsRepository.getUserBalance();
}
