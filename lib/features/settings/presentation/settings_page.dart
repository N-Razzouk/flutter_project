import 'package:ed/core/utilities/palette.dart';
import 'package:ed/features/settings/data/settings_repository_implementation.dart';
import 'package:ed/features/settings/interactor/settings_service_implementation.dart';
import 'package:ed/features/settings/presentation/states/user_settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserSettingsCubit(
        userSettingsService: UserSettingsServiceImpl(
          settingsRepository: UserSettingsRepositoryImpl(),
        ),
      )..init(),
      child: Scaffold(
        backgroundColor: MyColorPalette.nightBlack,
        appBar: AppBar(
          backgroundColor: MyColorPalette.ashGrey,
          title: const Text('Settings'),

          /// add back button
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocBuilder<UserSettingsCubit, UserSettingsState>(
          builder: (context, state) {
            /// switch statement to print state
            if (state is UserSettingsLoadedState) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Authorized',
                          style: TextStyle(
                            color: MyColorPalette.ashGrey,
                            fontSize: 24,
                          ),
                        ),
                        const Spacer(),
                        Switch.adaptive(
                          activeColor: MyColorPalette.englishViolet,
                          value: state.isAuthorized,
                          onChanged: (newValue) async {
                            /// Add logic to change the authorization status
                            if (newValue) {
                              context.read<UserSettingsCubit>().authorizeUser();
                            } else {
                              context
                                  .read<UserSettingsCubit>()
                                  .deauthorizeUser();
                            }
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Current Balance',
                          style: TextStyle(
                            color: MyColorPalette.ashGrey,
                            fontSize: 24,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '\$ ${state.balance.toString()}',
                          style: const TextStyle(
                            color: MyColorPalette.ashGrey,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100),
                    const Text(
                      "Enter the amount you want to deposit:",
                      style: TextStyle(
                        color: MyColorPalette.ashGrey,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _amountController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      style: const TextStyle(
                        color: MyColorPalette.ashGrey,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Amount',
                        hintStyle: const TextStyle(
                          color: MyColorPalette.ashGrey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: MyColorPalette.nightBlack,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: MyColorPalette.englishViolet,
                        backgroundColor: MyColorPalette.ashGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (_amountController.text.isEmpty) {
                          return;
                        }

                        /// Add logic to deposit money
                        final amount = double.parse(_amountController.text);
                        context.read<UserSettingsCubit>().depositMoney(amount);
                      },
                      child: const Text(
                        'Deposit',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is UserSettingsErrorState) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(
                    color: MyColorPalette.englishViolet,
                    fontSize: 24,
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
