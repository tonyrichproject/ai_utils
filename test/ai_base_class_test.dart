import 'package:flutter_test/flutter_test.dart';
import '../lib/src/models/ai_base_model.dart';

class HtTestDataItem extends AiBasicItem {
  String name;
}

class HtTestDataList extends AiBasicList {
  @override
  List<AiBaseItem> getObjList() => <HtTestDataItem>[];

  @override
  AiBaseItem getNewObjItem() => HtTestDataItem();
}

final HtTestDataList testList = HtTestDataList();

void doAddDataList() {
  testList.clear();
  for (var i = 0; i < 10; i++) {
    (testList.addNewObjItem() as HtTestDataItem).name = 'Item number $i';
  }
  // testList.printItems();
}

void main() {
  test('adds one to input values', () {});
}
