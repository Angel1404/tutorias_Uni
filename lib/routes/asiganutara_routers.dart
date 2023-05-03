import 'package:annotated_shelf/annotated_shelf.dart';
import 'package:tutotias_uni/db/conection_bd.dart';
import 'package:tutotias_uni/helpers/names_tables.dart';
import 'package:tutotias_uni/helpers/querys_bd.dart';
import 'package:tutotias_uni/models/asignatura_model.dart';

import '../helpers/methods.dart';

List<String> itemsList = [];

@RestAPI(baseUrl: '/tutorias_uni/dev/v1/Asignatura')
class AsignaturaRouter {
  final db = ConectionDb.conn;

  /// POSDATA: Todos los Get ban con el metodo factory que no tiene el Override.
  @GET(url: "/")
  Future<List<AsignaturaModel>> getAllAsignaturas() async {
    return await getAllItems(QuerysBd.selectAllDataQuery(table: tableAsignaturasName), AsignaturaModel.fromJsonBD, db: db);
  }

  @GET(url: "/<id>")
  getItemByName(int id) async {
    print('Id: $id');

    try {
      final list = await getAllAsignaturas();
      print('List: $list');
      list.removeWhere((element) => element.idAsignatura != id);
      return list;
    } catch (e) {
      throw NotFoundError('item not found'); // this creates a 404 response
    }
  }

  @PUT(url: "/<itemName>")
  dynamic updateItem(dynamic item, String itemName) {
    var index = itemsList.lastIndexWhere((element) => element == itemName);
    if (index >= 0) {
      itemsList[index] = item;
      return getItemByName(item.name ?? '');
    } else {
      throw NotFoundError('item not found'); // this creates a 404 response
    }
  }

  @POST(url: "/")
  Future<RestResponse> createNewAsignatura(AsignaturaModel item) async {
    try {
      final query = await db!.query(
          QuerysBd.insertQuery(table: tableAsignaturasName, values: item.stringValues, valuesToInsert: item.stringValuesToInsert),
          item.toListValuesInsert());
      print(query);
      return RestResponse(201, {"Response": "Asignatura Creada"}, 'application/json'); // pass a shelf response
    } catch (e) {
      throw BadRequestError('item with name in list, $e');
    }
  }
}
