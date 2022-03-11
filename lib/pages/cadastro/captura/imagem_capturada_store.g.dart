// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imagem_capturada_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ImagemCapturadaStore on _ImagemCapturadaStore, Store {
  final _$arquivoFotoAtom = Atom(name: '_ImagemCapturadaStore.arquivoFoto');

  @override
  XFile? get arquivoFoto {
    _$arquivoFotoAtom.reportRead();
    return super.arquivoFoto;
  }

  @override
  set arquivoFoto(XFile? value) {
    _$arquivoFotoAtom.reportWrite(value, super.arquivoFoto, () {
      super.arquivoFoto = value;
    });
  }

  final _$loadingAtom = Atom(name: '_ImagemCapturadaStore.loading');

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
      AsyncAction('_ImagemCapturadaStore.enviaDocumento');

  @override
  Future<bool> enviaDocumento() {
    return _$enviaDocumentoAsyncAction.run(() => super.enviaDocumento());
  }

  final _$_ImagemCapturadaStoreActionController =
      ActionController(name: '_ImagemCapturadaStore');

  @override
  void setArquivoFoto(XFile value) {
    final _$actionInfo = _$_ImagemCapturadaStoreActionController.startAction(
        name: '_ImagemCapturadaStore.setArquivoFoto');
    try {
      return super.setArquivoFoto(value);
    } finally {
      _$_ImagemCapturadaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void passageiroLoadLocal() {
    final _$actionInfo = _$_ImagemCapturadaStoreActionController.startAction(
        name: '_ImagemCapturadaStore.passageiroLoadLocal');
    try {
      return super.passageiroLoadLocal();
    } finally {
      _$_ImagemCapturadaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void passageiroSaveLocal() {
    final _$actionInfo = _$_ImagemCapturadaStoreActionController.startAction(
        name: '_ImagemCapturadaStore.passageiroSaveLocal');
    try {
      return super.passageiroSaveLocal();
    } finally {
      _$_ImagemCapturadaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
arquivoFoto: ${arquivoFoto},
loading: ${loading}
    ''';
  }
}
