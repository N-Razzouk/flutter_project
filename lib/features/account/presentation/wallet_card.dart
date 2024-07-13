import 'package:ed/core/utilities/palette.dart';
import 'package:ed/features/account/presentation/cubit/account_cubit.dart';
import 'package:ed/features/settings/presentation/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountCubit, AccountState>(
      builder: (context, state) {
        if (state is AccountLoaded) {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width * .8,
              height: MediaQuery.of(context).size.height * .2,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: MyColorPalette.ashGrey,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Text(
                      state.isAuthorized ? 'Authorized' : 'Unauthorized',
                      style: const TextStyle(
                        color: MyColorPalette.englishViolet,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Balance:'),
                        Text(
                          '\$ ${state.balance}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: MyColorPalette.englishViolet,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Positioned(
                    right: 0,
                    top: 0,
                    child: SettingsButton(),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.settings,
        color: MyColorPalette.englishViolet,
      ),
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SettingsPage(),
          ),
        ).then((_) {
          context.read<AccountCubit>().init();
        });
      },
    );
  }
}
