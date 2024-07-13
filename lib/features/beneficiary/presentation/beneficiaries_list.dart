import 'package:ed/core/utilities/palette.dart';
import 'package:ed/features/account/presentation/cubit/account_cubit.dart';
import 'package:ed/features/beneficiary/data/beneficiary_repository_implementation.dart';
import 'package:ed/features/beneficiary/data/datasources/transactions_datasource_impl.dart';
import 'package:ed/features/beneficiary/interactor/beneficiary_service_implementation.dart';
import 'package:ed/features/beneficiary/presentation/add_beneficiary_page.dart';
import 'package:ed/features/beneficiary/presentation/cubit/beneficiary_cubit.dart';
import 'package:ed/features/beneficiary/presentation/top_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BeneficiariesList extends StatelessWidget {
  const BeneficiariesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BeneficiaryCubit(
              beneficiaryService: BeneficiaryServiceImpl(
                beneficiaryRepository: BeneficiaryRepositoryImpl(
                  transactionsDatasource: TransactionsDatasourceImpl(),
                ),
              ),
            )..loadBeneficiaries(),
        child: BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
          builder: (context, state) {
            if (state is BeneficiaryInitial || state is BeneficiaryLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is BeneficiaryLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .15,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: state.beneficiaries.length,
                      itemBuilder: (context, index) {
                        final beneficiary = state.beneficiaries[index];
                        return Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: MyColorPalette.ashGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: MediaQuery.of(context).size.height * .15,
                          width: MediaQuery.of(context).size.width * .3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(beneficiary.name),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(beneficiary.phone),
                              const Spacer(),
                              if (state.beneficiaries.length > 5)
                                const SizedBox.shrink()
                              else
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: MyColorPalette.ashGrey,
                                    backgroundColor: MyColorPalette.taupeGrey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text('Top Up'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(
                                      MaterialPageRoute(
                                        builder: (context) => TopUpPage(
                                          beneficiary: beneficiary,
                                        ),
                                      ),
                                    )
                                        .then((_) {
                                      context
                                          .read<BeneficiaryCubit>()
                                          .loadBeneficiaries();
                                      context.read<AccountCubit>().init();
                                    });
                                  },
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: MyColorPalette.englishViolet,
                      backgroundColor: MyColorPalette.ashGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Add Beneficiary'),
                    onPressed: () {
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (context) => AddBeneficiaryPage(),
                        ),
                      )
                          .then((_) {
                        context.read<BeneficiaryCubit>().loadBeneficiaries();
                      });
                    },
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text("An error occurred"),
              );
            }
          },
        ));
  }
}
