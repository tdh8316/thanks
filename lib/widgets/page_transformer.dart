/*
Source code from: https://github.com/roughike/page-transformer/
 */

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// A function that builds a [PageView] lazily.
typedef PageView PageViewBuilder(
    BuildContext context, PageVisibilityResolver visibilityResolver);

/// A class that can be used to compute visibility information about
/// the current page.
class PageVisibilityResolver {
  PageVisibilityResolver({
    ScrollMetrics metrics,
    double viewPortFraction,
  })  : this._pageMetrics = metrics,
        this._viewPortFraction = viewPortFraction;

  final ScrollMetrics _pageMetrics;
  final double _viewPortFraction;

  /// Calculates visibility information for the page at [pageIndex].
  /// Used inside PageViews' itemBuilder, but can be also used in a
  /// simple PageView that simply has an array of children passed to it.
  PageVisibility resolvePageVisibility(int pageIndex) {
    final double pagePosition = _calculatePagePosition(pageIndex);
    final double visiblePageFraction =
        _calculateVisiblePageFraction(pageIndex, pagePosition);

    return PageVisibility(
      visibleFraction: visiblePageFraction,
      pagePosition: pagePosition,
    );
  }

  double _calculateVisiblePageFraction(int index, double pagePosition) {
    if (pagePosition > -1.0 && pagePosition <= 1.0) {
      return 1.0 - pagePosition.abs();
    }

    return 0.0;
  }

  double _calculatePagePosition(int index) {
    final double viewPortFraction = _viewPortFraction ?? 1.0;
    final double pageViewWidth =
        (_pageMetrics?.viewportDimension ?? 1.0) * viewPortFraction;
    final double pageX = pageViewWidth * index;
    final double scrollX = (_pageMetrics?.pixels ?? 0.0);
    final double pagePosition = (pageX - scrollX) / pageViewWidth;
    final double safePagePosition = !pagePosition.isNaN ? pagePosition : 0.0;

    if (safePagePosition > 1.0) {
      return 1.0;
    } else if (safePagePosition < -1.0) {
      return -1.0;
    }

    return safePagePosition;
  }
}

/// A class that contains visibility information about the current page.
class PageVisibility {
  PageVisibility({
    @required this.visibleFraction,
    @required this.pagePosition,
  });

  /// How much of the page is currently visible, between 0.0 and 1.0.
  ///
  /// For example, if only the half of the page is visible, the
  /// value of this is going to be 0.5.
  ///
  /// This doesn't contain information about where the page is
  /// disappearing to or appearing from. For that, see [pagePosition].
  final double visibleFraction;

  /// Tells the position of this page, relative to being visible in
  /// a "non-dragging" position, between -1.0 and 1.0.
  ///
  /// For example, if the page is fully visible, this value equals 0.0.
  ///
  /// If the page is fully out of view on the right, this value is
  /// going to be 1.0.
  ///
  /// Likewise, if the page is fully out of view, on the left, this
  /// value is going to be -1.0.
  final double pagePosition;
}

/// A widget for getting useful information about a pages' position
/// and how much of it is visible in a PageView.
///
/// Note: Does not transform pages in any way, but provides the means
/// to easily do it, in the form of [PageVisibility].
class PageTransformer extends StatefulWidget {
  PageTransformer({
    @required this.pageViewBuilder,
  });

  final PageViewBuilder pageViewBuilder;

  @override
  _PageTransformerState createState() => _PageTransformerState();
}

class _PageTransformerState extends State<PageTransformer> {
  PageVisibilityResolver _visibilityResolver;

  @override
  Widget build(BuildContext context) {
    final pageView = widget.pageViewBuilder(
        context, _visibilityResolver ?? PageVisibilityResolver());

    final controller = pageView.controller;
    final viewPortFraction = controller.viewportFraction;

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        setState(() {
          _visibilityResolver = PageVisibilityResolver(
            metrics: notification.metrics,
            viewPortFraction: viewPortFraction,
          );
        });
      },
      child: pageView,
    );
  }
}

class CardItemData {
  CardItemData({
    @required this.title,
    @required this.description,
    this.imageUrl,
    this.bottomColor = Colors.black87,
    this.topColor = const Color(0x00000000),
  });

  final String title;
  final String description;
  final String imageUrl;
  final Color bottomColor;
  final Color topColor;
}

class CardPageItem extends StatelessWidget {
  CardPageItem({
    @required this.item,
    @required this.pageVisibility,
  });

  final CardItemData item;
  final PageVisibility pageVisibility;

  Widget _applyTextEffects({
    @required double translationFactor,
    @required Widget child,
  }) {
    final double xTranslation = pageVisibility.pagePosition * translationFactor;

    return Opacity(
      opacity: pageVisibility.visibleFraction,
      child: Transform(
        alignment: FractionalOffset.topLeft,
        transform: Matrix4.translationValues(
          xTranslation,
          0.0,
          0.0,
        ),
        child: child,
      ),
    );
  }

  Widget _buildTextContainer(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var descriptionText = _applyTextEffects(
      translationFactor: 300.0,
      child: Text(
        item.title,
        style: textTheme.title
            .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );

    var titleText = _applyTextEffects(
      translationFactor: 200.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
          item.description,
          style: textTheme.caption.copyWith(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            fontSize: 14.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Positioned(
      bottom: 64.0,
      left: 32.0,
      right: 32.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          descriptionText,
          titleText,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget image = item.imageUrl != null
        ? Image.asset(
            item.imageUrl,
            fit: BoxFit.cover,
            alignment: FractionalOffset(
              0.5 + (pageVisibility.pagePosition / 3),
              0.5,
            ),
          )
        : Container();

    var imageOverlayGradient = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            item.bottomColor,
            item.topColor,
          ],
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 8.0,
      ),
      child: Material(
        elevation: 12.0,
        borderRadius: BorderRadius.circular(32.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            image,
            imageOverlayGradient,
            _buildTextContainer(context),
          ],
        ),
      ),
    );
  }
}
