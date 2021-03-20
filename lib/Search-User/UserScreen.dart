import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
class UserPage extends StatefulWidget {
  String name,mobile,location,profession;
  UserPage(String n,String m,String l,String p){
    name=n;
    mobile=m;
    location=l;
    profession=p;
  }
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String mob;

  @override
  void initState() {
    mob=widget.mobile;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Worker Profile"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              child: Container(
                  width: MediaQuery.of(context).size.width/1.5,
                  height: MediaQuery.of(context).size.height/3.5,
                  child: Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text("Name"),
                              Spacer(),
                              Text(widget.name),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text("Profession"),
                              Spacer(),
                              Text(widget.profession),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text("Location"),
                              Spacer(),
                              Text(widget.location),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text("Mobile"),
                              Spacer(),
                              Text(widget.mobile),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        RaisedButton(
                          onPressed: (){
                            //call
                          },
                          child: Text("Call"),
                        )
                      ],
                    ),
                  ))),
            )
          ],
        ),
      ),
    );
  }
}
