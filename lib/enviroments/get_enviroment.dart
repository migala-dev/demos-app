import 'package:demos_app/enviroments/enviroment_dev.dart';
import 'package:demos_app/enviroments/enviroment.interface.dart';

Enviroment enviromentDev = EnviromentDev();

Enviroment getEnviroment() {
  return enviromentDev;
}
