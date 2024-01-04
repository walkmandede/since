
import 'package:flutter/services.dart';

void vibrateNow(){
  try{
    HapticFeedback.heavyImpact();
  }
  catch(e){
    null;
  }
}