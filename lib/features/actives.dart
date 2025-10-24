import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dart_tools/tools.dart';
import 'package:modulo_a_devlog/features/responsible.dart';

enum ActiveWarning implements WarningCode {
  notFound("Ativo não encontrado"),
  registerError("Erro ao registrar ativo"),
  ;

  @override
  final String explanation;

  const ActiveWarning(this.explanation);
}

final class Active extends Model<Active> {
  String name;
  String? description;
  String category;
  double value;
  DateTime acquisitionDate;
  int serialNumber;
  Responsible responsible;
  
  Active(super.$id, {
    required this.name,
    this.description,
    required this.category,
    required this.value,
    required this.acquisitionDate,
    required this.serialNumber,
    required this.responsible
  });

  static final repository = Repository<Active>();

  static final provider = Provider<Active>();

  static final service = ActiveService._();
}

final class ActiveUpdate extends ModelUpdate<Active> {
  final String? name;
  final String? description;
  final String? category;
  final double? value;
  final DateTime? acquisitionDate;
  final int? serialNumber;
  final Responsible? responsible;
  
  ActiveUpdate(super.$id, {
    this.name,
    this.description,
    this.category,
    this.value,
    this.acquisitionDate,
    this.serialNumber,
    this.responsible
  });
  
  @override
  Result<Active, Warning<WarningCode>> changeData(Active instance) {
    if (name != null) {
      instance.name = name!;
    }
    if (description != null) {
      instance.description = description!;
    }
    if (category != null) {
      instance.category = category!;
    }
    if (value != null) {
      instance.value = value!;
    }
    if (acquisitionDate != null) {
      instance.acquisitionDate = acquisitionDate!;
    }
    if (serialNumber != null) {
      instance.serialNumber = serialNumber!;
    }
    if (responsible != null) {
      instance.responsible = responsible!;
    }
    return Success(instance);
  }
}

final class ActiveService extends Service<Active> {
  ActiveService._();

  Future<Result<Active, Warning>> get(Id id) async {
    for (var repo in repositories) {
      final active = repo.get(id);
      if (active != null) {
        return Success(active);
      }
    }
    try {
      final query = await Supabase.instance.client
        .from("actives")
        .select()
        .eq("id", id.toString())
        .single();
      final responsibleResult = await Responsible.service.get(PartId([query['responsible_id'] as String]));
      final responsible = responsibleResult is Success ? responsibleResult.result : Responsible(PartId([query['responsible_id'] as String]), name: '', sector: '');
      final active = Active(
        PartId([query['id'] as String]),
        name: query['name'] as String,
        description: query['description'] as String?,
        category: query['category'] as String,
        value: query['value'] as double,
        acquisitionDate: DateTime.parse(query['acquisition_date'] as String),
        serialNumber: query['serial_number'] as int,
        responsible: responsible!
      );
      addInRepositories(active);
      return Success(active);
    } catch (err) {
      return Failure(Warning(ActiveWarning.notFound, err.toString()));
    }
  }

  Future<Result<List<Active>, Warning>> list() async {
    try {
      final query = await Supabase.instance.client
        .from("actives")
        .select();
      final actives = await Future.wait((query as List).map((data) async {
        final responsibleResult = await Responsible.service.get(PartId([data['responsible'] as int]));
        if (responsibleResult is Failure) {
          throw Exception("Responsável não encontrado");
        }
        final responsible = responsibleResult.result;
        // final responsible = responsibleResult is Success ? responsibleResult.result : Responsible(PartId([data['responsible'] as int]), name: '', sector: '');
        print(data);
        return Active(
          PartId([data['id'] as int]),
          name: data['name'] as String,
          description: data['description'] as String?,
          category: data['category'] as String,
          value: data['value'] as double,
          acquisitionDate: DateTime.parse(data['acquisition_date'] as String),
          serialNumber: data['serial_number'] as int,
          responsible: responsible!
        );
      }));
      return Success(actives);
    } catch (err) {
      print(err);
      return Failure(Warning(ActiveWarning.notFound, err.toString()));
    }
  }
  
  Future<Result<Active, Warning>> register({
    required String name,
    String? description,
    required String category,
    required double value,
    required DateTime acquisitionDate,
    required int serialNumber,
    required Responsible responsible
  }) async {
    try {
      final response = await Supabase.instance.client
        .from("actives")
        .insert({
          'name': name,
          'description': description,
          'category': category,
          'value': value,
          'acquisition_date': acquisitionDate.toIso8601String(),
          'serial_number': serialNumber,
          'responsible': responsible.$id.toString()
        })
        .select("id")
        .single();
      final id = response['id'] as int;
      final active = Active(
        PartId([id]),
        name: name,
        description: description,
        category: category,
        value: value,
        acquisitionDate: acquisitionDate,
        serialNumber: serialNumber,
        responsible: responsible
      );
      addInRepositories(active);
      return Success(active);
    } catch (err) {
      print(err);
      return Failure(Warning(ActiveWarning.registerError, err.toString()));
    }
  }

  Future<void> remove(Id id) async {
    try {
      await Supabase.instance.client
        .from("actives")
        .delete()
        .eq("id", id.toString());
      Active.repository.remove(
        Active.repository.get(id)!
      );
    } catch (err) {
      // log ou ignore
    }
  }
}