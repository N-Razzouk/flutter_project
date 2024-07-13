import 'package:ed/core/utilities/palette.dart';
import 'package:ed/features/account/data/account_repository_implementation.dart';
import 'package:ed/features/account/interactor/account_service_implementation.dart';
import 'package:ed/features/account/presentation/cubit/account_cubit.dart';
import 'package:ed/features/account/presentation/wallet_card.dart';
import 'package:ed/features/beneficiary/presentation/beneficiaries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountCubit>(
      create: (context) => AccountCubit(
        accountService: AccountServiceImpl(
          accountRepository: AccountRepositoryImpl(),
        ),
      )..init(),
      child: const Scaffold(
        backgroundColor: MyColorPalette.nightBlack,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                WalletCard(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Beneficiaries',
                  style: TextStyle(
                    color: MyColorPalette.ashGrey,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: BeneficiariesList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
