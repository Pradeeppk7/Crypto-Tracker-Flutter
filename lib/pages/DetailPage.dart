import 'package:crytoapp/models/Cryptocurrency.dart';
import 'package:crytoapp/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final String id;
  const DetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          child: Consumer<MarketProvider>(
            builder: (context, marketProvider, child) {
              CryptoCurrency currencyCrypto =
                  marketProvider.fetchCryptoById(widget.id);
              return ListView(
                children: [
                  Text(currencyCrypto.name!),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
