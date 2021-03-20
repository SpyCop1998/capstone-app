class User{
  String id,name,mobile,latt,long,profession;
  User({this.id, this.name, this.mobile, this.latt, this.long, this.profession});
  factory User.fromJson(Map<String,dynamic> json){
    return User(
      id: json['_id'] as String,
      name: json['name'] as String,
      mobile: json['mobile'] as String,
      latt: json['latt'] as String,
      long: json['long'] as String,
      profession: json['profession'] as String
    );
  }

}