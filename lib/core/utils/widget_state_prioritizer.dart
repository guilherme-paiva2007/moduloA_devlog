import 'package:flutter/material.dart';

const _priority = [
  WidgetState.focused,
  WidgetState.dragged,
  WidgetState.pressed,
  WidgetState.selected,
  WidgetState.hovered,
  WidgetState.scrolledUnder,
];

final class WidgetStatePriority {
  final WidgetStatesConstraint state;
  final bool error;
  final bool disabled;

  WidgetStatePriority._(this.state, this.error, this.disabled);

  factory WidgetStatePriority(Iterable<WidgetState> states) {
    int? index;

    late WidgetState state;
    for (state in states) {
      final stateIndex = _priority.indexOf(state);
      stateIndex == -1
        ? null
        : index != null && index < stateIndex
          ? null
          : index = stateIndex;
    }

    return WidgetStatePriority._(
      index == null ? WidgetState.any : _priority[index],
      states.contains(WidgetState.error),
      states.contains(WidgetState.disabled),
    );
  }
}