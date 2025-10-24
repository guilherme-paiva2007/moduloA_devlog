	// ...existing code...

import 'package:dart_tools/tools.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class ResponsibleService extends Service<Responsible> {
  Future<void> remove(Id id) async {
		try {
			await Supabase.instance.client
				.from("responsibles")
				.delete()
				.eq("id", id.toString());
			Responsible.repository.remove(Responsible.repository.get(id)!);
		} catch (err) {
			print(err);
		}
	}

	Future<Result<List<Responsible>, Warning>> list() async {
		try {
			final query = await Supabase.instance.client
				.from("responsibles")
				.select();
			final responsibles = (query as List)
				.map((data) => Responsible(
					PartId([data['id'] as int]),
					name: data['name'] as String,
					description: data['description'] as String?,
					sector: data['sector'] as String
				))
				.toList();
			return Success(responsibles);
		} catch (err) {
			return Failure(Warning(ResponsibleWarning.registerError, err.toString()));
		}
	}
	ResponsibleService._();

		Future<Result<Responsible, Warning>> register({
			required String name,
			String? description,
			required String sector,
		}) async {
			try {
				final response = await Supabase.instance.client
					.from("responsibles")
					.insert({
						'name': name,
						'description': description,
						'sector': sector
					})
					.select("id")
					.single();
				final id = response['id'] as int;
				final responsible = Responsible(
					PartId([id]),
					name: name,
					description: description,
					sector: sector
				);
				addInRepositories(responsible);
				return Success(responsible);
			} catch (err) {
				return Failure(Warning(ResponsibleWarning.registerError, err.toString()));
			}
		}

		Future<Result<Responsible, Warning>> get(Id id) async {
			for (var repo in repositories) {
				final responsible = repo.get(id);
				if (responsible != null) {
					return Success(responsible);
				}
			}
			try {
				final query = await Supabase.instance.client
					.from("responsibles")
					.select()
					.eq("id", id.toString())
					.single();
				final responsible = Responsible(
					PartId([query['id'] as int ]),
					name: query['name'] as String,
					description: query['description'] as String?,
					sector: query['sector'] as String
				);
				addInRepositories(responsible);
				return Success(responsible);
			} catch (err) {
        print(err);
				return Failure(Warning(ResponsibleWarning.registerError, err.toString()));
			}
		}
}
enum ResponsibleWarning implements WarningCode {
	registerError("Não foi possível registrar o responsável"),
	;

	@override
	final String explanation;

	const ResponsibleWarning(this.explanation);
}
final class ResponsibleUpdate extends ModelUpdate<Responsible> {
	final String? name;
	final String? description;
	final String? sector;
  
	ResponsibleUpdate(super.$id, {
		this.name,
		this.description,
		this.sector
	});
  
	@override
	Result<Responsible, Warning<WarningCode>> changeData(Responsible instance) {
		if (name != null) {
			instance.name = name!;
		}
		if (description != null) {
			instance.description = description!;
		}
		if (sector != null) {
			instance.sector = sector!;
		}
		return Success(instance);
	}
}

final class Responsible extends Model<Responsible> {
	String name;
	String? description;
	String sector;

	Responsible(super.$id, {
		required this.name,
		this.description,
		required this.sector
	});

	static final service = ResponsibleService._();

	static final repository = Repository<Responsible>();

	static final provider = Provider<Responsible>();
}
