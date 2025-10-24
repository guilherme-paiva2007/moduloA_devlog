part of '../navigation.dart';

abstract final class AppRoutes {
  static late final AppRoute login;
  static late final AppRoute panel;
  static late final AppRoute activesList;
  static late final AppRoute activesDetails;
  static late final AppRoute activesAdd;
  static late final AppRoute activesMaintances;
  static late final AppRoute activesMaintanceAdd;
  static late final AppRoute activesMaintanceDetails;
  static late final AppRoute adminsList;
  static late final AppRoute adminsDetails;
  static late final AppRoute adminsAdd;
  static late final AppRoute alertsList;
  static late final AppRoute alertsDetails;
  static late final AppRoute alertsAdd;
  static late final AppRoute responsiblesList;
  static late final AppRoute responsiblesDetails;
  static late final AppRoute responsiblesAdd;
  static late final AppRoute aiAnalysis;
  static late final AppRoute aiAssistant;
  static late final AppRoute aiMaintancePreview;

  static AppRouter createRouter(bool initWithSession) {
    return AppRouter([
      login = AppRoute(
        parts: "entrar",
        builder: (context, state) => const Login(),
      ),
      panel = AppRoute(
        parts: "painel",
        displayName: "Painel",
        icon: FontAwesomeIcons.gauge,
        showOnDrawer: true,
        builder: (context, state) => const Panel(),
      ),
      activesList = AppRoute(
        parts: "ativos",
        builder: (context, state) => const ActivesList(),
        displayName: "Ativos",
        icon: FontAwesomeIcons.list,
        showOnDrawer: true,
        subroutes: [
          activesAdd = AppRoute(
            parts: "adicionar",
            builder: (context, state) => const ActiveAdd(),
          ),
          activesDetails = AppRoute(
            parts: ":id",
            builder: (context, state) => ActiveDetails(
              // id: state.pathParameters["id"]!,
            ),
          ),
          activesMaintances = AppRoute(
            parts: ":id/maintances/listar",
            builder: (context, state) {
              final active = state.extra;
              return MaintanceListScreen(activeId: int.tryParse(state.pathParameters["id"] ?? "0") ?? 0);
            },
          ),
          activesMaintanceAdd = AppRoute(
            parts: ":id/maintances/adicionar",
            builder: (context, state) {
              final active = state.extra;
              return MaintanceAddScreen(activeId: state.pathParameters["id"] ?? "0");
            },
          ),
          activesMaintanceDetails = AppRoute(
            parts: ":active_id/manutencoes/:maintance_id",
            builder: (context, state) => ActiveMaintanceDetails(
              // active_id: state.pathParameters["active_id"]!,
              // maintance_id: state.pathParameters["maintance_id"]!,
            ),
          ),
        ]
      ),
      adminsList = AppRoute(
        parts: "admins",
        builder: (context, state) => const AdminsList(),
        displayName: "Admins",
        icon: FontAwesomeIcons.userLock,
        showOnDrawer: true,
        subroutes: [
          adminsAdd = AppRoute(
            parts: "adicionar",
            builder: (context, state) => const AdminAdd(),
          ),
          adminsDetails = AppRoute(
            parts: ":id",
            builder: (context, state) => AdminDetails(
              // id: state.pathParameters["id"]!,
            ),
          ),
        ]
      ),
      alertsList = AppRoute(
        parts: "alertas",
        builder: (context, state) => const AlertsList(),
        displayName: "Alertas",
        icon: FontAwesomeIcons.bell,
        showOnDrawer: true,
        subroutes: [
          alertsAdd = AppRoute(
            parts: "adicionar",
            builder: (context, state) => const AlertAdd(),
          ),
          alertsDetails = AppRoute(
            parts: ":id",
            builder: (context, state) => AlertDetails(
              // id: state.pathParameters["id"]!,
            ),
          ),
        ]
      ),
      responsiblesList = AppRoute(
        parts: "responsaveis",
        builder: (context, state) => const ResponsiblesList(),
        displayName: "Destinatários",
        icon: FontAwesomeIcons.paperPlane,
        showOnDrawer: true,
        subroutes: [
          responsiblesAdd = AppRoute(
            parts: "adicionar",
            builder: (context, state) => const ResponsibleAdd(),
          ),
          responsiblesDetails = AppRoute(
            parts: ":id",
            builder: (context, state) => ResponsibleDetails(
              // id: state.pathParameters["id"]!,
            ),
          ),
        ]
      ),
      aiAssistant = AppRoute(
        parts: "ia",
        builder: (context, state) => const AiAssistant(),
        displayName: "Assistente IA",
        icon: FontAwesomeIcons.robot,
        showOnDrawer: true,
        subroutes: [
          aiAnalysis = AppRoute(
            parts: "analise-desempenho",
            builder: (context, state) => const AiAssistant(),
          ),
          aiMaintancePreview = AppRoute(
            parts: "previsao-manutencao",
            builder: (context, state) => const AiMaintancePreview(),
          ),
        ]
      ),
    ], initialRoute: initWithSession ? panel : login);
  }
}
