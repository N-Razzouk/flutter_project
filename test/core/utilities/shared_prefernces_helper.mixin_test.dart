import 'package:ed/core/utilities/shared_preferences_helper.mixin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesObject = Object with SharedPreferencesHelper;

void main() {
  // Set up a test case for SharedPreferencesHelper
  group('SharedPreferencesHelper', () {
    late final SharedPreferencesObject sharedPreferencesObject;
    setUpAll(() {
      sharedPreferencesObject = const SharedPreferencesObject();
      SharedPreferences.setMockInitialValues({});
    });

    // Test case for saveStringToPrefs
    test('saveStringToPrefs', () async {
      await sharedPreferencesObject.saveStringToPrefs('key', 'value');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('key'), 'value');
    });

    // Test case for getStringFromPrefs
    test('getStringFromPrefs', () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('key', 'value');
      expect(await sharedPreferencesObject.getStringFromPrefs('key'), 'value');
    });

    // Test case for saveBoolToPrefs
    test('saveBoolToPrefs', () async {
      await sharedPreferencesObject.saveBoolToPrefs('key', true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool('key'), true);
    });

    // Test case for getBoolFromPrefs
    test('getBoolFromPrefs', () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('key', true);
      expect(await sharedPreferencesObject.getBoolFromPrefs('key'), true);
    });

    // Test case for saveIntToPrefs
    test('saveIntToPrefs', () async {
      await sharedPreferencesObject.saveIntToPrefs('key', 1);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      expect(prefs.getInt('key'), 1);
    });

    // Test case for getIntFromPrefs
    test('getIntFromPrefs', () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('key', 1);
      expect(await sharedPreferencesObject.getIntFromPrefs('key'), 1);
    });

    // Test case for saveDoubleToPrefs
    test('saveDoubleToPrefs', () async {
      await sharedPreferencesObject.saveDoubleToPrefs('key', 1.0);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      expect(prefs.getDouble('key'), 1.0);
    });

    // Test case for getDoubleFromPrefs
    test('getDoubleFromPrefs', () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('key', 1.0);
      expect(await sharedPreferencesObject.getDoubleFromPrefs('key'), 1.0);
    });

    // Test case for removeFromPrefs

    test('removeFromPrefs', () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('key', 'value');
      await sharedPreferencesObject.removeFromPrefs('key');
      expect(prefs.getString('key'), null);
    });

    // Test case for clearPrefs
    test('clearPrefs', () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('key', 'value');
      await sharedPreferencesObject.clearPrefs();
      expect(prefs.getString('key'), null);
    });
  });
}
