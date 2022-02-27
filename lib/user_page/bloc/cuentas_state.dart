part of 'cuentas_bloc.dart';

@immutable

abstract class CuentasState{}

class CuentasInitial extends CuentasState{

}

class LoadingState extends CuentasState{}

class LoadedState extends CuentasState{
  List<Cuenta> cuentas;
  LoadedState({required this.cuentas});
}
 
class FailedToLoadState extends CuentasState{
  String error;
  FailedToLoadState({required this.error});
}