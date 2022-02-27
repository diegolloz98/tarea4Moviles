class Cuenta{
  final int id;
  final String tarjeta;
  final String cuenta;
  final String dinero;
  
  Cuenta(
    {required this.id, 
    required this.tarjeta,
    required this.cuenta,
    required this.dinero,
      });
      factory Cuenta.fromJson(Map<String, dynamic> json){
        return Cuenta(
          id : json['id'], 
          tarjeta : json['tarjeta'], 
          cuenta : json['cuenta'], 
          dinero : json['dinero']);
      }
}
