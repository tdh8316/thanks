/*
github.com/marcglasberg/animated_size_and_fade

Copyright 2019 by Marcelo Glasberg

Redistribution and use in source and binary forms, with or without modification, are permitted
provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions
and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of
conditions and the following disclaimer in the documentation and/or other materials provided
with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import 'package:flutter/material.dart';

class AnimatedTransition extends StatelessWidget {
  final Widget child;
  final TickerProvider vsync;
  final Duration fadeDuration;
  final Duration sizeDuration;
  final Curve fadeCurve;
  final Curve sizeCurve;
  final Alignment alignment;

  AnimatedTransition({
    Key key,
    this.child,
    @required this.vsync,
    this.fadeDuration = const Duration(milliseconds: 500),
    this.sizeDuration = const Duration(milliseconds: 500),
    this.fadeCurve = Curves.easeInOut,
    this.sizeCurve = Curves.easeInOut,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var animatedSize = AnimatedSize(
      vsync: vsync,
      child: AnimatedSwitcher(
        child: child,
        duration: fadeDuration,
        layoutBuilder: _layoutBuilder,
      ),
      duration: sizeDuration,
      curve: Curves.easeInOut,
    );

    return ClipPath(child: animatedSize);
  }

  Widget _layoutBuilder(Widget currentChild, List<Widget> previousChildren) {
    List<Widget> children = previousChildren;

    if (currentChild != null) {
      if (previousChildren == null || previousChildren.isEmpty)
        children = [currentChild];
      else {
        children = [
          Positioned(
            left: 0.0,
            right: 0.0,
            child: Container(
              child: previousChildren[0],
            ),
          ),
          Container(
            child: currentChild,
          ),
        ];
      }
    }

    return Stack(
      overflow: Overflow.visible,
      children: children,
      alignment: alignment,
    );
  }
}
