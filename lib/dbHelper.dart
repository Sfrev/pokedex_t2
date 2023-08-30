class MyPokes{
  final int id;

  MyPokes({required this.id});

  factory MyPokes.fromMap(Map<String, dynamic> map){
    return MyPokes(id: map['id']);
  }

  Map<String, dynamic> toMap(){
    return{'id':id};
  }

}