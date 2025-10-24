import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modulo_a_devlog/core/constants.dart';
import 'package:modulo_a_devlog/core/navigation.dart';
import 'package:modulo_a_devlog/widgets/drawer.dart';
import 'package:modulo_a_devlog/widgets/scaffold.dart';

class Panel extends StatefulWidget {
  const Panel({super.key});

  @override
  State<Panel> createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Painel administrativo",
      body: SafeArea(
        left: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (MediaQuery.of(context).size.width > 1300) AppDrawer(),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 1200
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MediaQuery.of(context).size.width < 700 ? MainAxisAlignment.start : MainAxisAlignment.center,
                        spacing: 24,
                        children: [
                          SizedBox(
                            height: 400,
                            child: LineChart(
                              LineChartData(
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: [
                                      FlSpot(0, 1),
                                      FlSpot(1, 3),
                                      FlSpot(2, 7),
                                      FlSpot(3, 4),
                                      FlSpot(4, 5),
                                      FlSpot(5, 3),
                                      FlSpot(6, 4),
                                    ]
                                  )
                                ]
                              )
                            )
                          ),
                          Row(
                            
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            spacing: 8,
                            
                            
                          ),
                          Wrap(
                            direction: Axis.horizontal,
                            spacing: 8,
                            children: [
                              LocationCard(AppRoutes.activesList),
                              LocationCard(AppRoutes.adminsList),
                              LocationCard(AppRoutes.alertsList),
                              LocationCard(AppRoutes.responsiblesList),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationCard extends StatefulWidget {
  final AppRoute route;

  const LocationCard(this.route, {
    super.key
  });

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        // side: const BorderSide(
        //   width: 2,
        //   color: AppColors.base
        // ),
        borderRadius: AppBorderRadius.small
      ),
      color: AppColors.cyan.shade300,
      shadowColor: AppColors.base,
      child: AnimatedSwitcher(
        duration: kThemeAnimationDuration,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: MouseRegion(
          key: ValueKey("location_card_${widget.route.path}{$hovered}"),
          onEnter: (event) => setState(() {hovered = true;}),
          onExit: (event) => setState(() {hovered = false;}),
          child: Padding(
            padding: AppPaddings.big,
            child: SizedBox(
              height: 64,
              width: 96,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FaIcon(widget.route.icon, color: hovered ? Colors.white : AppColors.base, ),
                  Text(widget.route.displayName ?? "Rota sem nome", style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: hovered ? Colors.white : AppColors.base
                  ), textAlign: TextAlign.end,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}