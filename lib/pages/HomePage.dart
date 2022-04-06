import 'package:crytoapp/models/Cryptocurrency.dart';
import 'package:crytoapp/pages/DetailPage.dart';
import 'package:crytoapp/pages/Favorites.dart';
import 'package:crytoapp/pages/Market.dart';
import 'package:crytoapp/pages/news.dart';
import 'package:crytoapp/providers/market_provider.dart';
import 'package:crytoapp/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/Navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController viewController;
  @override
  void initState() {
    super.initState();
    viewController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      
      drawer: Navbar(),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(40),
          child: SizedBox(
            
              height: 45,
              child: Image.asset(
                "assets/images/nametrans2.png",
                fit: BoxFit.contain,
                 
              )),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                
              
                  Text(
                    "Today",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TabBar(
                controller: viewController,
                tabs: [
                  Tab(
                    child: Text(
                      "Markets",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Favorites",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Tab(
                    child: Text(
                      "News",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  controller: viewController,
                  children: [Markets(), Favorites(), CryptoNewsList()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
