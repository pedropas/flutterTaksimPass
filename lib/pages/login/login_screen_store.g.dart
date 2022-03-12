// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginScreenStore on _LoginScreenStore, Store {
  Computed<bool>? _$isFormOKComputed;

  @override
  bool get isFormOK =>
      (_$isFormOKComputed ??= Computed<bool>(() => super.isFormOK,
              name: '_LoginScreenStore.isFormOK'))
          .value;

  final _$formOKAtom = Atom(name: '_LoginScreenStore.formOK');

  @override
  bool get formOK {
    _$formOKAtom.reportRead();
    return super.formOK;
  }

  @override
  set formOK(bool value) {
    _$formOKAtom.reportWrite(value, super.formOK, () {
      super.formOK = value;
    });
  }

  final _$senhaAtom = Atom(name: '_LoginScreenStore.senha');

  @override
  String get senha {
    _$senhaAtom.reportRead();
    return super.senha;
  }

  @override
  set senha(String value) {
    _$senhaAtom.reportWrite(value, super.senha, () {
      super.senha = value;
    });
  }

  final _$emailAtom = Atom(name: '_LoginScreenStore.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$manterConectadoAtom = Atom(name: '_LoginScreenStore.manterConectado');

  @override
  bool get manterConectado {
    _$manterConectadoAtom.reportRead();
    return super.manterConectado;
  }

  @override
  set manterConectado(bool value) {
    _$manterConectadoAtom.reportWrite(value, super.manterConectado, () {
      super.manterConectado = value;
    });
  }

  final _$loadingAtom = Atom(name: '_LoginScreenStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$validaLoginAsyncAction = AsyncAction('_LoginScreenStore.validaLogin');

  @override
  Future<bool> validaLogin() {
    return _$validaLoginAsyncAction.run(() => super.validaLogin());
  }

  final _$_LoginScreenStoreActionController =
      ActionController(name: '_LoginScreenStore');

  @override
  void passageiroLoadLocal() {
    final _$actionInfo = _$_LoginScreenStoreActionController.startAction(
        name: '_LoginScreenStore.passageiroLoadLocal');
    try {
      return super.passageiroLoadLocal();
    } finally {
      _$_LoginScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSenha(String value) {
    final _$actionInfo = _$_LoginScreenStoreActionController.startAction(
        name: '_LoginScreenStore.setSenha');
    try {
      return super.setSenha(value);
    } finally {
      _$_LoginScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_LoginScreenStoreActionController.startAction(
        name: '_LoginScreenStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_LoginScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setManterConectado(bool value) {
    final _$actionInfo = _$_LoginScreenStoreActionController.startAction(
        name: '_LoginScreenStore.setManterConectado');
    try {
      return super.setManterConectado(value);
    } finally {
      _$_LoginScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
formOK: ${formOK},
senha: ${senha},
email: ${email},
manterConectado: ${manterConectado},
loading: ${loading},
isFormOK: ${isFormOK}
    ''';
  }
}
