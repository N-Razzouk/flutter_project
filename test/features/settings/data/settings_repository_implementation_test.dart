import 'package:ed/features/settings/data/settings_repository_implementation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test settings repository implementation.', () {
    late final UserSettingsRepositoryImpl settingsRepository;

    setUpAll(() {
      /// Arrange all.
      settingsRepository = UserSettingsRepositoryImpl();
    });

    test('getAuthorizationStatus should return true.', () async {
      /// Arrange
      await settingsRepository.authorizeUser();

      /// Act
      final authorizationStatus =
          await settingsRepository.getAuthorizationStatus();

      /// Assert
      expect(authorizationStatus, true);
    });

    test('deauthorizeUser should return false.', () async {
      /// Arrange
      await settingsRepository.deauthorizeUser();

      /// Act
      final authorizationStatus =
          await settingsRepository.getAuthorizationStatus();

      /// Assert
      expect(authorizationStatus, false);
    });

    test('getUserBalance should return 0.', () async {
      /// Arrange
      await settingsRepository.depositMoney(100);

      /// Act
      final userBalance = await settingsRepository.getUserBalance();

      /// Assert
      expect(userBalance, 100);
    });
  });
}
