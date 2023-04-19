import 'package:annotated_shelf/annotated_shelf.dart';
import 'package:tutotias_uni/db/conection_bd.dart';
import 'package:tutotias_uni/helpers/querys_bd.dart';
import 'package:tutotias_uni/models/asignatura_model.dart';
import 'package:tutotias_uni/models/tutor_model.dart';
import 'package:tutotias_uni/models/tutoria_models.dart';
import 'package:tutotias_uni/models/estudiante_model.dart';

List<String> itemsList = [];

@RestAPI(baseUrl: '/tutorias_uni/dev/v1')
class ItemsAdaptor {
  final db = ConectionDb.conn;

  @GET(url: "/tutores")
  Future<List<TutorModel>> getAllTutores() async {
    return await getAllItems(
        QuerysBd.selectAllTutoresQuery(), TutorModel.fromJson);
  }

  @GET(url: "/estudiantes")
  Future<List<EstudianteModel>> getAllEstudiantes() async {
    return await getAllItems(
        QuerysBd.selectAllEstudiantesQuery(), EstudianteModel.fromJson);
  }

  @GET(url: "/asignaturas")
  Future<List<AsignaturaModel>> getAllAsignaturas() async {
    return await getAllItems(
        QuerysBd.selectAllAsignaturasQuery(), AsignaturaModel.fromJson);
  }

  @GET(url: "/tutorias")
  Future<List<TutoriaModels>> getAllTutorias() async {
    return await getAllItems(
        QuerysBd.selectAllTutoriasQuery(), TutoriaModels.fromJson);
  }

  /* 
    Esta es una función genérica llamada getAllItems que toma dos argumentos: 
    la consulta SQL y la función fromJson 
    que se utilizará para convertir los resultados de la consulta en 
    objetos de modelo.
  */

  Future<List<T>> getAllItems<T>(String sql, Function fromJson) async {
    List<T> result = [];
    print(sql);
    final query = await db!.query(sql);
    print(query);
    for (var data in query) {
      print('Type: $data');
      result.add(fromJson(data.fields));
    }

    return result;
  }

  @GET(url: "/<id>")
  getItemByName(int id) async {
    print('Id: $id');

    try {
      final list = await getAllTutores();
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
    // print('tutoriaModelsTutoriaModels : $tutoriaModelsTutoriaModels');

    print('tutoriaModelsTutoriaModels : ${item.toJson()}');
    // final query = await db!.query(
    //     QuerysBd.insertQuery(values: tutoriaModelsTutoriaModels.stringValues, valuesToInsert: tutoriaModelsTutoriaModels.stringValuesToInsert, table: ''),
    //     tutoriaModelsTutoriaModels.toListValuesInsert());
    // print(query);

    return RestResponse(201, {"Response": "Tutoria Creada"},
        'application/json'); // pass a shelf response
    // throw BadRequestError('item with name in list, $e');
  }

  // examplo of uploading a file
  @POST(url: '/upload')
  Future<RestResponse> upload(TutoriaModels form) async {
    print(form);
    return RestResponse(201, {"msj": 'ok'}, "application/json");
  }
}
