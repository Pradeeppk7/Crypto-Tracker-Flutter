import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crytoapp/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../pages/Login.dart';

class Navbar extends StatefulWidget {
  Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
   User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }
  
  @override
  Widget build(BuildContext context) {
     ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          
          const SizedBox(
            height: 60.0,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                        height: 60,
                       
                        
                        child: Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.contain,
                        )),
                    IconButton(
                    onPressed: () {
                      themeProvider.toggleTheme();
                    },
                    
                    icon: (themeProvider.themeMode == ThemeMode.light)
                        ? Icon(Icons.dark_mode_sharp)
                        : Icon(Icons.light_mode_sharp),
                  ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.account_circle_rounded),
            title:  Text("${loggedInUser.firstName} ${loggedInUser.secondName}".toUpperCase(),),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
           ListTile(
            leading: const Icon(Icons.mail),
            title:  Text("${loggedInUser.email} ",),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          InkWell(
            onTap: () {
              // Use PushNamed Function of Navigator class to push the named route
              Navigator.pushNamed(context, 'login');
            },
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log out'),
              onTap: () 
                 {
                    logout(context);
                  }),
              
            ),
            ListTile(
  
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
            SizedBox(height: 400,),
          ListTile( 
            title: 
            
            Row(
              children:[
                SizedBox(width: 40),
              Text('MADE WITH '),
               Icon(CupertinoIcons.heart_fill,color:Colors.red ,size: 18,),
               Row(children:[Text(" BY PRADEEP"),]),],
            
            
          ),),
     
           
          
        ],
      ),
    );
    
  }
}
Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
