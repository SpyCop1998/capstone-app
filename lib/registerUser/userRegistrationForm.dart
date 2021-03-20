import 'dart:convert';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:jobkro/Constant/API_URL.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:string_validator/string_validator.dart';

class UserRegistration extends StatefulWidget {
  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  String dropdownValue = 'Teachers';
  List<String> spinnerItems = [
    'Teachers',
    'Attorneys',
    'CA',
    'Engineer',
    'Lawyer',
    'Surgeon',
    'Aviator',
    'Hotel Manager',
    'Scientist',
    'SDE',
    'Designer',
    'Civil Servant'
  ];
  final _formKey = GlobalKey<FormState>();
  Future<http.Response> createUser(String name,String mobile, String latt,String long,String profession)async{
    var response=await http.post(urlRegister,headers:header,
    body: jsonEncode({
      "name":name,
      "mobile":mobile,
      "latt":latt,
      "long":long,
      "profession":profession
    })).then((res) {
      if(res.statusCode==successResponseCode){
        ShowAlert("Success", "You have been registered");
      }else if(res.statusCode==emptyResponseCode){
        ShowAlert("Empty", "Fill the details Again");
      }else{
        ShowAlert("Error", "Something went wrong");
      }
    }).catchError((err){
      ShowAlert('Error', err.toString());
    });
  }

  TextEditingController name=TextEditingController();
  TextEditingController mobile=TextEditingController();
  TextEditingController latlong=TextEditingController();



  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(hintText: "Name"),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  controller: mobile,
                  decoration: InputDecoration(hintText: "Mobile No"),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 30.0,
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  value: dropdownValue,
                  icon: Icon(Icons.work),
                  onChanged: (String data) {
                    setState(() {
                      dropdownValue = data;
                    });
                  },
                  items: spinnerItems
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text("Address"),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  controller:latlong,
                  decoration: InputDecoration(hintText: "Address"),
                ),
                SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                  child: Text("Submit"),
                  onPressed: () async{
                    String n=name.text.trim();
                    String m=mobile.text.trim();
                    var latlon=latlong.text.trim();
                    String pro=dropdownValue.toString();

                    ArsProgressDialog progressDialog=ArsProgressDialog(context,
                      dismissable: false,
                      blur: 2,
                      backgroundColor: Colors.white,
                      animationDuration: Duration(microseconds: 500),
                    );
                    // progressDialog.show();
                    if(n.isNotEmpty && m.length==10 && isNumeric(m)){// && latlon.isNotEmpty){
                      await createUser(n, m, "latt", "long", pro);
                      // progressDialog.dismiss();
                      name.clear();
                      mobile.clear();
                      latlong.clear();

                    }else{
                      // progressDialog.dismiss();
                      Fluttertoast.showToast(
                          msg: "Fill all the Fields",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                  },
                )
              ],
            ),
          ),
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
