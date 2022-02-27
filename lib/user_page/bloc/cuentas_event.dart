part of 'cuentas_bloc.dart';

@immutable

abstract class CuentasEvent{}

class LoadEvent extends CuentasEvent{

}

class PullToRefreshEvent extends CuentasEvent{}
