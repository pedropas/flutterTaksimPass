// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passageiro_parte_2_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PassageiroParte2Store on _PassageiroParte2Store, Store {
  Computed<bool>? _$isFormOKComputed;

  @override
  bool get isFormOK =>
      (_$isFormOKComputed ??= Computed<bool>(() => super.isFormOK,
              name: '_PassageiroParte2Store.isFormOK'))
          .value;
  Computed<String?>? _$isValidEmailFormatComputed;

  @override
  String? get isValidEmailFormat => (_$isValidEmailFormatComputed ??=
          Computed<String?>(() => super.isValidEmailFormat,
              name: '_PassageiroParte2Store.isValidEmailFormat'))
      .value;

  final _$formOKAtom = Atom(name: '_PassageiroParte2Store.formOK');

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

  final _$emailAtom = Atom(name: '_PassageiroParte2Store.email');

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

  final _$celularAtom = Atom(name: '_PassageiroParte2Store.celular');

  @override
  String get celular {
    _$celularAtom.reportRead();
    return super.celular;
  }

  @override
  set celular(String value) {
    _$celularAtom.reportWrite(value, super.celular, () {
      super.celular = value;
    });
  }

  final _$loadingAtom = Atom(name: '_PassageiroParte2Store.loading');

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

  final _$verificaEmailLocalAsyncAction =
      AsyncAction('_PassageiroParte2Store.verificaEmailLocal');

  @override
  Future<bool> verificaEmailLocal() {
    return _$verificaEmailLocalAsyncAction
        .run(() => super.verificaEmailLocal());
  }

  final _$_PassageiroParte2StoreActionController =
      ActionController(name: '_PassageiroParte2Store');

  @override
  void passageiroLoadLocal() {
    final _$actionInfo = _$_PassageiroParte2StoreActionController.startAction(
        name: '_PassageiroParte2Store.passageiroLoadLocal');
    try {
      return super.passageiroLoadLocal();
    } finally {
      _$_PassageiroParte2StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_PassageiroParte2StoreActionController.startAction(
        name: '_PassageiroParte2Store.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_PassageiroParte2StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCelular(String value) {
    final _$actionInfo = _$_PassageiroParte2StoreActionController.startAction(
        name: '_PassageiroParte2Store.setCelular');
    try {
      return super.setCelular(value);
    } finally {
      _$_PassageiroParte2StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void passageiroSaveLocal() {
    final _$actionInfo = _$_PassageiroParte2StoreActionController.startAction(
        name: '_PassageiroParte2Store.passageiroSaveLocal');
    try {
      return super.passageiroSaveLocal();
    } finally {
      _$_PassageiroParte2StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
formOK: ${formOK},
email: ${email},
celular: ${celular},
loading: ${loading},
isFormOK: ${isFormOK},
isValidEmailFormat: ${isValidEmailFormat}
    ''';
  }
}
