import 'base_model.dart';

class EntCartaoPassageiro extends BaseModelo
{
   int passageiroId = 0;
   int quatroUltimosCartao = 0;
   bool status = false;
   String? brand;
   String? token;
   DateTime? validade;
   String? origem = "";
   int? adquirenteId = 0;

   EntCartaoPassageiro({this.status = false
      , required this.passageiroId
      , required this.quatroUltimosCartao
      , this.brand
      , this.token
      , this.adquirenteId
      , this.origem
      , this.validade
   });
  @override
  void getLocal() {
    // TODO: implement getLocal
  }

  @override
  void getRemote() {
    // TODO: implement getRemote
  }

  @override
  preparToJson() {
    // TODO: implement preparToJson
    throw UnimplementedError();
  }

  @override
  void setLocal() {
    // TODO: implement setLocal
  }

  @override
  void setRemoto() {
    // TODO: implement setRemoto
  }

  @override
  String toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }


}
