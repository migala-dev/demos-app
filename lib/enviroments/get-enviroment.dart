

import 'package:demos_app/enviroments/enviroment-dev.dart';
import 'package:demos_app/enviroments/enviroment.interface.dart';

Enviroment enviromentDev = EnviromentDev();

Enviroment getEnviroment() {
  return enviromentDev;
}