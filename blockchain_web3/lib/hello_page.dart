import 'package:blockchain_web3/contract_linkinbg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HelloPage extends StatelessWidget {
  const HelloPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contractLink = Provider.of<ContractLinking>(context);
    final _messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Blockchain Web3"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/font.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: contractLink.isLoading
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Form(
                      child: Column(
                    children: [
                      Text(
                        "Message: ${contractLink.deployedName}",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      TextFormField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                            hintText: "Entrée votre Message "),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            contractLink.setMessage(_messageController.text);
                            _messageController.clear();
                          },
                          child: const Text("Envoyer votre Message")),
                    ],
                  )),
                ),
        ),
      ),
    );
  }
}
