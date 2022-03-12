// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imagem_capturada_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ImagemCapturadaStore on _ImagemCapturadaStore, Store {
  final _$fotoAtom = Atom(name: '_ImagemCapturadaStore.foto');

  @override
  String? get foto {
    _$fotoAtom.reportRead();
    return super.foto;
  }

  @override
  set foto(String? value) {
    _$fotoAtom.reportWrite(value, super.foto, () {
      super.foto = value;
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

  final _$enviaFotoAsyncAction = AsyncAction('_ImagemCapturadaStore.enviaFoto');

  @override
  Future<bool> enviaFoto() {
    return _$enviaFotoAsyncAction.run(() => super.enviaFoto());
  }

  final _$_ImagemCapturadaStoreActionController =
      ActionController(name: '_ImagemCapturadaStore');

  @override
  void setFoto(String value) {
    final _$actionInfo = _$_ImagemCapturadaStoreActionController.startAction(
        name: '_ImagemCapturadaStore.setFoto');
    try {
      return super.setFoto(value);
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
foto: ${foto},
loading: ${loading}
    ''';
  }
}
