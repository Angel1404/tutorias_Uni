import 'package:annotated_shelf/annotated_shelf.dart';
import 'package:tutotias_uni/db/conection_bd.dart';
import 'package:tutotias_uni/helpers/names_tables.dart';
import 'package:tutotias_uni/helpers/querys_bd.dart';
import 'package:tutotias_uni/models/tutor_model.dart';
import 'package:tutotias_uni/models/tutoria_models.dart';

import '../helpers/methods.dart';

List<String> itemsList = [];

@RestAPI(baseUrl: '/tutorias_uni/dev/v1/Tutor')
class TutorRoutes {
  final db = ConectionDb.conn;

  /// POSDATA: Todos los Get ban con el metodo factory que no tiene el Override.

  @GET(url: "/")
  Future<List<TutorModel>> getAllTutores() async {
    return await getAllItems(QuerysBd.selectAllDataQuery(table: tableTutoresName), TutorModel.fromJsonToLocal, db: db);
  }

  @GET(url: "/<id>")
  getItemByName(int id) async {
    print('Id: $id');

    try {
      final list = await getAllTutores();
      print('List: $list');
      list.removeWhere((element) => element.idTutor != id);
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
  Future<RestResponse> createNewTutor(TutorModel item) async {
    try {
      final query = await db!.query(
          QuerysBd.insertQuery(table: tableTutoresName, values: item.stringValues, valuesToInsert: item.stringValuesToInsert),
          item.toListValuesInsert());
      print(query);
      return RestResponse(201, {"Response": "Tutor Creado"}, 'application/json'); // pass a shelf response
    } catch (e) {
      throw BadRequestError('item with name in list, $e');
    }
  }

  // examplo of uploading a file
  @POST(url: '/upload')
  Future<RestResponse> upload(TutoriaModels form) async {
    print(form);
    return RestResponse(201, {"msj": 'ok'}, "application/json");
  }
}