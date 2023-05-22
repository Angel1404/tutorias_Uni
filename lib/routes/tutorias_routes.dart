import 'package:annotated_shelf/annotated_shelf.dart';
import 'package:tutotias_uni/db/conection_bd.dart';
import 'package:tutotias_uni/helpers/names_tables.dart';
import 'package:tutotias_uni/helpers/querys_bd.dart';
import 'package:tutotias_uni/models/tutoria_models.dart';

import '../helpers/methods.dart';

List<String> itemsList = [];

@RestAPI(baseUrl: '/tutorias_uni/dev/v1/Tutorias')
class TutoriasRoutes {
  final db = ConectionDb.conn;

  @GET(url: "/")
  Future<RestResponse> getAllTutorias() async {
    try {
      final List<TutoriaModels> responseBD =
          await getAllItems(QuerysBd.selectAllDataQuery(table: tableTutoriasName), TutoriaModels.fromJsonBD, db: db);
      return RestResponse(200, responseBD, 'application/json');
    } catch (e) {
      return RestResponse(404, {"error": e}, 'application/json');
    }
  }

  @GET(url: "/<id>")
  Future<RestResponse> getItemByName(int id) async {
    print('Id: $id');

    try {
      final list = await db!.query(QuerysBd.selectOnlyData(id: id));
      print('List: ${list.first.fields}');
      if (list.first.fields.isEmpty) {
        return RestResponse(404, {}, 'application/json');
      }
      final turoria = TutoriaModels.fromJsonBD(list.first.fields);
      return RestResponse(201, {"Response": turoria.toJson()}, 'application/json');
    } catch (e) {
      throw NotFoundError('item not found'); // this creates a 404 response
    }
  }

  /*
    
    TODO: Post para crear cualquiera, listo.
    Solo basta con cambiar el modelo al cual apuntar y pasar el parametro por la funcion:

    TODO: QuerysBd.insertQuery();

    donde values: Son la cantidad de valores que se van a insertar en interrogativa Ej. (?,?,?)
    donde valuesToInsert: son los valores que se van a insertar en orden a los interrogantes.    
    donde item.toListValuesInsert() : Es el mapa de los valores con datos que se van a insertar en orden a los valuesToInser y values.

  */

  @POST(url: "/")
  Future<RestResponse> createNewTutoria(TutoriaModels item) async {
    try {
      final query =
          await db!.query(QuerysBd.insertQuery(values: item.stringValues, valuesToInsert: item.stringValuesToInsert), item.toListValuesInsert());
      print(query);
      return RestResponse(201, {"Response": "Tutoria Creada"}, 'application/json'); // pass a shelf response
    } catch (e) {
      throw BadRequestError('item with name in list, $e');
    }
  }

  @PUT(url: "/<id>")
  dynamic updateTutoria(int id, TutoriaModels item) async {
    try {
      final query =
          await db!.query(QuerysBd.updateQyery(id: id, idText: 'id_tutoria', valuesToUpdate: item.updateValues()), item.toListValuesUpdate());
      print(query);

      return RestResponse(200, {"Response": "Tutoria actualizada"}, 'application/json'); // pass a shelf response
    } catch (e) {
      print(e);
      throw BadRequestError('item with name in list, $e');
    }
  }

  @DELETE(url: '/<id>')
  dynamic deteteTutoria(int id) async {
    try {
      final query = await db!.query(QuerysBd.updateQyery(id: id, idText: 'id_tutoria', valuesToUpdate: 'estado = 0'));
      print(query);

      return RestResponse(200, {"Response": "Tutoria eliminada"}, 'application/json'); // pass a shelf response
    } catch (e) {
      throw BadRequestError('item with name in list, $e');
    }
  }
}
