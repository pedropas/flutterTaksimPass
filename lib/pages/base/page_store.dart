import 'package:mobx/mobx.dart';

part 'page_store.g.dart';

class PageStore = _PageStore with _$PageStore;

abstract class _PageStore with Store {

  @observable
  int page = 0;

  @action
  void setPage(int value) => page = value;

  @observable
  bool isShow = true;

}
// flutter packages pub run build_runner watch
