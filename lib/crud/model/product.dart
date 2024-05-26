class ProductModel{
  final String title;
  final String description;
  final String deadline;
  final dynamic createdOn;

  ProductModel({
    required this.title,
    required this.description,
    required this.deadline,
    required this.createdOn,
  });
  //Serialize the ProductModel instance to a JSON map

  Map<String,dynamic> toMap(){
    return {
      'title':title,
      'description':description,
      'deadline':deadline,
      'createdOn':createdOn,
    };
  }

  //create a ProductModel instance from a json map

  factory ProductModel.fromMap(Map<String,dynamic> json){
    return ProductModel(
      title: json['title'],
      description: json['description'],
      deadline: json['deadline'],


      createdOn: json['createdOn'],

    );
  }


}