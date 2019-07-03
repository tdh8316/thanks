import 'package:flutter/widgets.dart';
import 'package:thanks/widgets/skeleton.dart';

class Index extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<Index> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Skeleton(
      child: null,
    );
  }
}
