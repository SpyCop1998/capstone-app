import 'package:jobkro/Search-User/UserScreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';

class onClickSearch extends StatefulWidget {
  var users;
  onClickSearch(var u){
    users=u;
  }
  @override
  _onClickSearchState createState() => _onClickSearchState();
}
class _onClickSearchState extends State<onClickSearch> {
  @override
  void initState() {
    print(widget.users);
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users List"),),
      body: ListView.builder(
        itemCount: widget.users.length,
        itemBuilder: (context,index){
          return InkWell(
            onTap: (){
              String n=widget.users[index]['name'];
              String mob=widget.users[index]['mobile'];
              String pro=widget.users[index]['profession'];
              String l="location";
              if(n.isNotEmpty && mob.isNotEmpty && pro.isNotEmpty && l.isNotEmpty){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>UserPage(n, mob, l, pro)));
              }
              else{
                ShowAlert("Error", "Something Went Wrong");
              }
            },
            child: Card(
              child: Container(
                padding: EdgeInsets.only(left: 13),
                // width: 40,
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width/5,
                        child: Text(widget.users[index]['name'])),
                    SizedBox(width: MediaQuery.of(context).size.width/6,),
                    Container(
                        width: MediaQuery.of(context).size.width/5,
                        child: Text(widget.users[index]['profession'])),
                    Spacer(),
                    Container(
                        width: MediaQuery.of(context).size.width/5,
                        child: Text("2 Kms"),),
                  ],
                ),
              ),
            ),
          );
        },
      )
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
