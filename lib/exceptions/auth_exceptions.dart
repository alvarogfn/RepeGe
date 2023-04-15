class AuthException implements Exception {
  final String? msg;
  const AuthException([this.msg]);

  @override
  String toString() {
    return msg ?? "Não foi possível te autenticar ao serviço.";
  }
}

class AuthMismatchLoginException implements Exception {
  final String? msg;
  const AuthMismatchLoginException([this.msg]);

  @override
  String toString() {
    return msg ?? "Não existe uma conta para essa combinação de email e senha.";
  }
}

class AuthEmailAlreadyUsedException implements Exception {
  final String? msg;
  const AuthEmailAlreadyUsedException([this.msg]);

  @override
  String toString() {
    return msg ?? "Esse email já está cadastrado na plataforma.";
  }
}

class AuthWeakPasswordException implements Exception {
  final String? msg;
  const AuthWeakPasswordException([this.msg]);

  @override
  String toString() {
    return msg ??
        "Essa senha é muito fraca, tente fortalece-lá com letras, números e caracteres especiais e um tamanho minimo de 6 caracteres.";
  }
}
