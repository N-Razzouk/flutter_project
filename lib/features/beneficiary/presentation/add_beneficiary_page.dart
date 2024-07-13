import 'package:ed/core/utilities/palette.dart';
import 'package:ed/features/beneficiary/data/beneficiary_repository_implementation.dart';
import 'package:ed/features/beneficiary/data/datasources/transactions_datasource_impl.dart';
import 'package:ed/features/beneficiary/interactor/beneficiary_service_implementation.dart';
import 'package:ed/features/beneficiary/presentation/cubit/beneficiary_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBeneficiaryPage extends StatelessWidget {
  AddBeneficiaryPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BeneficiaryCubit(
        beneficiaryService: BeneficiaryServiceImpl(
          beneficiaryRepository: BeneficiaryRepositoryImpl(
            transactionsDatasource: TransactionsDatasourceImpl(),
          ),
        ),
      ),
      child: BlocConsumer<BeneficiaryCubit, BeneficiaryState>(
        listener: (context, state) {
          if (state is BeneficiaryError) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: MyColorPalette.ashGrey,
                title: const Text('Error'),
                content: Text(state.message),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          } else if (state is BeneficiaryLoaded) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
              backgroundColor: MyColorPalette.nightBlack,
              appBar: AppBar(
                backgroundColor: MyColorPalette.ashGrey,
                title: const Text('Add Beneficiary'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: nameController,
                      style: const TextStyle(
                        color: MyColorPalette.ashGrey,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Name',
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
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: phoneController,
                      style: const TextStyle(
                        color: MyColorPalette.ashGrey,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        hintText: 'Phone',
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
                    const SizedBox(
                      height: 16,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: MyColorPalette.ashGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        if (nameController.text.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    backgroundColor: MyColorPalette.ashGrey,
                                    title: const Text('Error'),
                                    content: const Text('Name cannot be empty'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ));
                        }
                        if (phoneController.text.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    backgroundColor: MyColorPalette.ashGrey,
                                    title: const Text('Error'),
                                    content:
                                        const Text('Phone cannot be empty'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ));
                        } else {
                          await context.read<BeneficiaryCubit>().addBeneficiary(
                                name: nameController.text,
                                phoneNumber: phoneController.text,
                              );
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
