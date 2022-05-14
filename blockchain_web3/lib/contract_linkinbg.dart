import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://127.0.0.1:7545";
  final String _wsUrl = "ws://127.0.0.1:7545";
  final String _privateKey =
      "bf41c681bee605797fa6d0515b6fc86e0be2aa853bc149f6e321caa2dc50cc39";

  Web3Client? _web3client;
  bool isLoading = true;

  String? _abiCode;

  EthereumAddress? _contractAddress;
  Credentials? _credentials;

  DeployedContract? _contract;
  ContractFunction? _message;
  ContractFunction? _setMessage;

  String? deployedName;

  ContractAbi? _contractAbi;

  ContractLinking() {
    setup();
  }

  setup() async {
    _web3client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringfile =
        await rootBundle.loadString("build/contracts/HelloWorld.json");
    final jsonAbi = jsonDecode(abiStringfile);
    _abiCode = jsonEncode(jsonAbi['abi']);

    _contractAddress =
        EthereumAddress.fromHex(jsonAbi['networks']['5777']['address']);
  }

  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
  }

  Future<void> getDeployedContract() async {
    _contractAbi = ContractAbi.fromJson(_abiCode!, "HelloWorld");

    _contract = DeployedContract(_contractAbi!, _contractAddress!);

    _message = _contract!.function("message");
    _setMessage = _contract!.function("setMessage");

    getMessage();
  }

  getMessage() async {
    final _myMessage = await _web3client!
        .call(contract: _contract!, function: _message!, params: []);

    deployedName = _myMessage[0];
    isLoading = false;
    notifyListeners();
  }

  setMessage(String message) async {
    isLoading = true;
    notifyListeners();
    await _web3client!.sendTransaction(
        _credentials!,
        Transaction.callContract(
            contract: _contract!,
            function: _setMessage!,
            parameters: [message]));
    getMessage();
  }
}
