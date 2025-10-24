import 'package:dart_tools/tools.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class Admin extends Model<Admin> {
  String email;
  String name;

  Admin(super.$id, {
    required this.email,
    required this.name
  });

  static final service = AdminService._();

  static final repository = Repository<Admin>();

  static final provider = Provider<Admin>();
}

enum AdminWarning implements WarningCode {
  loginError("Não foi possível iniciar uma sessão"),
  registerError("Não foi possível criar uma nova conta"),;

  @override
  final String explanation;

  const AdminWarning(this.explanation);
}

final class AdminUpdate extends ModelUpdate<Admin> {
  final String? email;
  final String? name;
  
  AdminUpdate(super.$id, {
    this.email,
    this.name
  });
  
  @override
  Result<Admin, Warning<WarningCode>> changeData(Admin instance) {
    if (email != null) {
      instance.email = email!;
    }
    if (name != null) {
      instance.name = name!;
    }
    return Success(instance);
  }
}

final class AdminService extends Service<Admin> {
  Future<void> remove(Id id) async {
    try {
      await Supabase.instance.client
        .from("admins")
        .delete()
        .eq("auth", id.toString());
      Admin.repository.remove(Admin.repository.get(id)!);
    } catch (err) {
      // log ou ignore
    }
  }
  Future<Result<List<Admin>, Warning>> list() async {
    try {
      final query = await Supabase.instance.client
        .from("admins")
        .select();
      final admins = (query as List)
        .map((data) => Admin(
          PartId([data['auth'] as String]),
          email: data['email'] as String,
          name: data['name'] as String
        ))
        .toList();
      return Success(admins);
    } catch (err) {
      return Failure(Warning(AdminWarning.registerError, err.toString()));
    }
  }
  AdminService._();

  Admin? _currentAuth;
  Admin? get currentAuth => _currentAuth;

  Future<Result<Admin, Warning>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password
      );
      if (result.session == null || result.user == null) {
        return Failure(Warning(AdminWarning.loginError, "Sessão inválida"));
      }

      final query = await Supabase.instance.client
        .from("admins")
        .select()
        .eq("auth", result.user!.id)
        .single();

      _currentAuth = Admin(
        PartId([result.user!.aud]),
        email: query['email'] as String,
        name: query['name'] as String
      );

      addInRepositories(_currentAuth!);

      return Success(_currentAuth!);
    } catch (err) {
      print(err);
      return Failure(Warning(AdminWarning.loginError));
    }
  }

  Future<void> logout() async {
    await Supabase.instance.client.auth.signOut();
    _currentAuth = null;
  }

  Future<Result<Admin, Warning>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final result = await Supabase.instance.client.auth.signUp(
      email: email,
      password: password,
      data: {
        'display_name': name
      }
    );

    if (result.user == null) {
      return Failure(Warning(AdminWarning.registerError));
    }

    await Supabase.instance.client
      .from("admins")
      .insert({
        'auth': result.user!.id,
        'email': email,
        'name': name
      });
    
    return Success(
      Admin(
        PartId([result.user!.aud]),
        email: email,
        name: name
      )
    );
  }

  Future<Result<AdminUpdate, Warning>> update({ String? name, String? email, String? password }) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      return Failure(Warning(AdminWarning.loginError));
    }

    final result = await Supabase.instance.client.auth.updateUser(
      UserAttributes(
        email: email,
        password: password,
        data: {
          if (name != null) 'display_name': name
        }
      )
    );

    Supabase.instance.client.from("admins")
      .update({
        if (name != null) 'name': name,
        if (email != null) 'email': email
      })
      .eq('auth', user.id);

    if (result.user != null) {
      final adminUpdate = AdminUpdate(
        PartId([result.user!.aud]),
        name: name,
        email: email
      );
      adminUpdate.update(_currentAuth!);
      return Success(adminUpdate);
    } else {
      return Failure(Warning(AdminWarning.loginError));
    }
  }

  Future<Result<Admin, Warning>> get(Id id) async {
    for (var repo in repositories) {
      final admin = repo.get(id);
      if (admin != null) {
        return Success(admin);
      }
    }

    final query = await Supabase.instance.client
      .from("admins")
      .select()
      .eq("auth", id.toString())
      .single();
    
    final admin = Admin(
      PartId([query['auth'] as String]),
      email: query['email'] as String,
      name: query['name'] as String
    );

    addInRepositories(admin);

    return Success(admin);
  }
}