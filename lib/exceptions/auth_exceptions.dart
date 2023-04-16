class AuthException implements Exception {
  final String? msg;
  const AuthException([this.msg]);

  @override
  String toString() {
    return msg ??
        "Alguma coisa deu errado na conexão com o servidor. Tente novamente.";
  }
}

class AuthMismatchLoginException implements AuthException {
  @override
  final String? msg;
  const AuthMismatchLoginException([this.msg]);

  @override
  String toString() {
    return msg ?? "Não existe uma conta para essa combinação de email e senha.";
  }
}

class AuthEmailAlreadyUsedException implements AuthException {
  @override
  final String? msg;
  const AuthEmailAlreadyUsedException([this.msg]);

  @override
  String toString() {
    return msg ?? "Esse email já está cadastrado na plataforma.";
  }
}

class AuthWeakPasswordException implements AuthException {
  @override
  final String? msg;
  const AuthWeakPasswordException([this.msg]);

  @override
  String toString() {
    return msg ??
        "Essa senha é muito fraca, tente fortalece-lá com letras, números e caracteres especiais e um tamanho minimo de 6 caracteres.";
  }
}

class AuthEmailNotVerifiedException implements AuthException {
  @override
  final String? msg;
  const AuthEmailNotVerifiedException([this.msg]);

  @override
  String toString() {
    return msg ?? "Esse email já está cadastrado na plataforma.";
  }
}
