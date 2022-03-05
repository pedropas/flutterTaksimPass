class ModelLogin {
  String usuario = '';
  String senha = '';
  String versionApp = '';
  bool manterConectado = false;

  ModelLogin fromJson(String modelo)
  {
    return ModelLogin();
  }

  String toJson()
  {
    return "to json";
  }
}
