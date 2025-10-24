import 'package:dart_tools/tools.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class Admin extends Model<Admin> {
  final String email;
  final String name;

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
    // TODO: implement changeData
    throw UnimplementedError();
  }
}

final class AdminService extends Service<Admin> {
  AdminService._();

  Admin? _currentAuth;
  Admin? get currentAuth => _currentAuth;

  Future<Result<Admin, Warning>> login({
    required String email,
    required String password,
  }) async {
    final result = await Supabase.instance.client.auth.signInWithPassword(
      email: email,
      password: password
    );

    if (result.session != null && result.user != null) {
      return Success(
        _currentAuth = Admin(
          PartId([result.user!.aud]),
          email: email,
          name: result.user!.userMetadata?['display_name'] as String? ?? "Usuário sem nome"
        )
      );
    } else {
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

    if (result.user != null) {
      return Success(
        Admin(
          PartId([result.user!.aud]),
          email: email,
          name: name
        )
      );
    } else {
      return Failure(Warning(AdminWarning.registerError));
    }
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
}