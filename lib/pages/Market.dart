import 'package:crytoapp/widgets/CryptoListTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Cryptocurrency.dart';
import '../providers/market_provider.dart';
import '../pages/DetailPage.dart';

class Markets extends StatefulWidget {
  const Markets({Key? key}) : super(key: key);

  @override
  State<Markets> createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, MarketProvider, child) {
        if (MarketProvider.isLoading == true) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (MarketProvider.markets.length > 0) {
            return RefreshIndicator(
              onRefresh: () async {
                await MarketProvider.fetchData();
              },
              child: ListView.builder(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: MarketProvider.markets.length,
                itemBuilder: (context, index) {
                  CryptoCurrency currentCrypto = MarketProvider.markets[index];
                  return CryptoListTile(currentCrypto: currentCrypto);
                },
              ),
            );
          } else {
            return Text("Data Not Found!");
          }
        }
      },
    );
  }
}
