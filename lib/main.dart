import 'package:annotated_shelf/annotated_shelf.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:tutotias_uni/db/conection_bd.dart';
import 'package:tutotias_uni/routes/asiganutara_routers.dart';
import 'package:tutotias_uni/routes/estudiante_routers.dart';
import 'package:tutotias_uni/routes/tutor_routes.dart';
import 'package:tutotias_uni/routes/tutorias_routes.dart';

class MainApp {
  static initApp() async {
    var router = Cascade(); // inicializa Cascade de rutas del server
    await ConectionDb.connection(); //Hacemos la conexion a la bd
    router = await mount(TutoriasRoutes(), router); // agg al cascade de router las rutas de nuestro server
    router = await mount(AsignaturaRouter(), router); // agg al cascade de router las rutas de nuestro server
    router = await mount(TutorRoutes(), router); // agg al cascade de router las rutas de nuestro server
    router = await mount(EstudianteRouters(), router); // agg al cascade de router las rutas de nuestro server

    var server = await io.serve(
        router.handler, 'localhost', 3000); //Inicializamos el server para que escuche las rutas de la app en el puerto y host designados

    // var handler = const Pipeline().addMiddleware(logRequests()).addMiddleware((innerHandler) => null).addHandler(router.handler);

    print('Serving at http://${server.address.host}:${server.port}:${server.connectionsInfo()}');
  }
}
