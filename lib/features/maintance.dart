import 'package:dart_tools/tools.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class Maintance extends Model<Maintance> {
  final String type;
  // id é herdado de Model ($id)
  // Removido campo text, usar apenas description
  final DateTime createdAt;
    final int activeId; // id do ativo
  final String description;
  final String professional;
  final double cost;

  Maintance(super.$id, {
    required this.createdAt,
    required this.activeId,
    required this.description,
    required this.professional,
    required this.cost,
    required this.type,
  });

  static final service = MaintanceService._();
  static final repository = Repository<Maintance>();
  static final provider = Provider<Maintance>();
}

final class MaintanceService extends Service<Maintance> {
  MaintanceService._();

  Future<Result<List<Maintance>, Warning>> listByActive(int activeId) async {
    try {
      final query = await Supabase.instance.client
        .from('maintance')
        .select()
        .eq('active', activeId);
        final maintances = (query as List).map((data) => Maintance(
          PartId([data['id'] as int]),
          createdAt: DateTime.parse(data['created_at'] as String),
          activeId: data['active'] as int,
          description: data['description'] as String,
          professional: data['professional'] as String,
          cost: (data['cost'] as num).toDouble(),
          type: data['type'] as String,
        )).toList();
      return Success(maintances);
    } catch (err) {
      return Failure(Warning(MaintanceWarning.loadError, err.toString()));
    }
  }

  Future<Result<Maintance, Warning>> register({
    required int activeId,
    required String description,
    required String professional,
    required double cost,
    required String type,
  }) async {
    try {
      final response = await Supabase.instance.client
        .from('maintances')
        .insert({
          'description': description,
          'active': activeId,
          'professional': professional,
          'cost': cost,
          'type': type,
          'created_at': DateTime.now().toIso8601String(),
        })
        .select()
        .single();
      final maintance = Maintance(
        PartId([response['id'] as int]),
        createdAt: DateTime.parse(response['created_at'] as String),
        activeId: response['active'] as int,
        description: response['description'] as String,
        professional: response['professional'] as String,
        cost: (response['cost'] as num).toDouble(),
        type: response['type'] as String,
      );
      addInRepositories(maintance);
      return Success(maintance);
    } catch (err) {
      print(err);
      return Failure(Warning(MaintanceWarning.registerError, err.toString()));
    }
  }
}

enum MaintanceWarning implements WarningCode {
  loadError('Erro ao carregar manutenções'),
  registerError('Erro ao registrar manutenção');

  @override
  final String explanation;
  const MaintanceWarning(this.explanation);
}
