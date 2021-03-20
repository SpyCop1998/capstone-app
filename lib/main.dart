import 'dart:convert';

import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobkro/Constant/API_URL.dart';
import 'package:jobkro/Search-User/onClickSearch.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'registerUser/userRegistrationForm.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "JobKro",
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var users;

  Future<http.Response> getUser()async{
    var respose=await http.get(urlGetUsers,headers: header).then((res) {
      if(res.statusCode==successResponseCode){
        users=jsonDecode(res.body);
        print(users);
      }else{
        ShowAlert("Error", "Something Went Wrong");
        print("Something went wrong");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JobKro"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                ArsProgressDialog progressDialog = ArsProgressDialog(
                    context,
                    dismissable: false,
                    blur: 2,
                    backgroundColor: Color(0x33000000),
                    animationDuration: Duration(milliseconds: 500));
                progressDialog.show(); // show dialog
                await getUser();
                progressDialog.dismiss();
                if(users!=null) {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => onClickSearch(users)));
                }
                print(users);
              },
              child: Container(
                width: MediaQuery.of(context).size.width/2,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.blueGrey
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.search,color: Colors.white,),
                    SizedBox(width: 10,),
                    Text("Search",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30,),
            InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserRegistration()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width/2,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.blueGrey
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.add,color: Colors.white,),
                    SizedBox(width: 5,),
                    Text("Register Your Self",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void ShowAlert(String title,String desc){
    Alert(
      onWillPopActive: true,
      context: context,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(child: Text('Ok'), onPressed: ()=>Navigator.pop(context),width: 120,),
      ]
      ,
    ).show();
  }
}
