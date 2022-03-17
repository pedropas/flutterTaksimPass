import 'base_model.dart';

class EntDataModel1 extends BaseModelo {
  DateTime? dtHora;
  DateTime? dtHoraPedido;
  int passageiroId = 0;
  int motoristaId = 0;
  int action = 0;
  bool actionLida = false;
  String mensagem = "";
  int cidadeId = 0;
  int corridaId = 0;
  int status = 0;
  double latitude = 0.0;
  double longitude = 0.0;
  String posicao = "";
  int tarifa = 0;
  int tipo = 0;
  bool statusConexao = false;
  int price = 0;
  String endereco = "";
  DateTime? dtHoraEnderecoChegada;
  int veiculoId = 0;
  String frame = "";
  bool statusMotorista = false;
  int tempoTaximetro = 0;
  double distanciaTaximetro = 0;
  double valorComDesconto = 0;
  String enderecoDestino = "";
  DateTime? dtHoraDestino;
  DateTime? dtHoraInicio;
  double percentualDesconto = 0;
  String formaPagamento = "";
  int indiceMessage = 0;
  int mensagemDestinatario = 0; // 0 para os dois 1 motorista 2 para passageiro
  String mensagemPassageiro = "";
  int tempoEstimado = 0;
  double distanciaEstimada = 0;
  double valorEstimado = 0;

  EntDataModel1({required this.motoristaId,
    required this.percentualDesconto, required this.latitude, required this.longitude,
    required this.tempoEstimado, required this.valorEstimado, required this.enderecoDestino,
    required this.action, required this.statusConexao, required this.actionLida,
    required this.cidadeId, required this.corridaId, required this.distanciaEstimada,
    required this.distanciaTaximetro, this.dtHora, this.dtHoraDestino,
    this.dtHoraEnderecoChegada, this.dtHoraInicio, this.dtHoraPedido,
    required this.endereco, required this.formaPagamento, required this.frame, required this.indiceMessage,
    required this.mensagem, required this.mensagemDestinatario, required this.mensagemPassageiro,
    required this.passageiroId, required this.posicao, required this.price, required this.status,
    required this.statusMotorista, required this.tarifa, required this.tempoTaximetro,
    required this.tipo, required this.valorComDesconto, required this.veiculoId });

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
    return {
     'id':id,
     'dtHora':getDataToString(dtHora),
    'dtHoraPedido':getDataToString(dtHoraPedido),
    'passageiroId':passageiroId,
    'motoristaId':motoristaId,
    'action':action,
    'actionLida':actionLida,
    'mensagem':mensagem,
    'mensagem':mensagem,
    'corridaId':corridaId,
    'status':status,
    'latitude':latitude,
    'longitude':longitude,
    'posicao':posicao,
    'tarifa':tarifa,
    'tipo':tipo,
    'statusConexao':statusConexao,
    'price':price,
    'endereco':endereco,
    'dtHoraEnderecoChegada':getDataToString(dtHoraEnderecoChegada),
    'veiculoId':veiculoId,
    'frame':frame,
    'statusMotorista':statusMotorista,
    'tempoTaximetro':tempoTaximetro,
    'distanciaTaximetro':distanciaTaximetro,
    'valorComDesconto':valorComDesconto,
    'enderecoDestino':enderecoDestino,
    'dtHoraDestino':getDataToString(dtHoraDestino),
    'dtHoraInicio':getDataToString(dtHoraInicio),
    'percentualDesconto':percentualDesconto,
    'formaPagamento':formaPagamento,
    'indiceMessage':indiceMessage,
    'mensagemDestinatario':mensagemDestinatario, // 0 para os dois 1 motorista 2 para passageiro
    'mensagemPassageiro':mensagemPassageiro,
    'tempoEstimado':tempoEstimado,
    'distanciaEstimada':distanciaEstimada,
    'valorEstimado':distanciaEstimada,
    };
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

  factory EntDataModel1.fromJson(Map<String, dynamic> jsonMap)
  {
    int id;
    DateTime? dtHora;
    DateTime? dtHoraPedido;
    int passageiroId = 0;
    int motoristaId = 0;
    int action = 0;
    bool actionLida = false;
    String mensagem = "";
    int cidadeId = 0;
    int corridaId = 0;
    int status = 0;
    double latitude = 0.0;
    double longitude = 0.0;
    String posicao = "";
    int tarifa = 0;
    int tipo = 0;
    bool statusConexao = false;
    int price = 0;
    String endereco = "";
    DateTime? dtHoraEnderecoChegada;
    int veiculoId = 0;
    String frame = "";
    bool statusMotorista = false;
    int tempoTaximetro = 0;
    double distanciaTaximetro = 0;
    double valorComDesconto = 0;
    String enderecoDestino = "";
    DateTime? dtHoraDestino;
    DateTime? dtHoraInicio;
    double percentualDesconto = 0;
    String formaPagamento = "";
    int indiceMessage = 0;
    int mensagemDestinatario = 0; // 0 para os dois 1 motorista 2 para passageiro
    String mensagemPassageiro = "";
    int tempoEstimado = 0;
    double distanciaEstimada = 0;
    double valorEstimado = 0;

    if (jsonMap.containsKey('id')) id = jsonMap['id'];
    if (jsonMap.containsKey('motoristaId'))
      motoristaId = jsonMap['motoristaId'];
    if (jsonMap.containsKey('percentualDesconto'))
      percentualDesconto = jsonMap['percentualDesconto'];
    if (jsonMap.containsKey('longitude')) longitude = jsonMap['longitude'];
    if (jsonMap.containsKey('latitude')) latitude = jsonMap['latitude'];
    if (jsonMap.containsKey('tempoEstimado'))
      tempoEstimado = jsonMap['tempoEstimado'];
    if (jsonMap.containsKey('distanciaEstimada'))
      distanciaEstimada = jsonMap['distanciaEstimada'];
    if (jsonMap.containsKey('valorEstimado'))
      valorEstimado = jsonMap['valorEstimado'];
    if (jsonMap.containsKey('passageiroId'))
      passageiroId = jsonMap['passageiroId'];
    if (jsonMap.containsKey('action')) action = jsonMap['action'];
    if (jsonMap.containsKey('actionLida')) actionLida = jsonMap['actionLida'];
    if (jsonMap.containsKey('mensagem')) mensagem = jsonMap['mensagem'];
    if (jsonMap.containsKey('cidadeId')) latitude = jsonMap['cidadeId'];
    if (jsonMap.containsKey('corridaId')) corridaId = jsonMap['corridaId'];
    if (jsonMap.containsKey('status')) status = jsonMap['status'];
    if (jsonMap.containsKey('posicao')) posicao = jsonMap['posicao'];
    if (jsonMap.containsKey('tarifa')) tarifa = jsonMap['tarifa'];
    if (jsonMap.containsKey('tipo')) tipo = jsonMap['tipo'];

    if (jsonMap.containsKey('statusConexao'))
      statusConexao = jsonMap['statusConexao'];
    if (jsonMap.containsKey('price')) price = jsonMap['price'];
    if (jsonMap.containsKey('endereco')) endereco = jsonMap['endereco'];
    if (jsonMap.containsKey('veiculoId')) veiculoId = jsonMap['veiculoId'];
    if (jsonMap.containsKey('frame')) frame = jsonMap['frame'];
    if (jsonMap.containsKey('statusMotorista'))
      statusMotorista = jsonMap['statusMotorista'];
    if (jsonMap.containsKey('tempoTaximetro'))
      tempoTaximetro = jsonMap['tempoTaximetro'];
    if (jsonMap.containsKey('distanciaTaximetro'))
      distanciaTaximetro = jsonMap['distanciaTaximetro'];
    if (jsonMap.containsKey('valorComDesconto'))
      valorComDesconto = jsonMap['valorComDesconto'];
    if (jsonMap.containsKey('enderecoDestino'))
      enderecoDestino = jsonMap['enderecoDestino'];
    if (jsonMap.containsKey('formaPagamento'))
      formaPagamento = jsonMap['formaPagamento'];
    if (jsonMap.containsKey('indiceMessage'))
      indiceMessage = jsonMap['indiceMessage'];
    if (jsonMap.containsKey('mensagemDestinatario'))
      mensagemDestinatario = jsonMap['mensagemDestinatario'];
    if (jsonMap.containsKey('mensagemPassageiro'))
      mensagemPassageiro = jsonMap['mensagemPassageiro'];

    if (jsonMap.containsKey('dtHora'))
      dtHora = BaseModelo.convertToDate(jsonMap['dtHora']);
    if (jsonMap.containsKey('dtHoraPedido'))
      dtHoraPedido = BaseModelo.convertToDate(jsonMap['dtHoraPedido']);
    if (jsonMap.containsKey('dtHoraEnderecoChegada')) dtHoraEnderecoChegada =
        BaseModelo.convertToDate(jsonMap['dtHoraEnderecoChegada']);
    if (jsonMap.containsKey('dtHoraDestino'))
      dtHoraDestino = BaseModelo.convertToDate(jsonMap['dtHoraDestino']);
    if (jsonMap.containsKey('dtHoraInicio'))
      dtHoraInicio = BaseModelo.convertToDate(jsonMap['dtHoraInicio']);

    return EntDataModel1(
        motoristaId: motoristaId,
        percentualDesconto: percentualDesconto,
        latitude: latitude,
        longitude: longitude,
        tempoEstimado: tempoEstimado,
        valorEstimado: valorEstimado,
        enderecoDestino: enderecoDestino,
        action: action,
        statusConexao: statusConexao,
        actionLida: actionLida,
        cidadeId: cidadeId,
        corridaId: corridaId,
        distanciaEstimada: distanciaEstimada,
        distanciaTaximetro: distanciaTaximetro,
        endereco: endereco,
        formaPagamento: formaPagamento,
        frame: frame,
        mensagem: mensagem,
        mensagemDestinatario: mensagemDestinatario,
        mensagemPassageiro: mensagemPassageiro,
        passageiroId: passageiroId,
        posicao: posicao,
        price: price,
        status: status,
        statusMotorista: statusMotorista,
        tarifa: tarifa,
        tempoTaximetro: tempoTaximetro,
        tipo: tipo,
        valorComDesconto: valorComDesconto,
        veiculoId: veiculoId,
        dtHora: dtHora,
        dtHoraDestino: dtHoraDestino,
        dtHoraEnderecoChegada: dtHoraEnderecoChegada,
        dtHoraInicio: dtHoraInicio,
        dtHoraPedido: dtHoraPedido,
        indiceMessage: indiceMessage);
  }

}
