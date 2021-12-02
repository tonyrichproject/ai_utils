import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

typedef OnItemSelectNotifyEvent = void Function(AiBaseItem selectItem);

/// ---------------------------------------------------------------------------------
class AiBaseItem {
  int id = 0;
  int tag = 0;
  // int itemIndex = -1;

  // event that can assign from outside the class
  OnItemSelectNotifyEvent onSelectItemEvent;

  @protected
  void internalDoOnSelectItemEvent(AiBaseItem aSelectItem) {
    if (onSelectItemEvent != null) onSelectItemEvent(aSelectItem);
  }

  void notifyEvent() {
    // if object is an item that has owner then
    // raise event to owner list by this object
    if (owner != null && owner is AiBaseItem)
      (owner as AiBaseItem).internalDoOnSelectItemEvent(this);
    else
      // else just raise event
      internalDoOnSelectItemEvent(this);
  }

  AiBaseItem({this.id});

  @protected
  List<String> getMapKeys() => [];

  @protected
  void internalLoadFromMapItem(Map<String, dynamic> aMap) {/* load from http map */}

  @protected
  Map<String, dynamic> internalAsMap() => null;
  Map<String, dynamic> asMap() => internalAsMap();

  @protected
  void internalCopyFrom(dynamic aSource) {
    AiBaseItem source = aSource as AiBaseItem;
    this.onSelectItemEvent = source.onSelectItemEvent;
    this.id = source.id;
    this.tag = source.tag;
  }

  bool copyFrom(dynamic aSource) {
    if (aSource != null && aSource.runtimeType == this.runtimeType) {
      internalCopyFrom(aSource);
      return true;
    } else
      return false;
  }

  /* check if object empty by validate to some property of object */
  @protected
  bool get internalIsEmpty => id == 0;

  /* external call */
  bool get isEmpty => internalIsEmpty;

  bool get isNotEmpty => !(isEmpty);

  /* Print debug */
  void debug(dynamic aObject) {
    if (AiDebugger.instance.isLogEnabled && aObject != null) print('Debugging from AI Class name : ${this.runtimeType} - $aObject');
  }

  @protected
  void internalClearData() {
    id = 0;
    tag = 0;
    // itemIndex = -1;
    // to be implemented
  }

  void clearData() => internalClearData();

  dynamic owner;
  int get index => (owner != null && owner is AiBaseList) ? (owner as AiBaseList).items.indexOf(this) : -1;

  @protected
  bool internalIsValidJsonObj(dynamic aRawJsonDataObj) => false;

  @protected
  void internalLoadFromRawJsonDataObj(dynamic aRawJsonDataObj) {
    // to be implemented
  }

  bool loadFromRawJsonDataObj(dynamic aRawJsonDataObj) {
    bool result;
    clearData();
    result = (aRawJsonDataObj != null && internalIsValidJsonObj(aRawJsonDataObj));
    if (result) internalLoadFromRawJsonDataObj(aRawJsonDataObj);
    return result;
  }

  bool isSameObject(AiBaseItem aObject) {
    bool result = false;
    if (aObject != null && aObject == this) result = true;
    return result;
  }

  AiBaseItem findByObject(AiBaseItem aObject) => isSameObject(aObject) ? this : null;

  @protected
  bool internalIsEqualTo(AiBaseItem aComparisonObject) => false;
  // to be implemented when descendant need to compare properties of two objects that are similar class

  bool isEqualTo(AiBaseItem aComparisonObject) {
    return (aComparisonObject != null && internalIsEqualTo(aComparisonObject));
  }
}

/// ---------------------------------------------------------------------------------
class AiBaseList extends AiBaseItem {
  List<AiBaseItem> _objList;

  // @protected
  // Type getItemType() => getNewObjItem().runtimeType;

  @protected
  AiBaseItem getNewObjItem() => AiBaseItem(); // return object item of list

  @protected
  List<AiBaseItem> getObjList() => <AiBaseItem>[];

  List<AiBaseItem> get items {
    if (_objList == null) _objList = getObjList();
    return _objList;
  }

  // set items(List<AiBaseItem> aList) => _objList = aList;
  set items(List<AiBaseItem> aList) {}

  @protected
  internalLoadFromMapList(List<dynamic> aMapList) {}

  loadFromMapList(List<dynamic> aMapList, [bool aIsClearBeforeLoad = true]) {
    if (aIsClearBeforeLoad) clear(); // check if clear list before loading
    if (aMapList != null && aMapList.isNotEmpty) internalLoadFromMapList(aMapList);
  }

  bool cloneFrom(AiBaseList aSourceList) {
    if (aSourceList != null && aSourceList.isNotEmpty)
      return internalCloneFrom(aSourceList);
    else
      return false;
  }

  @protected
  bool internalCloneFrom(AiBaseList aSourceList) {
    clear();
    aSourceList.items.forEach((sourceItem) => addItem(getNewObjItem()..copyFrom(sourceItem)));
    return this.count > 0;
  }

  @override
  void internalClearData() => clear();

  AiBaseItem getItem(int aIndex) {
    var result;
    if (isNotEmpty && aIndex < this.count) result = items[aIndex];
    return result;
  }

  AiBaseItem itemByObject(AiBaseItem aObject) {
    // AiBaseItem resultObj;
    // if (aObject != null) {
    //   for (var i = 0; i < this.count; i++) {
    //     resultObj = items[i].findByObject(aObject);
    //     if (resultObj != null) break;
    //   }
    // }
    // return resultObj;
    if (aObject != null && items.indexOf(aObject) > -1)
      return aObject;
    else
      return null;
  }

  AiBaseItem itemByObjectValue(AiBaseItem aComparisonObject) {
    if (aComparisonObject == null) return null;
    // bool result = false;
    for (var i = 0; i < count; i++) {
      // Compare two objects by values
      var currItem = getItem(i);
      if (currItem.isEqualTo(aComparisonObject)) return currItem;
    }
    return null;
  }

  // Transfer methods and properties
  void clear() => items.clear();
  int get length => items.length;
  int get count => this.length;
  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;
  bool remove(AiBaseItem aItem) => items.remove(aItem);
  AiBaseItem removeAt(int aIndex) => items.removeAt(aIndex);

  // bool remove(AiBaseItem aItem) {
  //   // return items.remove(aItem);
  //   // bool result = (aItem != null && items.indexOf(aItem) != null);
  //   bool result = itemByObject(aItem) != null;
  //   if (result) result = items.remove(aItem);
  //   return result;
  // }

  void addItem(AiBaseItem item) {
    items.add(item);
    item.owner = this;
  }

  AiBaseItem addNewObjItem() {
    var newItem = this.getNewObjItem();
    addItem(newItem);
    return newItem;
  }

  void reversedItems() => items.reversed;
  // Iterable<AiBaseItem> get reversed => items.reversed;
  AiBaseItem get last => items.last;
  AiBaseItem get first => items.first;

  void printItems() {
    if (AiDebugger.instance.isLogEnabled && this.isNotEmpty) {
      for (var i = 0; i < count; i++) {
        print('Debugging from AI Base List : ${this.runtimeType} -> Item Class ${getItem(i).runtimeType} Index : ${getItem(i).index}');
      }
    }
  }
}

/// ---------------------------------------------------------------------------------
mixin AiHttpItemLoaderMixin on AiBaseItem {
  bool canLoadFromMap(Map<String, dynamic> aMap, List<String> aKeys) {
    var valid = (aMap != null) && (aKeys.isNotEmpty);
    if (valid) {
      for (String key in aKeys) {
        valid = aMap.containsKey(key);
        if (!valid) break;
      }
    }
    return valid;
  }

  loadFromMapItem(Map<String, dynamic> aMap) {
    if (canLoadFromMap(aMap, getMapKeys())) internalLoadFromMapItem(aMap);
  }

  /* response has to be single map object */
  loadFromHttpData(http.Response aResponseObj) {
    if (aResponseObj != null) {
      final mapObj = json.decode(aResponseObj.body) as Map<String, dynamic>;
      loadFromMapItem(mapObj);
    }
  }
}

/// ---------------------------------------------------------------------------------
mixin AiHttpListLoaderMixin on AiBaseList {
  // implement load from http response list
  loadFromHttpData(http.Response aResponseList, [bool aIsClearBeforeLoad = true]) {
    if (aResponseList != null) {
      final mapList = json.decode(aResponseList.body) as List<dynamic>;
      loadFromMapList(mapList, aIsClearBeforeLoad);
    }
  }
}

// / ---------------------------------------------------------------------------------
class AiBasicItem extends AiBaseItem with AiHttpItemLoaderMixin {
  AiBasicItem({int id}) : super(id: id);
}

/// ---------------------------------------------------------------------------------
/// subclass should be inherit from AiBasicList
class AiBasicList extends AiBaseList with AiHttpListLoaderMixin {
  @override
  AiBaseItem getNewObjItem() => AiBasicItem();

  @override
  List<AiBaseItem> getObjList() => <AiBasicItem>[];

  @override
  internalLoadFromMapList(List<dynamic> aMapList) {
    aMapList.forEach(
      (item) {
        var mapItem = item as Map<String, dynamic>;
        var newItem = this.getNewObjItem() as AiBasicItem;
        newItem.loadFromMapItem(mapItem);
        items.add(newItem);
      },
    );
  }
}

// / ---------------------------------------------------------------------------------

class AiDebugger extends AiBaseItem {
  // static bool logEnabled = true;

  bool _logEnabled = true;

  AiDebugger() {
    _logEnabled = true;
  }

  static AiDebugger instance = AiDebugger();
  bool get isLogEnabled => instance._logEnabled;
  static void enableLog(bool aIsEnabled) => instance._logEnabled = aIsEnabled;
}
