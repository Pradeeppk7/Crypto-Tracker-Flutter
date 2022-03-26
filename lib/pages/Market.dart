import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Cryptocurrency.dart';
import '../providers/market_provider.dart';
import 'DetailPage.dart';
class Markets extends StatefulWidget {
  const Markets({ Key? key }) : super(key: key);

  @override
  State<Markets> createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  @override
  Widget build(BuildContext context) {
    return   Expanded(
                child: Consumer<MarketProvider>(
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
                              CryptoCurrency currentCrypto =
                                  MarketProvider.markets[index];
                              return ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailsPage(
                                              id: currentCrypto.id!,
                                            )),
                                  );
                                },
                                contentPadding: EdgeInsets.all(0),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      NetworkImage(currentCrypto.image!),
                                ),
                                title: Text(
                                    "#${currentCrypto.marketCapRank!} " +
                                        currentCrypto.name!),
                                subtitle:
                                    Text(currentCrypto.symbol!.toUpperCase()),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "₹ " +
                                          currentCrypto.currentPrice!
                                              .toStringAsFixed(4),
                                      style: TextStyle(
                                        color: Color(0xff0395eb),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Builder(builder: (context) {
                                      double pricechange =
                                          currentCrypto.priceChange24!;
                                      double pricechangePercentage =
                                          currentCrypto
                                              .priceChangePercentage24!;
                                      if (pricechange < 0) {
                                        return Text(
                                          "${pricechangePercentage.toStringAsFixed(2)}% (${pricechange.toStringAsFixed(4)})",
                                          style: TextStyle(color: Colors.red),
                                        );
                                      } else {
                                        return Text(
                                          "+${pricechangePercentage.toStringAsFixed(2)}% (+${pricechange.toStringAsFixed(4)})",
                                          style: TextStyle(color: Colors.green),
                                        );
                                      }
                                    }),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Text("Data Not Found!");
                      }
                    }
                  },
                ),
              );
  }
}