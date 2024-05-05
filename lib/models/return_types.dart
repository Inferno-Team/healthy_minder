class ReturnType<Type> {
  dynamic msg;
  dynamic code;

  ReturnType({
    required this.msg,
    required this.code,
  });

  factory ReturnType.fromJson(dynamic json) => ReturnType(
        msg: json['msg'],
        code: json['code'],
      );
}

class ReturnDataType<Type> extends ReturnType<Type> {
  Type data;

  ReturnDataType({
    required super.msg,
    required super.code,
    required this.data,
  });

  factory ReturnDataType.fromJson(dynamic json, String key, bool isSimple,
          Type Function(Map<String, dynamic> j)? fromJson) =>
      ReturnDataType<Type>(
        msg: json['msg'],
        code: json['code'],
        data: isSimple ? json[key] : fromJson!(json[key]),
      );
}

class ReturnError<T> extends ReturnType<T> {
  List<Error> errors;

  ReturnError({
    required super.msg,
    required super.code,
    required this.errors,
  });
}

class Error {
  dynamic error;

  Error({this.error});

  factory Error.fromJson(dynamic json) => Error(error: json);

  static List<Error> fromListJson(dynamic json) =>
      json.map((j) => Error(error: j)).toList();
}
