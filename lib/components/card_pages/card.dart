/*
Source code from: https://github.com/roughike/page-transformer/
*/

import 'package:flutter/material.dart';
import 'package:thanks/components/card_pages/card_page.dart';

class CardItemData {
  CardItemData({
    @required this.title,
    @required this.description,
    this.imageUrl,
    this.topColor = const Color(0x00000000),
    this.bottomColor = Colors.black87,
  });

  final String title;
  final String description;
  final String imageUrl;
  final Color bottomColor;
  final Color topColor;
}

class CardItem extends StatelessWidget {
  CardItem({
    @required this.item,
    @required this.pageVisibility,
  });

  final CardItemData item;
  final PageVisibility pageVisibility;

  final BorderRadius _borderRadius = BorderRadius.circular(48);

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
        padding: EdgeInsets.only(top: 16.0),
        child: Text(
          item.description,
          style: textTheme.caption.copyWith(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            letterSpacing: .1,
            fontSize: 14.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        Positioned(
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
        ),
      ],
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
        borderRadius: _borderRadius,
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
        borderRadius: _borderRadius,
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

class CardWithChild extends StatelessWidget {
  CardWithChild({
    @required this.pageVisibility,
    @required this.child,
    this.backgroundImagePath,
    this.backgroundColor,
  });

  final PageVisibility pageVisibility;
  final String backgroundImagePath;
  final Color backgroundColor;
  final Widget child;

  final BorderRadius _borderRadius = BorderRadius.circular(48);

  Widget widgetAnimationToScroll({
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 8.0,
      ),
      child: Material(
        elevation: 6.9,
        borderRadius: _borderRadius,
        color: backgroundColor != null ? backgroundColor : Colors.white,
        child: InkWell(
          borderRadius: _borderRadius,
          onTap: () {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Not Implemented'),
                behavior: SnackBarBehavior.floating,
                duration: Duration(milliseconds: 1500),
              ),
            );
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              backgroundImagePath != null
                  ? Image.asset(
                      backgroundImagePath,
                      fit: BoxFit.cover,
                      alignment: FractionalOffset(
                        0.5 + (pageVisibility.pagePosition / 3),
                        0.5,
                      ),
                    )
                  : Container(),
              // imageOverlayGradient,
              widgetAnimationToScroll(
                translationFactor: MediaQuery.of(context).size.width / 2,
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
