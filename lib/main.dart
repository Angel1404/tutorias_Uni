import 'package:annotated_shelf/annotated_shelf.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:tutotias_uni/db/conection_bd.dart';
import 'package:tutotias_uni/routes/tutorias_routes.dart';

class MainApp {
  static initApp() async {
    var router = Cascade();
    await ConectionDb.connection();
    router = await mount(ItemsAdaptor(), router);
    router = await mount(ItemsAdaptor(), router);

    var server = await io.serve(router.handler, 'localhost', 3000);

    // var handler = const Pipeline().addMiddleware(logRequests()).addMiddleware((innerHandler) => null).addHandler(router.handler);

    print('Serving at http://${server.address.host}:${server.port}:${server.connectionsInfo()}');
  }
}
