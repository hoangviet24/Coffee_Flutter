// ignore_for_file: file_names

class Users {
  final int? usrId;
  late final String usrName;
  final String usrPassword;

  Users({
    this.usrId,
    required this.usrName,
    required this.usrPassword,
  });
  Users copyWith({
    int? usrId,
    String? usrName,
    String? usrPassword,
  }) {
    return Users(
      usrId: usrId ?? this.usrId,
      usrName: usrName ?? this.usrName,
      usrPassword: usrPassword ?? this.usrPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'usrId': usrId,
      'usrName': usrName,
      'usrPassword': usrPassword,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      usrId: map['usrId'],
      usrName: map['usrName'],
      usrPassword: map['usrPassword'],
    );
  }
}
