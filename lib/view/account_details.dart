import 'package:flutter/material.dart';

import '../constants/colors.dart';

class AccountDetailsView extends StatefulWidget {
  const AccountDetailsView({super.key});

  @override
  State<AccountDetailsView> createState() => _AccountDetailsViewState();
}

class _AccountDetailsViewState extends State<AccountDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.colorDim4,
        appBar: AppBar(
          title: const Text(
            "Detalii cont",
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
          backgroundColor: Pallete.colorDim4,
        ),
        body: const Column(
          children: [
           
          ],
        ),
    );
  }
}