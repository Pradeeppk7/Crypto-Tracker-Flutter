import 'package:crytoapp/models/Cryptocurrency.dart';
import 'package:crytoapp/pages/DetailPage.dart';
import 'package:crytoapp/providers/market_provider.dart';
import 'package:crytoapp/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "TrackCrypto",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Crypto Today",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      themeProvider.toggleTheme();
                    },
                    padding: EdgeInsets.all(0),
                    icon: (themeProvider.themeMode == ThemeMode.light)
                        ? Icon(Icons.dark_mode_sharp)
                        : Icon(Icons.light_mode_sharp),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
