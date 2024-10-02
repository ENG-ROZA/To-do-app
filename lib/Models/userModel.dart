class UserModel {
  String id;
  String Name;
  int Age;
  String Email;
  
  UserModel(
      {required this.Name,
      this.id = "",
      required this.Age,
      required this.Email,
    
      });

  UserModel.fromJson(Map<String, dynamic> Json)
      : this(
          id: Json["id"],
          Name: Json["Name"],
          Age: Json["Age"],
          Email: Json["Email"],
       
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "Name": Name,
      "Age": Age,
      "Email": Email,
   
    };
  }
}
