class UserModel{
  String? fullname;
  String? email;
  String? uid;
  String? profilePic;
  String? designation;
  
  UserModel({this.fullname, this.email, this.uid, this.profilePic, this.designation});

  UserModel.frommap(Map<String, dynamic> map){
    uid = map['uid'];
    email = map['email'];
    fullname = map['fullname'];
    profilePic = map['profilePic'];
    designation = map['designation'];
  }

  Map<String, dynamic> tomap(){
    return {
      'uid': uid,
      'email': email,
      'fullname': fullname,
      'profilePic': profilePic,
      'designation': designation,
    };
  }
}