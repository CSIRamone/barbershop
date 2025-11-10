
sealed class UserModel {
  final int id;
  final String name;
  final String email;
  final String? avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
   this.avatar,
  });

  factory UserModel.fromMap(Map<String, dynamic> json){
    return switch(json['profile']){
      'ADM'=> UserModelAdm.fromMap(json),
      'EMPLOYEE' => UserModelEmployee.fromMap(json),
      _ => throw Exception('Invalid profile type'),
    };
  }

}

class UserModelAdm extends UserModel {
  final List<String>? workDays;
  final List<int>? workHours;

  UserModelAdm({
    required super.id,
    required super.name,
    required super.email,
    super.avatar,
    this.workDays,
    this.workHours,
  });

  factory UserModelAdm.fromMap(Map<String, dynamic> json) {
    return switch(json) {
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,
      } => UserModelAdm(
        email: email, 
        id: id, 
        name: name, 
        avatar: json['avatar'],
        workDays: json['workDays']?.cast<String>(),
        workHours: json['workHours']?.cast<int>(),
      ),     
       _ => throw Exception('Invalid JSON format for UserModelAdm'),
    
    };
  }
}

class UserModelEmployee extends UserModel {
  final int barbershopId;
  final List<String> workDays;
  final List<int> workHours;

  UserModelEmployee({
    required super.id,
    required super.name,
    required super.email,
    super.avatar,
    required this.workDays,
    required this.workHours,
    required this.barbershopId,
  });
  
  factory UserModelEmployee.fromMap(Map<String, dynamic> json) {
    return switch(json) {
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,
        'barbershop_id': int barbershopId,
        'work_days': List workDays,
        'work_hours': List workHours,
      } => UserModelEmployee(
        email: email, 
        id: id, 
        name: name, 
        avatar: json['avatar'],
        barbershopId: barbershopId,
        workDays: workDays.cast<String>(),
        workHours: workHours.cast<int>(),
      ),     
       _ => throw Exception('Invalid JSON format for UserModelEmployee'),
    
    };
  }

}
