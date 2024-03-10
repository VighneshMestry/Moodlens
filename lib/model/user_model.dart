class UserModel {
  final String id;
  final int pid;
  final String userName;
  final String name;
  final String faceId;
  final String disability;
  final int phone;
  final int v;

  UserModel({
    required this.id,
    required this.pid,
    required this.userName,
    required this.name,
    required this.faceId,
    required this.disability,
    required this.phone,
    required this.v,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      pid: json['pid'],
      userName: json['userName'],
      name: json['name'],
      faceId: json['face_id'],
      disability: json['disability'],
      phone: json['phone'],
      v: json['__v'],
    );
  }
}
