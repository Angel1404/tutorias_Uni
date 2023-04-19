import 'package:annotated_shelf/annotated_shelf.dart';
import 'package:tutotias_uni/db/conection_bd.dart';
import 'package:tutotias_uni/helpers/querys_bd.dart';
import 'package:tutotias_uni/models/tutor_model.dart';
import 'package:tutotias_uni/models/tutoria_models.dart';

List<String> itemsList = [];

@RestAPI(baseUrl: '/tutorias_uni/dev/v1')
class ItemsAdaptor {
  final db = ConectionDb.conn;

  @GET(url: "/")
  Future<List<TutorModel>> getAllItems() async {
    List<TutorModel> result = [];
    print(QuerysBd.selectAllQuery());
    final query = await db!.query(QuerysBd.selectAllQuery());
    print(query);
    for (var data in query) {
      print('Type: $data');
      result.add(TutorModel.fromJsonToLocal(data.fields));
    }

    return result;
  }

  @GET(url: "/asignatura")
  Future<List<TutorModel>> getAllAsignaturas() async {
    List<TutorModel> result = [];
    print(QuerysBd.selectAllQuery());
    final query = await db!.query(QuerysBd.selectAllQuery());
    print(query);
    for (var data in query) {
      print('Type: $data');
      result.add(TutorModel.fromJsonToLocal(data.fields));
    }

    return result;
  }

  @GET(url: "/<id>")
  getItemByName(int id) async {
    print('Id: $id');

    try {
      final list = await getAllItems();
      print('List: $list');
      list.removeWhere((element) => element.idTutor == id);
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

  @POST(url: "/crear")
  Future<RestResponse> createNewItem(TutoriaModels item) async {
    // print('tutoriaModel : $tutoriaModel');

    print('tutoriaModel : ${item.toJson()}');
    // final query = await db!.query(
    //     QuerysBd.insertQuery(values: tutoriaModel.stringValues, valuesToInsert: tutoriaModel.stringValuesToInsert, table: ''),
    //     tutoriaModel.toListValuesInsert());
    // print(query);

    return RestResponse(201, {"Response": "Tutoria Creada"}, 'application/json'); // pass a shelf response
    // throw BadRequestError('item with name in list, $e');
  }

  // examplo of uploading a file
  @POST(url: '/upload')
  Future<RestResponse> upload(TutoriaModels form) async {
    print(form);
    return RestResponse(201, {"msj": 'ok'}, "application/json");
  }
}
