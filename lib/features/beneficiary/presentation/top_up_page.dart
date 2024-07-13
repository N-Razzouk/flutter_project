import 'package:ed/core/utilities/palette.dart';
import 'package:ed/features/beneficiary/data/beneficiary_repository_implementation.dart';
import 'package:ed/features/beneficiary/data/datasources/transactions_datasource_impl.dart';
import 'package:ed/features/beneficiary/domain/entities/beneficiary.dart';
import 'package:ed/features/beneficiary/interactor/beneficiary_service_implementation.dart';
import 'package:ed/features/beneficiary/presentation/cubit/top_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({
    required this.beneficiary,
    super.key,
  });

  final Beneficiary beneficiary;

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  int? _amount;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TopUpCubit>(
      create: (context) => TopUpCubit(
        beneficiaryService: BeneficiaryServiceImpl(
          beneficiaryRepository: BeneficiaryRepositoryImpl(
            transactionsDatasource: TransactionsDatasourceImpl(),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColorPalette.ashGrey,
          title: Text('Top up ${widget.beneficiary.name}'),
        ),
        backgroundColor: MyColorPalette.nightBlack,
        body: BlocConsumer<TopUpCubit, TopUpState>(
          listener: (context, state) {
            if (state is TopUpError) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: MyColorPalette.ashGrey,
                  title: const Text('Error'),
                  content: Text(state.error.message),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ).then((_) {
                context.read<TopUpCubit>().reset();
              });
            } else if (state is TopUpLoaded) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is TopUpInitial) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "How much would money do you want to spend today?",
                      style: TextStyle(
                        color: MyColorPalette.ashGrey,
                        fontSize: 24,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        for (final int amount in [
                          5,
                          10,
                          20,
                          30,
                          50,
                          75,
                          100,
                        ])
                          RadioListTile<int>(
                            title: Text(
                              amount.toString(),
                              style: const TextStyle(
                                color: MyColorPalette.ashGrey,
                                fontSize: 12,
                              ),
                            ),
                            value: amount,
                            groupValue: _amount,
                            onChanged: (int? value) {
                              setState(() {
                                _amount = value!;
                              });
                            },
                          ),
                      ],
                    ),
                    const Spacer(),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: MyColorPalette.ashGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _amount != null
                          ? () async {
                              await context
                                  .read<TopUpCubit>()
                                  .rechargeToBeneficiary(
                                    amount: _amount!,
                                    beneficiaryId: widget.beneficiary.id,
                                  );
                            }
                          : null,
                      child: const Text(
                        "Top up",
                        style: TextStyle(
                          color: MyColorPalette.nightBlack,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              /// loading
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
