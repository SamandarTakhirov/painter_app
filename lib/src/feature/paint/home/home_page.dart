import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/line_data.dart';
import 'widget/my_painter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<LineData> draw = [];
  Color selectedColor = Colors.red;
  int selectedWidth = 10;
  int selectedColorIndex = 0;

  //
  // int sliderValue = 5;
  int sliderValueDoted = 1;

  List<int> stroke = [
    ...List.generate(11, (sliderValueDoted) => sliderValueDoted * 5),
  ];

  void onPanStart(DragStartDetails details) {
    final box = context.findRenderObject() as RenderBox;
    final point = box.globalToLocal(details.globalPosition);

    draw.add(
      LineData(
        points: [point],
        color: selectedColor,
        strokeWidth: selectedWidth,
      ),
    );
    setState(() {});
  }

  void onPanUpdate(DragUpdateDetails details) {
    final box = context.findRenderObject() as RenderBox;
    final point = box.globalToLocal(details.globalPosition);

    draw[draw.length - 1].points.add(point);

    setState(() {});
  }

  void onPanEnd(DragEndDetails details) {
    setState(() {});
  }

  void clear() {
    setState(() {
      draw = [];
    });
  }

  void back() {
    setState(() {
      draw = draw.take(draw.length - 1).toList();
    });
  }

  void changeColor(({Color color, int index}) e) {
    selectedColor = e.color;
    selectedColorIndex = e.index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onPanStart: onPanStart,
              onPanUpdate: onPanUpdate,
              onPanEnd: onPanEnd,
              child: CustomPaint(
                painter: MyPainter(
                  lines: [...draw],
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height - 50,
            left: size.width - 100,
            child: IconButton(
              onPressed:
                  draw.isEmpty || draw.first.points.isEmpty ? null : back,
              icon: Icon(
                CupertinoIcons.restart,
                color: draw.isEmpty || draw.first.points.isEmpty
                    ? Colors.grey
                    : Colors.black,
              ),
            ),
          ),
          Positioned(
            top: size.height - 50,
            left: size.width - 50,
            child: IconButton(
              onPressed: draw.isEmpty ? null : clear,
              icon: Icon(
                CupertinoIcons.delete,
                color: draw.isEmpty ? Colors.grey : Colors.black,
              ),
            ),
          ),
          Positioned(
            left: size.width - 1000,
            top: 10,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Paint Color",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 80,
                          height: 110,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15)),
                                border:
                                Border.all(color: Colors.blue, width: 3)),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 55,
                                  height: 55,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                      color: selectedColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  "Active\nColor",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: selectedColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: colors
                                  .getRange(0, 6)
                                  .map<Widget>(
                                    (e) => Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: GestureDetector(
                                    onTap: () => changeColor(e),
                                    child: CircleAvatar(
                                      backgroundColor: selectedColorIndex == e.index
                                          ? Colors.black54
                                          : const Color(0x00000000),
                                      radius: 16,
                                      child: Center(
                                        child: CircleAvatar(
                                          radius: 13,
                                          backgroundColor: e.color,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                                  .toList(growable: false),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: colors
                                  .getRange(6, 12)
                                  .map<Widget>(
                                    (e) => Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: GestureDetector(
                                    onTap: () => changeColor(e),
                                    child: CircleAvatar(
                                      backgroundColor: selectedColorIndex == e.index
                                          ? Colors.black54
                                          : const Color(0x00000000),
                                      radius: 16,
                                      child: Center(
                                        child: CircleAvatar(
                                          radius: 13,
                                          backgroundColor: e.color,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                                  .toList(growable: false),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: colors
                                  .getRange(12, 18)
                                  .map<Widget>(
                                    (e) => Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: GestureDetector(
                                    onTap: () => changeColor(e),
                                    child: CircleAvatar(
                                      backgroundColor: selectedColorIndex == e.index
                                          ? Colors.black54
                                          : const Color(0x00000000),
                                      radius: 16,
                                      child: Center(
                                        child: CircleAvatar(
                                          radius: 13,
                                          backgroundColor: e.color,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                                  .toList(growable: false),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Line Stroke",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 110,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15)),
                                border:
                                Border.all(color: Colors.blue, width: 3)),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: selectedWidth.toDouble(),
                                  height: 55,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                      color: selectedColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  "Stroke width",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: selectedColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 20),
                            Row(
                              children: List.generate(
                                stroke.length,
                                    (index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: _buildStrokeChoose(
                                      stroke: stroke[index],
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 250,
                              child: Slider(
                                value: selectedWidth.toDouble(),
                                max: 50,
                                min: 0,
                                label: selectedWidth.toString(),
                                activeColor: selectedColor,
                                divisions: 10,
                                onChanged: (value) {
                                  setState(
                                        () {
                                      selectedWidth = value.toInt();
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStrokeChoose({required int stroke}) {
    bool isSelected = selectedWidth == stroke;
    return InkWell(
      onTap: () {
        setState(() {
          selectedWidth = stroke;
        });
      },
      child: Container(
        height: stroke.toDouble() * 0.65,
        width: stroke.toDouble() * 0.65,
        decoration: BoxDecoration(
          color: selectedColor,
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(
                  color: Colors.black87,
                  width: 2,
                )
              : null,
        ),
      ),
    );
  }
}
