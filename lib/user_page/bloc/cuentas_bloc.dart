import 'package:money_track/user_page/cuenta.dart';
import 'package:bloc/bloc.dart';
import 'package:money_track/user_page/data_service.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import 'dart:io';

part 'cuentas_event.dart';
part 'cuentas_state.dart';

class CuentasBloc extends Bloc <CuentasEvent, CuentasState>{
  final _dataServie = DataService();
  CuentasBloc() : super(LoadingState()){
    on<CuentasEvent>((event, emit) async{
      if(event is LoadEvent){
        emit(LoadingState());
        try{
          final cuentas = await _dataServie.getCuentas();
          emit(LoadedState(cuentas: cuentas));
        }catch(e){
          emit(FailedToLoadState(error: e.toString()));
        }
      }
    });
  }
}
