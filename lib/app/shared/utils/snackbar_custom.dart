import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/shared/utils/error_pt_br.dart';

class SnackbarCustom  {
  createSnackBar(message, cor, context) {
    final snackBar = SnackBar(content: Text(message), backgroundColor: cor);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  createSnackBareErrOrGoal(scaffoldKey, {message='', errOrGoal=false, time=2, rota}) {
    if(message != '') {
      if(errOrGoal) {
        final snackbar = SnackBar(content: Text(message), duration:  Duration(seconds:time), backgroundColor: Colors.green);
        scaffoldKey.currentState.showSnackBar(snackbar);
        Timer(Duration(seconds: time), () => Modular.to.navigate(rota));
      }else{
        final snackbar = SnackBar(content: Text(message), duration:  Duration(seconds:time), backgroundColor: Colors.red);
        scaffoldKey.currentState.showSnackBar(snackbar);
      }
    }
  }

  createSnackBarErrorFirebase(message, cor, context) {
    final snackBar = SnackBar(content: Text(ErrorPtBr().verificaCodeErro(message)), backgroundColor: cor);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


}