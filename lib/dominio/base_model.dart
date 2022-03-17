import 'dart:convert';

abstract class BaseModelo
{
  int id = 0;

  String getDataToString(DateTime? dateTime)
  {
    if (dateTime != null)
      return dateTime.toIso8601String();
    else
      return '';
  }

  String toJson();
  preparToJson();

  void getRemote();
  void getLocal();
  void setLocal();
  void setRemoto();

  static DateTime? convertToDate(String dt)
  {
    try {
      if (dt != null && dt.isNotEmpty)
        return DateTime.parse(dt);
    }
    catch(e) {
    }
    return null;
  }
}
