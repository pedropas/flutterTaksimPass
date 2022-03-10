// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passageiro_documento_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PassageiroDocumentoStore on _PassageiroDocumentoStore, Store {
  Computed<bool>? _$isFormOKComputed;

  @override
  bool get isFormOK =>
      (_$isFormOKComputed ??= Computed<bool>(() => super.isFormOK,
              name: '_PassageiroDocumentoStore.isFormOK'))
          .value;

  final _$formOKAtom = Atom(name: '_PassageiroDocumentoStore.formOK');

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

  final _$tipoDocumentoAtom =
      Atom(name: '_PassageiroDocumentoStore.tipoDocumento');

  @override
  String get tipoDocumento {
    _$tipoDocumentoAtom.reportRead();
    return super.tipoDocumento;
  }

  @override
  set tipoDocumento(String value) {
    _$tipoDocumentoAtom.reportWrite(value, super.tipoDocumento, () {
      super.tipoDocumento = value;
    });
  }

  final _$documentoAtom = Atom(name: '_PassageiroDocumentoStore.documento');

  @override
  String get documento {
    _$documentoAtom.reportRead();
    return super.documento;
  }

  @override
  set documento(String value) {
    _$documentoAtom.reportWrite(value, super.documento, () {
      super.documento = value;
    });
  }

  final _$listOfTipoDocumentoAtom =
      Atom(name: '_PassageiroDocumentoStore.listOfTipoDocumento');

  @override
  List<dynamic> get listOfTipoDocumento {
    _$listOfTipoDocumentoAtom.reportRead();
    return super.listOfTipoDocumento;
  }

  @override
  set listOfTipoDocumento(List<dynamic> value) {
    _$listOfTipoDocumentoAtom.reportWrite(value, super.listOfTipoDocumento, () {
      super.listOfTipoDocumento = value;
    });
  }

  final _$loadingAtom = Atom(name: '_PassageiroDocumentoStore.loading');

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

  final _$enviaDocumentoAsyncAction =
      AsyncAction('_PassageiroDocumentoStore.enviaDocumento');

  @override
  Future<bool> enviaDocumento() {
    return _$enviaDocumentoAsyncAction.run(() => super.enviaDocumento());
  }

  final _$_PassageiroDocumentoStoreActionController =
      ActionController(name: '_PassageiroDocumentoStore');

  @override
  void passageiroLoadLocal() {
    final _$actionInfo = _$_PassageiroDocumentoStoreActionController
        .startAction(name: '_PassageiroDocumentoStore.passageiroLoadLocal');
    try {
      return super.passageiroLoadLocal();
    } finally {
      _$_PassageiroDocumentoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTipoDocumento(String value) {
    final _$actionInfo = _$_PassageiroDocumentoStoreActionController
        .startAction(name: '_PassageiroDocumentoStore.setTipoDocumento');
    try {
      return super.setTipoDocumento(value);
    } finally {
      _$_PassageiroDocumentoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDocumento(String value) {
    final _$actionInfo = _$_PassageiroDocumentoStoreActionController
        .startAction(name: '_PassageiroDocumentoStore.setDocumento');
    try {
      return super.setDocumento(value);
    } finally {
      _$_PassageiroDocumentoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void passageiroSaveLocal() {
    final _$actionInfo = _$_PassageiroDocumentoStoreActionController
        .startAction(name: '_PassageiroDocumentoStore.passageiroSaveLocal');
    try {
      return super.passageiroSaveLocal();
    } finally {
      _$_PassageiroDocumentoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
formOK: ${formOK},
tipoDocumento: ${tipoDocumento},
documento: ${documento},
listOfTipoDocumento: ${listOfTipoDocumento},
loading: ${loading},
isFormOK: ${isFormOK}
    ''';
  }
}
