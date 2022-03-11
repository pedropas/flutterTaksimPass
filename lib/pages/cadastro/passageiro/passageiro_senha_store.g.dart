// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passageiro_senha_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PassageiroSenhaStore on _PassageiroSenhaStore, Store {
  Computed<bool>? _$isFormOKComputed;

  @override
  bool get isFormOK =>
      (_$isFormOKComputed ??= Computed<bool>(() => super.isFormOK,
              name: '_PassageiroSenhaStore.isFormOK'))
          .value;

  final _$formOKAtom = Atom(name: '_PassageiroSenhaStore.formOK');

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

  final _$senhaAtom = Atom(name: '_PassageiroSenhaStore.senha');

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

  final _$confirmaSenhaAtom = Atom(name: '_PassageiroSenhaStore.confirmaSenha');

  @override
  String get confirmaSenha {
    _$confirmaSenhaAtom.reportRead();
    return super.confirmaSenha;
  }

  @override
  set confirmaSenha(String value) {
    _$confirmaSenhaAtom.reportWrite(value, super.confirmaSenha, () {
      super.confirmaSenha = value;
    });
  }

  final _$manterConectadoAtom =
      Atom(name: '_PassageiroSenhaStore.manterConectado');

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

  final _$loadingAtom = Atom(name: '_PassageiroSenhaStore.loading');

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

  final _$enviaSenhaAsyncAction =
      AsyncAction('_PassageiroSenhaStore.enviaSenha');

  @override
  Future<bool> enviaSenha() {
    return _$enviaSenhaAsyncAction.run(() => super.enviaSenha());
  }

  final _$_PassageiroSenhaStoreActionController =
      ActionController(name: '_PassageiroSenhaStore');

  @override
  void passageiroLoadLocal() {
    final _$actionInfo = _$_PassageiroSenhaStoreActionController.startAction(
        name: '_PassageiroSenhaStore.passageiroLoadLocal');
    try {
      return super.passageiroLoadLocal();
    } finally {
      _$_PassageiroSenhaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSenha(String value) {
    final _$actionInfo = _$_PassageiroSenhaStoreActionController.startAction(
        name: '_PassageiroSenhaStore.setSenha');
    try {
      return super.setSenha(value);
    } finally {
      _$_PassageiroSenhaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmaSocial(String value) {
    final _$actionInfo = _$_PassageiroSenhaStoreActionController.startAction(
        name: '_PassageiroSenhaStore.setConfirmaSocial');
    try {
      return super.setConfirmaSocial(value);
    } finally {
      _$_PassageiroSenhaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setManterConectado(bool value) {
    final _$actionInfo = _$_PassageiroSenhaStoreActionController.startAction(
        name: '_PassageiroSenhaStore.setManterConectado');
    try {
      return super.setManterConectado(value);
    } finally {
      _$_PassageiroSenhaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void passageiroSaveLocal() {
    final _$actionInfo = _$_PassageiroSenhaStoreActionController.startAction(
        name: '_PassageiroSenhaStore.passageiroSaveLocal');
    try {
      return super.passageiroSaveLocal();
    } finally {
      _$_PassageiroSenhaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
formOK: ${formOK},
senha: ${senha},
confirmaSenha: ${confirmaSenha},
manterConectado: ${manterConectado},
loading: ${loading},
isFormOK: ${isFormOK}
    ''';
  }
}
