# QML 可讀性建議與範例

下面將先給出元件內宣告的建議順序與要點，接著是一個範例元件（MyCard.qml）。

建議的元件內宣告順序（提高可讀性且易於維護）：

- Header（檔案/元件簡述）
- id
- property（先 constants/readonly/alias，再 config/data，再 visual/layout/anchors）
- signal 宣告
- public methods（helper functions）
- signal handlers（onX）
- Component.onCompleted / lifecycle 處理
- states / transitions / animations
- child items

每一群組內可依「語意／變動頻率或重要性」排序（常用或影響範圍大的屬性放前），並用註解標題、空行與一致縮排把群組分清；避免過深巢狀、複雜邏輯直接放在 QML 中，必要時抽成子元件或 JS module。

配合工具與慣例（qmllint/qmlformat、camelCase 命名、明確使用 property alias/readonly、signal 命名語意化）以及在複雜元件加上簡短 header 說明，可大幅提升整體可讀性與可維護性。

---

```qml
// MyCard.qml — 簡短說明：卡片元件範例，顯示宣告排序
import QtQuick 6.5
import QtQuick.Controls 6.5

Rectangle {
    id: root
    // ---- Constants / readonly ----
    readonly property int defaultWidth: 320
    readonly property int defaultPadding: 12

    // ---- Config / public API ----
    property string titleText: "標題"
    property color backgroundColor: "#ffffff"
    property color accentColor: "#2277ff"
    property bool selectable: true

    // ---- Data / internal state ----
    property string status: "idle" // "idle" / "loading" / "selected"
    property int implicitHeight: content.implicitHeight + defaultPadding*2

    // ---- Visual / layout ----
    width: defaultWidth
    height: implicitHeight
    color: backgroundColor
    anchors.margins: defaultPadding
    radius: 8
    border.color: "#ddd"
    border.width: 1

    // ---- Signals ----
    signal clicked(string id)
    signal selectedChanged(bool selected)

    // ---- Public methods ----
    function toggleSelect() {
        status = (status === "selected") ? "idle" : "selected";
        root.selectedChanged(status === "selected")
    }

    // ---- Signal handlers (local) ----
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            root.clicked(root.objectName || "")
            if (selectable) toggleSelect()
        }
    }

    // ---- Lifecycle ----
    Component.onCompleted: {
        console.log("MyCard loaded, width:", root.width)
    }

    // ---- States / Transitions / Animations ----
    states: State {
        name: "selected"
        when: root.status === "selected"
        PropertyChanges { target: root; scale: 1.02; border.color: accentColor }
    }
    transitions: Transition {
        from: ""; to: "selected"; reversible: true
        NumberAnimation { properties: "scale"; duration: 160; easing.type: Easing.OutQuad }
        ColorAnimation { properties: "border.color"; duration: 160 }
    }

    // ---- Child items (視覺內容放最後) ----
    Column {
        id: content
        anchors.fill: parent
        anchors.margins: defaultPadding
        spacing: 8

        Text {
            id: title
            text: titleText
            font.pixelSize: 18
            color: "#222"
        }

        Text {
            text: "說明或內容放這裡。"
            wrapMode: Text.Wrap
            color: "#555"
        }

        BusyIndicator {
            running: status === "loading"
            anchors.horizontalCenter: parent.horizontalCenter
            color: accentColor
        }
    }
}
```
