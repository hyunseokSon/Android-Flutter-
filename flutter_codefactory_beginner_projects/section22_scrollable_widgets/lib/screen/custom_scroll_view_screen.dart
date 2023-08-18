import 'package:flutter/material.dart';
import 'package:section22_scrollable_widgets/const/colors.dart';

class _SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  _SliverFixedHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  // Extent는 "높이"를 의미한다.
  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  // covariant - 상속된 클래스도 사용가능
  // oldDelegate - build가 실행이 됐을 때 이전 Delegate
  // this 가 새로운 Delegate를 의미한다.
  // shouldRebuild - 새로 build를 해야할지 말지를 결정한다.
  // false - build 안함,
  // true - 빌드 다시 함.

  // 원래 형태
  // bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
  bool shouldRebuild(_SliverFixedHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }

}

class CustomScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  CustomScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar
          renderSliverAppbar(),
          // Header
          renderHeader(),
          renderBuilderSliverList(),
          renderHeader(),
          renderSliverGridBuilder(),
          renderBuilderSliverList(),
        ],
      ),
    );
  }

  // Header
  SliverPersistentHeader renderHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverFixedHeaderDelegate(
        child:Container(
          color: Colors.black,
          child: Center(
            child: Text(
              '신기하지?',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        maxHeight: 150,
        minHeight: 75,
      ),
    );
  }


  // AppBar
  SliverAppBar renderSliverAppbar() {
    return SliverAppBar(
      // 스크롤 했을때 리스트의 중간에도 AppBar가 내려오게 할 수 있다.
      floating: true,
      // AppBar 완전 고정
      pinned: true,
      // 자석 효과
      // floating true에만 사용 가능
      snap: true,
      // 맨 위에서 한계 이상으로 스크롤 했을 때
      // 남는 공간을 차지
      stretch: true,
      expandedHeight: 200,
      collapsedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        // 맨 밑에 나온다.
        // 실질적으로는 전체 공간을 다 차지한다.
        title: Text('FlexibleSpace'),
        background: Image.asset(
          'asset/img/image_1.jpeg',
          fit: BoxFit.cover,
        ),
      ),
      title: Text('CustomScrollViewScreen'),
      backgroundColor: Colors.green,
    );
  }


  // CustomScrollView를 써야 하는 이유
  // ListView 와 GridView를 같이 썼을 때, 한 화면에 연결되도록 구현하고 싶은데
  // 다음과 같이 구현하게 되면 따로따로 스크롤할 수 있도록 구현됨.
  Widget renderWhyUseCustomScroll() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: rainbowColors
                .map((e) => renderContainer(color: e, index: 1))
                .toList(),
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            children: rainbowColors
                .map((e) => renderContainer(color: e, index: 1))
                .toList(),
          ),
        )
      ],
    );
  }

  // ListView 기본 생성자와 유사함.
  SliverList renderChildSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (e) =>
              renderContainer(
                  color: rainbowColors[e % rainbowColors.length], index: e),
        )
            .toList(),
      ),
    );
  }

  // ListView.builder 생성자와 유사함.
  SliverList renderBuilderSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return renderContainer(
              color: rainbowColors[index % rainbowColors.length], index: index);
        },
        childCount: 100,
      ),
    );
  }

  // GridView.count와 유사함
  SliverGrid renderChildSliverGrid() {
    return SliverGrid(
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (e) =>
              renderContainer(
                  color: rainbowColors[e % rainbowColors.length], index: e),
        )
            .toList(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }

  // GridView.builder와 비슷함
  SliverGrid renderSliverGridBuilder() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return renderContainer(
              color: rainbowColors[index % rainbowColors.length],
              index: index);
        },
        childCount: 100,
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150),
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    if (index != null) {
      print(index);
    }

    return Container(
      // height: height ?? 300, 처럼 작성해도 된다!
      height: height == null ? 300 : height,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}
