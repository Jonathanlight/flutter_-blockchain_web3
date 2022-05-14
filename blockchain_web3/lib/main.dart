import 'package:blockchain_web3/contract_linkinbg.dart';
import 'package:blockchain_web3/hello_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => ContractLinking()),
      child: MaterialApp(
        title: 'Flutter Blockchain Web3',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const HelloPage(),
      ),
    );
  }
}
