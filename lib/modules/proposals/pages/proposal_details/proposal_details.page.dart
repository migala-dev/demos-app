import 'package:flutter/material.dart';

class ProposalDetailsPage extends StatefulWidget {
  const ProposalDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProposalDetailsPage> createState() => _ProposalDetailsPageState();
}

class _ProposalDetailsPageState extends State<ProposalDetailsPage> {
  final ScrollController _controller = ScrollController();

  bool silverCollapsed = false;

  String myTitle = 'default titledefault titledefault titledefault titledefault titledefault titledefault titledefault titledefault title';
  Widget Function()? getAppBarWidget;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.offset > 100 && !_controller.position.outOfRange) {
        if (!silverCollapsed) {
          setState(() {
            getAppBarWidget = getCollapsedTextWidget;
            silverCollapsed = true;
          });
        }
      }
      if (_controller.offset < 100 && !_controller.position.outOfRange) {
        if (silverCollapsed) {
          setState(() {
            getAppBarWidget = getExpandedTextWidget;
            silverCollapsed = false;
          });
        }
      }
    });
    getAppBarWidget = getExpandedTextWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _controller,
        headerSliverBuilder: (BuildContext context, bool isScroll) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: const Color(0xFFEFB355),
              expandedHeight: MediaQuery.of(context).size.height * 0.3,
              pinned: true,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext cont, BoxConstraints constraints) {
                  return FlexibleSpaceBar(
                    title: getAppBarWidget != null ? getAppBarWidget!() : Container(),
                  );
                },
              ),
            )
          ];
        },
        body: const Center(),
      ),
    );
  }

  Widget getCollapsedTextWidget() {
    return Text (
      myTitle,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget getExpandedTextWidget() {
    return Text (
      myTitle,
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
    );
  }
}
