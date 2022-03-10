// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passageiro_parte_1_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PassageiroParte1Store on _PassageiroParte1Store, Store {
  Computed<bool>? _$isFormOKComputed;

  @override
  bool get isFormOK =>
      (_$isFormOKComputed ??= Computed<bool>(() => super.isFormOK,
              name: '_PassageiroParte1Store.isFormOK'))
          .value;

  final _$formOKAtom = Atom(name: '_PassageiroParte1Store.formOK');

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

  final _$nomeCompletoAtom = Atom(name: '_PassageiroParte1Store.nomeCompleto');

  @override
  String get nomeCompleto {
    _$nomeCompletoAtom.reportRead();
    return super.nomeCompleto;
  }

  @override
  set nomeCompleto(String value) {
    _$nomeCompletoAtom.reportWrite(value, super.nomeCompleto, () {
      super.nomeCompleto = value;
    });
  }

  final _$nomeSocialAtom = Atom(name: '_PassageiroParte1Store.nomeSocial');

  @override
  String get nomeSocial {
    _$nomeSocialAtom.reportRead();
    return super.nomeSocial;
  }

  @override
  set nomeSocial(String value) {
    _$nomeSocialAtom.reportWrite(value, super.nomeSocial, () {
      super.nomeSocial = value;
    });
  }

  final _$loadingAtom = Atom(name: '_PassageiroParte1Store.loading');

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

  final _$_PassageiroParte1StoreActionController =
      ActionController(name: '_PassageiroParte1Store');

  @override
  void passageiroLoadLocal() {
    final _$actionInfo = _$_PassageiroParte1StoreActionController.startAction(
        name: '_PassageiroParte1Store.passageiroLoadLocal');
    try {
      return super.passageiroLoadLocal();
    } finally {
      _$_PassageiroParte1StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNomeCompleto(String value) {
    final _$actionInfo = _$_PassageiroParte1StoreActionController.startAction(
        name: '_PassageiroParte1Store.setNomeCompleto');
    try {
      return super.setNomeCompleto(value);
    } finally {
      _$_PassageiroParte1StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNomeSocial(String value) {
    final _$actionInfo = _$_PassageiroParte1StoreActionController.startAction(
        name: '_PassageiroParte1Store.setNomeSocial');
    try {
      return super.setNomeSocial(value);
    } finally {
      _$_PassageiroParte1StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void passageiroSaveLocal() {
    final _$actionInfo = _$_PassageiroParte1StoreActionController.startAction(
        name: '_PassageiroParte1Store.passageiroSaveLocal');
    try {
      return super.passageiroSaveLocal();
    } finally {
      _$_PassageiroParte1StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
formOK: ${formOK},
nomeCompleto: ${nomeCompleto},
nomeSocial: ${nomeSocial},
loading: ${loading},
isFormOK: ${isFormOK}
    ''';
  }
}
