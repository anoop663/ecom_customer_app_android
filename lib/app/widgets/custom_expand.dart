import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../core/values/colors.dart';

// The following code is the same that is found inside the Flutter framework
//just adding the `color,disabledColor,expandedColor` for personalizing the `ExpandedIcon`

// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

const double _kPanelHeaderCollapsedHeight = kMinInteractiveDimension;
const EdgeInsets _kPanelHeaderExpandedDefaultPadding = EdgeInsets.symmetric(
  vertical: 64.0 - _kPanelHeaderCollapsedHeight,
);

class _SaltedKey<S, V> extends LocalKey {
  const _SaltedKey(this.salt, this.value);

  final S salt;
  final V value;

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is _SaltedKey<S, V> &&
        other.salt == salt &&
        other.value == value;
  }

  @override
  // ignore: deprecated_member_use
 // int get hashCode => hashValues(runtimeType, salt, value);

  @override
  String toString() {
    final String saltString = S == String ? "<'$salt'>" : '<$salt>';
    final String valueString = V == String ? "<'$value'>" : '<$value>';
    return '[$saltString $valueString]';
  }
}

/// Signature for the callback that's called when an [CustomExpansionPanel] is
/// expanded or collapsed.
///
/// The position of the panel within an [CustomExpansionPanelList] is given by
/// [panelIndex].
typedef ExpansionPanelCallback = void Function(int panelIndex, bool isExpanded);

/// Signature for the callback that's called when the header of the
/// [CustomExpansionPanel] needs to rebuild.
typedef ExpansionPanelHeaderBuilder = Widget Function(
    BuildContext context, bool isExpanded);

/// A material expansion panel. It has a header and a body and can be either
/// expanded or collapsed. The body of the panel is only visible when it is
/// expanded.
///
/// Expansion panels are only intended to be used as children for
/// [CustomExpansionPanelList].
///
/// See [CustomExpansionPanelList] for a sample implementation.
///
/// See also:
///
///  * [CustomExpansionPanelList]
///  * <https://material.io/design/components/lists.html#types>

/// An expansion panel that allows for radio-like functionality.
/// This means that at any given time, at most, one [CustomExpansionPanelRadio]
/// can remain expanded.
///
/// A unique identifier [value] must be assigned to each panel.
/// This identifier allows the [CustomExpansionPanelList] to determine
/// which [CustomExpansionPanelRadio] instance should be expanded.
///
/// See [ExpansionPanelList.radio] for a sample implementation.

class CustomExpansionPanel {
  /// Creates an expansion panel to be used as a child for [ExpansionPanelList].
  /// See [ExpansionPanelList] for an example on how to use this widget.
  ///
  /// The [headerBuilder], [body], and [isExpanded] arguments must not be null.
  CustomExpansionPanel({
    required this.headerBuilder,
    required this.body,
    this.isExpanded = false,
    this.canTapOnHeader = false,
    this.backgroundColor,
  });

  /// The widget builder that builds the expansion panels' header.
  final ExpansionPanelHeaderBuilder headerBuilder;

  /// The body of the expansion panel that's displayed below the header.
  ///
  /// This widget is visible only when the panel is expanded.
  final Widget body;

  /// Whether the panel is expanded.
  ///
  /// Defaults to false.
  final bool isExpanded;

  /// Whether tapping on the panel's header will expand/collapse it.
  ///
  /// Defaults to false.
  final bool canTapOnHeader;

  /// Defines the background color of the panel.
  ///
  /// Defaults to [ThemeData.cardColor].
  final Color? backgroundColor;
}

/// A material expansion panel list that lays out its children and animates
/// expansions.
///
/// Note that [expansionCallback] behaves differently for [CustomExpansionPanelList]
/// and [ExpansionPanelList.radio].
///
// ignore: doc_directive_missing_closing_tag
/// {@tool dartpad --template=stateful_widget_scaffold}
///
/// Here is a simple example of how to implement ExpansionPanelList.
///
/// ```dart preamble
/// // stores CustomExpansionPanel state information
/// class Item {
///   Item({
///     required this.expandedValue,
///     required this.headerValue,
///     this.isExpanded = false,
///   });
///
///   String expandedValue;
///   String headerValue;
///   bool isExpanded;
/// }
///
/// List<Item> generateItems(int numberOfItems) {
///   return List<Item>.generate(numberOfItems, (int index) {
///     return Item(
///       headerValue: 'Panel $index',
///       expandedValue: 'This is item number $index',
///     );
///   });
/// }
/// ```
///
/// ```dart
/// final List<Item> _data = generateItems(8);
///
/// @override
/// Widget build(BuildContext context) {
///   return SingleChildScrollView(
///     child: Container(
///       child: _buildPanel(),
///     ),
///   );
/// }
///
class CustomExpansionPanelRadio extends CustomExpansionPanel {
  /// An expansion panel that allows for radio functionality.
  ///
  /// A unique [value] must be passed into the constructor. The
  /// [headerBuilder], [body], [value] must not be null.
  CustomExpansionPanelRadio({
    required this.value,
    required super.headerBuilder,
    required super.body,
    super.canTapOnHeader,
    super.backgroundColor,
  });

  /// The value that uniquely identifies a radio panel so that the currently
  /// selected radio panel can be identified.
  final Object value;
}

///
/// Widget _buildPanel() {
///   return CustomExpansionPanelList(
///     expansionCallback: (int index, bool isExpanded) {
///       setState(() {
///         _data[index].isExpanded = !isExpanded;
///       });
///     },
///     children: _data.map<CustomExpansionPanel>((Item item) {
///       return CustomExpansionPanel(
///         headerBuilder: (BuildContext context, bool isExpanded) {
///           return ListTile(
///             title: Text(item.headerValue),
///           );
///         },
///         body: ListTile(
///           title: Text(item.expandedValue),
///           subtitle: const Text('To delete this panel, tap the trash can icon'),
///           trailing: const Icon(Icons.delete),
///           onTap: () {
///             setState(() {
///               _data.removeWhere((Item currentItem) => item == currentItem);
///             });
///           }
///         ),
///         isExpanded: item.isExpanded,
///       );
///     }).toList(),
///   );
/// }
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [CustomExpansionPanel]
///  * [ExpansionPanelList.radio]
///  * <https://material.io/design/components/lists.html#types>
class CustomExpansionPanelList extends StatefulWidget {
  /// Creates an expansion panel list widget. The [expansionCallback] is
  /// triggered when an expansion panel expand/collapse button is pushed.
  ///
  /// The [children] and [animationDuration] arguments must not be null.
  const CustomExpansionPanelList({
    super.key,
    this.children = const <CustomExpansionPanel>[],
    this.expansionCallback,
    this.animationDuration = kThemeAnimationDuration,
    this.expandedHeaderPadding = _kPanelHeaderExpandedDefaultPadding,
    this.dividerColor,
    this.color,
    this.disabledColor,
    this.expandedColor,
    this.elevation = 2,
  })  : _allowOnlyOnePanelOpen = false,
        initialOpenPanelValue = null;

  /// START OF CUSTOM CODE TO ADD COLOR TO EXPANDEDICON
  ///
  ///
  ///
  /// The color of the icon.
  ///
  /// Defaults to [AppColors.textColor254] when the theme's
  /// [ThemeData.brightness] is [Brightness.light] and to
  /// [AppColors.textColor160] when it is [Brightness.dark]. This adheres to the
  /// Material Design specifications for [icons](https://material.io/design/iconography/system-icons.html#color)
  /// and for [dark theme](https://material.io/design/color/dark-theme.html#ui-application)
  final Color? color;

  /// The color of the icon when it is disabled,
  /// i.e. if [onPressed] is null.
  ///
  /// Defaults to [AppColors.textColor238] when the theme's
  /// [ThemeData.brightness] is [Brightness.light] and to
  /// [AppColors.textColor138] when it is [Brightness.dark]. This adheres to the
  /// Material Design specifications for [icons](https://material.io/design/iconography/system-icons.html#color)
  /// and for [dark theme](https://material.io/design/color/dark-theme.html#ui-application)
  final Color? disabledColor;

  /// The color of the icon when the icon is expanded.
  ///
  /// Defaults to [AppColors.textColor254] when the theme's
  /// [ThemeData.brightness] is [Brightness.light] and to
  /// [AppColors.textColor1] when it is [Brightness.dark]. This adheres to the
  /// Material Design specifications for [icons](https://material.io/design/iconography/system-icons.html#color)
  /// and for [dark theme](https://material.io/design/color/dark-theme.html#ui-application)
  final Color? expandedColor;

  ///END OF CUSTOM CODE TO ADD COLOR TO EXPANDEDICON
  ///
  ///
  ///
  ///
  ///

  /// Creates a radio expansion panel list widget.
  ///
  /// This widget allows for at most one panel in the list to be open.
  /// The expansion panel callback is triggered when an expansion panel
  /// expand/collapse button is pushed. The [children] and [animationDuration]
  /// arguments must not be null. The [children] objects must be instances
  /// of [CustomExpansionPanelRadio].
  ///
  /// {@tool dartpad --template=stateful_widget_scaffold}
  ///
  /// Here is a simple example of how to implement ExpansionPanelList.radio.
  ///
  /// ```dart preamble
  /// // stores CustomExpansionPanel state information
  /// class Item {
  ///   Item({
  ///     required this.id,
  ///     required this.expandedValue,
  ///     required this.headerValue,
  ///   });
  ///
  ///   int id;
  ///   String expandedValue;
  ///   String headerValue;
  /// }
  ///
  /// List<Item> generateItems(int numberOfItems) {
  ///   return List<Item>.generate(numberOfItems, (int index) {
  ///     return Item(
  ///       id: index,
  ///       headerValue: 'Panel $index',
  ///       expandedValue: 'This is item number $index',
  ///     );
  ///   });
  /// }
  /// ```
  ///
  /// ```dart
  /// final List<Item> _data = generateItems(8);
  ///
  /// @override
  /// Widget build(BuildContext context) {
  ///   return SingleChildScrollView(
  ///     child: Container(
  ///       child: _buildPanel(),
  ///     ),
  ///   );
  /// }
  ///
  /// Widget _buildPanel() {
  ///   return ExpansionPanelList.radio(
  ///     initialOpenPanelValue: 2,
  ///     children: _data.map<CustomExpansionPanelRadio>((Item item) {
  ///       return CustomExpansionPanelRadio(
  ///         value: item.id,
  ///         headerBuilder: (BuildContext context, bool isExpanded) {
  ///           return ListTile(
  ///             title: Text(item.headerValue),
  ///           );
  ///         },
  ///         body: ListTile(
  ///           title: Text(item.expandedValue),
  ///           subtitle: const Text('To delete this panel, tap the trash can icon'),
  ///           trailing: const Icon(Icons.delete),
  ///           onTap: () {
  ///             setState(() {
  ///               _data.removeWhere((Item currentItem) => item == currentItem);
  ///             });
  ///           }
  ///         )
  ///       );
  ///     }).toList(),
  ///   );
  /// }
  /// ```
  /// {@end-tool}
  const CustomExpansionPanelList.radio({
    super.key,
    this.children = const <CustomExpansionPanelRadio>[],
    this.expansionCallback,
    this.animationDuration = kThemeAnimationDuration,
    this.initialOpenPanelValue,
    this.expandedHeaderPadding = _kPanelHeaderExpandedDefaultPadding,
    this.dividerColor,
    this.color,
    this.disabledColor,
    this.expandedColor,
    this.elevation = 2,
  })  : _allowOnlyOnePanelOpen = true;

  /// The children of the expansion panel list. They are laid out in a similar
  /// fashion to [ListBody].
  final List<CustomExpansionPanel> children;

  /// The callback that gets called whenever one of the expand/collapse buttons
  /// is pressed. The arguments passed to the callback are the index of the
  /// pressed panel and whether the panel is currently expanded or not.
  ///
  /// If ExpansionPanelList.radio is used, the callback may be called a
  /// second time if a different panel was previously open. The arguments
  /// passed to the second callback are the index of the panel that will close
  /// and false, marking that it will be closed.
  ///
  /// For ExpansionPanelList, the callback needs to setState when it's notified
  /// about the closing/opening panel. On the other hand, the callback for
  /// ExpansionPanelList.radio is simply meant to inform the parent widget of
  /// changes, as the radio panels' open/close states are managed internally.
  ///
  /// This callback is useful in order to keep track of the expanded/collapsed
  /// panels in a parent widget that may need to react to these changes.
  final ExpansionPanelCallback? expansionCallback;

  /// The duration of the expansion animation.
  final Duration animationDuration;

  // Whether multiple panels can be open simultaneously
  final bool _allowOnlyOnePanelOpen;

  /// The value of the panel that initially begins open. (This value is
  /// only used when initializing with the [ExpansionPanelList.radio]
  /// constructor.)
  final Object? initialOpenPanelValue;

  /// The padding that surrounds the panel header when expanded.
  ///
  /// By default, 16px of space is added to the header vertically (above and below)
  /// during expansion.
  final EdgeInsets expandedHeaderPadding;

  /// Defines color for the divider when [CustomExpansionPanel.isExpanded] is false.
  ///
  /// If `dividerColor` is null, then [DividerThemeData.color] is used. If that
  /// is null, then [ThemeData.dividerColor] is used.
  final Color? dividerColor;

  /// Defines elevation for the [CustomExpansionPanel] while it's expanded.
  ///
  /// This uses [kElevationToShadow] to simulate shadows, it does not use
  /// [Material]'s arbitrary elevation feature.
  ///
  /// The following values can be used to define the elevation: 0, 1, 2, 3, 4, 6,
  /// 8, 9, 12, 16, 24.
  ///
  /// By default, the value of elevation is 2.
  final double elevation;

  @override
  State<StatefulWidget> createState() => _CustomExpansionPanelListState();
}

class _CustomExpansionPanelListState extends State<CustomExpansionPanelList> {
  CustomExpansionPanelRadio? _currentOpenPanel;

  @override
  void initState() {
    super.initState();
    if (widget._allowOnlyOnePanelOpen) {
      assert(_allIdentifiersUnique(),
          'All CustomExpansionPanelRadio identifier values must be unique.');
      if (widget.initialOpenPanelValue != null) {
        _currentOpenPanel = searchPanelByValue(
            widget.children.cast<CustomExpansionPanelRadio>(),
            widget.initialOpenPanelValue);
      }
    }
  }

  @override
  void didUpdateWidget(CustomExpansionPanelList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget._allowOnlyOnePanelOpen) {
      assert(_allIdentifiersUnique(),
          'All CustomExpansionPanelRadio identifier values must be unique.');
      // If the previous widget was non-radio ExpansionPanelList, initialize the
      // open panel to widget.initialOpenPanelValue
      if (!oldWidget._allowOnlyOnePanelOpen) {
        _currentOpenPanel = searchPanelByValue(
            widget.children.cast<CustomExpansionPanelRadio>(),
            widget.initialOpenPanelValue);
      }
    } else {
      _currentOpenPanel = null;
    }
  }

  bool _allIdentifiersUnique() {
    final Map<Object, bool> identifierMap = <Object, bool>{};
    for (final CustomExpansionPanelRadio child
        in widget.children.cast<CustomExpansionPanelRadio>()) {
      identifierMap[child.value] = true;
    }
    return identifierMap.length == widget.children.length;
  }

  bool _isChildExpanded(int index) {
    if (widget._allowOnlyOnePanelOpen) {
      final CustomExpansionPanelRadio radioWidget =
          widget.children[index] as CustomExpansionPanelRadio;
      return _currentOpenPanel?.value == radioWidget.value;
    }
    return widget.children[index].isExpanded;
  }

  void _handlePressed(bool isExpanded, int index) {
    widget.expansionCallback?.call(index, isExpanded);

    if (widget._allowOnlyOnePanelOpen) {
      final CustomExpansionPanelRadio pressedChild =
          widget.children[index] as CustomExpansionPanelRadio;

      // If another CustomExpansionPanelRadio was already open, apply its
      // expansionCallback (if any) to false, because it's closing.
      for (int childIndex = 0;
          childIndex < widget.children.length;
          childIndex += 1) {
        final CustomExpansionPanelRadio child =
            widget.children[childIndex] as CustomExpansionPanelRadio;
        if (widget.expansionCallback != null &&
            childIndex != index &&
            child.value == _currentOpenPanel?.value) {
          widget.expansionCallback!(childIndex, false);
        }
      }

      setState(() {
        _currentOpenPanel = isExpanded ? null : pressedChild;
      });
    }
  }

  CustomExpansionPanelRadio? searchPanelByValue(
      List<CustomExpansionPanelRadio> panels, Object? value) {
    for (final CustomExpansionPanelRadio panel in panels) {
      if (panel.value == value) return panel;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    assert(
      kElevationToShadow.containsKey(widget.elevation),
      'Invalid value for elevation. See the kElevationToShadow constant for'
      ' possible elevation values.',
    );

    final List<MergeableMaterialItem> items = <MergeableMaterialItem>[];

    for (int index = 0; index < widget.children.length; index += 1) {
      if (_isChildExpanded(index) &&
          index != 0 &&
          !_isChildExpanded(index - 1)) {
        items.add(MaterialGap(
            key: _SaltedKey<BuildContext, int>(context, index * 2 - 1)));
      }

      final CustomExpansionPanel child = widget.children[index];
      final Widget headerWidget = child.headerBuilder(
        context,
        _isChildExpanded(index),
      );

      Widget expandIconContainer = CustomExpandIcon(
        color: widget.color,
        disabledColor: widget.disabledColor,
        expandedColor: widget.expandedColor,
        isExpanded: _isChildExpanded(index),
        size: 24.0,
        padding: EdgeInsets.zero,
        onPressed: !child.canTapOnHeader
            ? (bool isExpanded) => _handlePressed(isExpanded, index)
            : null,
      );
      if (!child.canTapOnHeader) {
        final MaterialLocalizations localizations =
            MaterialLocalizations.of(context);
        expandIconContainer = Semantics(
          label: _isChildExpanded(index)
              ? localizations.expandedIconTapHint
              : localizations.collapsedIconTapHint,
          container: true,
          child: expandIconContainer,
        );
      }
      Widget header = Row(
        children: <Widget>[
          Expanded(
            child: AnimatedContainer(
              duration: widget.animationDuration,
              curve: Curves.fastOutSlowIn,
              margin: _isChildExpanded(index)
                  ? widget.expandedHeaderPadding
                  : EdgeInsets.zero,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                    minHeight: _kPanelHeaderCollapsedHeight),
                child: headerWidget,
              ),
            ),
          ),
          expandIconContainer,
        ],
      );
      if (child.canTapOnHeader) {
        header = MergeSemantics(
          child: InkWell(
            onTap: () => _handlePressed(_isChildExpanded(index), index),
            child: header,
          ),
        );
      }
      items.add(
        MaterialSlice(
          key: _SaltedKey<BuildContext, int>(context, index * 2),
          color: child.backgroundColor,
          child: Column(
            children: <Widget>[
              header,
              AnimatedCrossFade(
                firstChild: Container(height: 0.0),
                secondChild: child.body,
                firstCurve:
                    const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
                secondCurve:
                    const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
                sizeCurve: Curves.fastOutSlowIn,
                crossFadeState: _isChildExpanded(index)
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: widget.animationDuration,
              ),
            ],
          ),
        ),
      );

      if (_isChildExpanded(index) && index != widget.children.length - 1) {
        items.add(MaterialGap(
            key: _SaltedKey<BuildContext, int>(context, index * 2 + 1)));
      }
    }

    return MergeableMaterial(
      hasDividers: true,
      dividerColor: widget.dividerColor,
      elevation: widget.elevation,
      children: items,
    );
  }
}

class CustomExpandIcon extends StatefulWidget {
  /// Creates an [CustomExpandIcon] with the given padding, and a callback that is
  /// triggered when the icon is pressed.
  const CustomExpandIcon({
    super.key,
    this.isExpanded = false,
    this.size = 24.0,
    required this.onPressed,
    this.padding = const EdgeInsets.all(8.0),
    this.color,
    this.disabledColor,
    this.expandedColor,
  });

  /// Whether the icon is in an expanded state.
  ///
  /// Rebuilding the widget with a different [isExpanded] value will trigger
  /// the animation, but will not trigger the [onPressed] callback.
  final bool isExpanded;

  /// The size of the icon.
  ///
  /// This property must not be null. It defaults to 24.0.
  final double size;

  /// The callback triggered when the icon is pressed and the state changes
  /// between expanded and collapsed. The value passed to the current state.
  ///
  /// If this is set to null, the button will be disabled.
  final ValueChanged<bool>? onPressed;

  /// The padding around the icon. The entire padded icon will react to input
  /// gestures.
  ///
  /// This property must not be null. It defaults to 8.0 padding on all sides.
  final EdgeInsetsGeometry padding;

  /// The color of the icon.
  ///
  /// Defaults to [AppColors.textColor254] when the theme's
  /// [ThemeData.brightness] is [Brightness.light] and to
  /// [AppColors.textColor160] when it is [Brightness.dark]. This adheres to the
  /// Material Design specifications for [icons](https://material.io/design/iconography/system-icons.html#color)
  /// and for [dark theme](https://material.io/design/color/dark-theme.html#ui-application)
  final Color? color;

  /// The color of the icon when it is disabled,
  /// i.e. if [onPressed] is null.
  ///
  /// Defaults to [Colors.black38] when the theme's
  /// [ThemeData.brightness] is [Brightness.light] and to
  /// [Colors.white38] when it is [Brightness.dark]. This adheres to the
  /// Material Design specifications for [icons](https://material.io/design/iconography/system-icons.html#color)
  /// and for [dark theme](https://material.io/design/color/dark-theme.html#ui-application)
  final Color? disabledColor;

  /// The color of the icon when the icon is expanded.
  ///
  /// Defaults to [Colors.black54] when the theme's
  /// [ThemeData.brightness] is [Brightness.light] and to
  /// [Colors.white] when it is [Brightness.dark]. This adheres to the
  /// Material Design specifications for [icons](https://material.io/design/iconography/system-icons.html#color)
  /// and for [dark theme](https://material.io/design/color/dark-theme.html#ui-application)
  final Color? expandedColor;

  @override
  State<CustomExpandIcon> createState() => _CustomExpandIconState();
}

class _CustomExpandIconState extends State<CustomExpandIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconTurns;

  static final Animatable<double> _iconTurnTween =
      Tween<double>(begin: 0.0, end: 0.5)
          .chain(CurveTween(curve: Curves.fastOutSlowIn));

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: kThemeAnimationDuration, vsync: this);
    _iconTurns = _controller.drive(_iconTurnTween);
    // If the widget is initially expanded, rotate the icon without animating it.
    if (widget.isExpanded) {
      _controller.value = math.pi;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CustomExpandIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  void _handlePressed() {
    widget.onPressed?.call(widget.isExpanded);
  }

  /// Default icon colors and opacities for when [Theme.brightness] is set to
  /// [Brightness.light] are based on the
  /// [Material Design system icon specifications](https://material.io/design/iconography/system-icons.html#color).
  /// Icon colors and opacities for [Brightness.dark] are based on the
  /// [Material Design dark theme specifications](https://material.io/design/color/dark-theme.html#ui-application)
  Color get _iconColor {
    if (widget.isExpanded && widget.expandedColor != null) {
      return widget.expandedColor!;
    }

    if (widget.color != null) {
      return widget.color!;
    }

    switch (Theme.of(context).brightness) {
      case Brightness.light:
        return AppColors.black54;
      case Brightness.dark:
        return AppColors.white60;
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final String onTapHint = widget.isExpanded
        ? localizations.expandedIconTapHint
        : localizations.collapsedIconTapHint;

    return Semantics(
      onTapHint: widget.onPressed == null ? null : onTapHint,
      child: IconButton(
        splashRadius: 1,
        padding: widget.padding,
        iconSize: widget.size,
        color: _iconColor,
        disabledColor: widget.disabledColor,
        onPressed: widget.onPressed == null ? null : _handlePressed,
        icon: RotationTransition(
          turns: _iconTurns,
          child: const Icon(Icons.expand_more),
        ),
      ),
    );
  }
}
