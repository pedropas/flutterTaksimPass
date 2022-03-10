// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passageiro_valida_conta_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PassageiroValidaContaStore on _PassageiroValidaContaStore, Store {
  Computed<bool>? _$isFormOKComputed;

  @override
  bool get isFormOK =>
      (_$isFormOKComputed ??= Computed<bool>(() => super.isFormOK,
              name: '_PassageiroValidaContaStore.isFormOK'))
          .value;

  final _$formOKAtom = Atom(name: '_PassageiroValidaContaStore.formOK');

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

  final _$emailTempAtom = Atom(name: '_PassageiroValidaContaStore.emailTemp');

  @override
  String get emailTemp {
    _$emailTempAtom.reportRead();
    return super.emailTemp;
  }

  @override
  set emailTemp(String value) {
    _$emailTempAtom.reportWrite(value, super.emailTemp, () {
      super.emailTemp = value;
    });
  }

  final _$digito1Atom = Atom(name: '_PassageiroValidaContaStore.digito1');

  @override
  String get digito1 {
    _$digito1Atom.reportRead();
    return super.digito1;
  }

  @override
  set digito1(String value) {
    _$digito1Atom.reportWrite(value, super.digito1, () {
      super.digito1 = value;
    });
  }

  final _$digito2Atom = Atom(name: '_PassageiroValidaContaStore.digito2');

  @override
  String get digito2 {
    _$digito2Atom.reportRead();
    return super.digito2;
  }

  @override
  set digito2(String value) {
    _$digito2Atom.reportWrite(value, super.digito2, () {
      super.digito2 = value;
    });
  }

  final _$digito3Atom = Atom(name: '_PassageiroValidaContaStore.digito3');

  @override
  String get digito3 {
    _$digito3Atom.reportRead();
    return super.digito3;
  }

  @override
  set digito3(String value) {
    _$digito3Atom.reportWrite(value, super.digito3, () {
      super.digito3 = value;
    });
  }

  final _$digito4Atom = Atom(name: '_PassageiroValidaContaStore.digito4');

  @override
  String get digito4 {
    _$digito4Atom.reportRead();
    return super.digito4;
  }

  @override
  set digito4(String value) {
    _$digito4Atom.reportWrite(value, super.digito4, () {
      super.digito4 = value;
    });
  }

  final _$loadingAtom = Atom(name: '_PassageiroValidaContaStore.loading');

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

  final _$verificaEmailAsyncAction =
      AsyncAction('_PassageiroValidaContaStore.verificaEmail');

  @override
  Future<bool> verificaEmail() {
    return _$verificaEmailAsyncAction.run(() => super.verificaEmail());
  }

  final _$_PassageiroValidaContaStoreActionController =
      ActionController(name: '_PassageiroValidaContaStore');

  @override
  void passageiroLoadLocal() {
    final _$actionInfo = _$_PassageiroValidaContaStoreActionController
        .startAction(name: '_PassageiroValidaContaStore.passageiroLoadLocal');
    try {
      return super.passageiroLoadLocal();
    } finally {
      _$_PassageiroValidaContaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDigito1(String value) {
    final _$actionInfo = _$_PassageiroValidaContaStoreActionController
        .startAction(name: '_PassageiroValidaContaStore.setDigito1');
    try {
      return super.setDigito1(value);
    } finally {
      _$_PassageiroValidaContaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDigito2(String value) {
    final _$actionInfo = _$_PassageiroValidaContaStoreActionController
        .startAction(name: '_PassageiroValidaContaStore.setDigito2');
    try {
      return super.setDigito2(value);
    } finally {
      _$_PassageiroValidaContaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDigito3(String value) {
    final _$actionInfo = _$_PassageiroValidaContaStoreActionController
        .startAction(name: '_PassageiroValidaContaStore.setDigito3');
    try {
      return super.setDigito3(value);
    } finally {
      _$_PassageiroValidaContaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDigito4(String value) {
    final _$actionInfo = _$_PassageiroValidaContaStoreActionController
        .startAction(name: '_PassageiroValidaContaStore.setDigito4');
    try {
      return super.setDigito4(value);
    } finally {
      _$_PassageiroValidaContaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmailTemp(String value) {
    final _$actionInfo = _$_PassageiroValidaContaStoreActionController
        .startAction(name: '_PassageiroValidaContaStore.setEmailTemp');
    try {
      return super.setEmailTemp(value);
    } finally {
      _$_PassageiroValidaContaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void passageiroSaveLocal() {
    final _$actionInfo = _$_PassageiroValidaContaStoreActionController
        .startAction(name: '_PassageiroValidaContaStore.passageiroSaveLocal');
    try {
      return super.passageiroSaveLocal();
    } finally {
      _$_PassageiroValidaContaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
formOK: ${formOK},
emailTemp: ${emailTemp},
digito1: ${digito1},
digito2: ${digito2},
digito3: ${digito3},
digito4: ${digito4},
loading: ${loading},
isFormOK: ${isFormOK}
    ''';
  }
}
