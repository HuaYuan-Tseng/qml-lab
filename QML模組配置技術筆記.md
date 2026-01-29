# Qt QML 模組配置技術筆記

## 概述

本文檔詳細說明 `qt_add_qml_module` 的參數配置、路徑關係，以及 `QQmlApplicationEngine` 的 `load()` 與 `loadFromModule()` 兩種載入方式的差異。

---

## 一、`qt_add_qml_module` 核心參數

### 1.1 URI（模組識別符）

**定義：** QML 模組的唯一識別名稱，用於 `import` 語句中。

```cmake
qt_add_qml_module(myapp
    URI QmlLab          # 模組名稱
    VERSION 1.0
)
```

**對應的 QML 使用：**
```qml
import QmlLab 1.0       // 在 QML 檔案中引入模組
```

**重要特性：**
- URI 可以是簡單名稱（如 `QmlLab`）或命名空間式（如 `com.example.QmlLab`）
- 與實際檔案路徑**無直接關係**，僅作為邏輯識別符
- 影響模組在資源系統中的預設位置

---

### 1.2 RESOURCE_PREFIX（資源前綴路徑）

**定義：** 決定 QML 模組資源在 Qt 資源系統（qrc）中的根路徑。

#### 方案一：使用自訂前綴（舊式做法）
```cmake
qt_add_qml_module(myapp
    URI QmlLab
    VERSION 1.0
    RESOURCE_PREFIX "/"          # 資源放在根目錄
    QML_FILES src/app/qml/Main.qml
)
```

**生成的資源結構：**
```
qrc:/
└── QmlLab/
    └── src/app/qml/Main.qml
```

**qmldir 內容：**
```
module QmlLab
prefer :/QmlLab/
Main 1.0 src/app/qml/Main.qml
```

#### 方案二：使用 Qt 標準前綴（推薦做法）
```cmake
qt_policy(SET QTP0001 NEW)      # 啟用 Qt 6 標準路徑政策

qt_add_qml_module(myapp
    URI QmlLab
    VERSION 1.0
    # 不設定 RESOURCE_PREFIX，使用預設值
    QML_FILES src/app/qml/Main.qml
)
```

**生成的資源結構：**
```
qrc:/qt/qml/
└── QmlLab/
    ├── qmldir
    └── src/app/qml/Main.qml
```

**qmldir 內容：**
```
module QmlLab
prefer :/qt/qml/QmlLab/
Main 1.0 src/app/qml/Main.qml
```

**重要差異：**
- `QTP0001 NEW`：資源位於 `:/qt/qml/<URI>/`（Qt 6 標準）
- 自訂前綴：資源位於 `:<RESOURCE_PREFIX>/<URI>/`
- 標準路徑是 QML 引擎的**預設搜尋位置**

---

### 1.3 QML_FILES（QML 檔案路徑）

**定義：** 指定要包含在模組中的 QML 檔案，路徑相對於 `CMakeLists.txt`。

```cmake
qt_add_qml_module(myapp
    URI QmlLab
    VERSION 1.0
    QML_FILES
        src/app/qml/Main.qml        # 相對於 CMakeLists.txt 的路徑
        src/app/qml/Components/Button.qml
        src/app/qml/Views/HomePage.qml
)
```

**路徑處理規則：**
1. 檔案路徑會被**保留在資源結構中**
2. 在 qmldir 中註冊為模組的一部分
3. 最終資源路徑 = `RESOURCE_PREFIX` + `URI` + `QML_FILES 路徑`

**範例說明：**
```cmake
# 配置
RESOURCE_PREFIX "/"
URI "QmlLab"
QML_FILES "src/app/qml/Main.qml"

# 最終資源路徑
qrc:/QmlLab/src/app/qml/Main.qml
```

---

## 二、完整路徑對應關係

### 2.1 路徑映射圖

```
檔案系統路徑 → 資源系統路徑 → QML 模組路徑
```

**範例 A：使用 QTP0001 NEW（推薦）**

```cmake
qt_policy(SET QTP0001 NEW)
qt_add_qml_module(myapp
    URI QmlLab
    QML_FILES src/app/qml/Main.qml
)
```

```
檔案系統：    src/app/qml/Main.qml
           ↓
資源系統：    qrc:/qt/qml/QmlLab/src/app/qml/Main.qml
           ↓
模組訪問：    import QmlLab 1.0
             Main { }
```

**範例 B：自訂 RESOURCE_PREFIX**

```cmake
qt_add_qml_module(myapp
    URI QmlLab
    RESOURCE_PREFIX "/"
    QML_FILES src/app/qml/Main.qml
)
```

```
檔案系統：    src/app/qml/Main.qml
           ↓
資源系統：    qrc:/QmlLab/src/app/qml/Main.qml
           ↓
模組訪問：    需要額外配置搜尋路徑
```

---

### 2.2 qmldir 檔案的作用

`qmldir` 是 QML 模組的索引檔案，由 CMake 自動生成：

```
module QmlLab                           # 模組名稱
typeinfo qml-lab-app.qmltypes          # 類型資訊檔案
prefer :/qt/qml/QmlLab/                # 資源優先路徑
Main 1.0 src/app/qml/Main.qml          # 類型註冊：名稱 版本 路徑
```

**重要概念：**
- `prefer` 指令告訴 QML 引擎資源的位置
- 類型註冊使得 QML 可以直接使用 `Main { }` 而不需要完整路徑
- qmldir 本身位於 `<RESOURCE_PREFIX>/<URI>/qmldir`

---

## 三、載入方式比較

### 3.1 `engine.load(QUrl)` - 直接載入

**方法簽名：**
```cpp
void QQmlApplicationEngine::load(const QUrl &url)
```

**特性：**
- 直接通過完整的資源 URL 載入 QML 檔案
- **不依賴模組系統**
- 需要精確的資源路徑
- 不需要 qmldir 檔案

**範例：**
```cpp
QQmlApplicationEngine engine;
engine.load(QUrl("qrc:/QmlLab/src/app/qml/Main.qml"));
```

**優點：**
- 簡單直觀
- 不需要配置模組搜尋路徑
- 適合簡單應用

**缺點：**
- 路徑硬編碼
- 無法利用模組系統的優勢
- 不符合 Qt 6 最佳實踐

---

### 3.2 `engine.loadFromModule()` - 模組載入

**方法簽名：**
```cpp
void QQmlApplicationEngine::loadFromModule(
    const QString &uri,         // 模組 URI
    const QString &typeName     // 類型名稱
)
```

**特性：**
- 透過 QML 模組系統載入
- **依賴 qmldir 檔案**
- 使用模組搜尋路徑機制
- 符合 QML 模組化設計

**範例：**
```cpp
QQmlApplicationEngine engine;
engine.loadFromModule("QmlLab", "Main");
```

**QML 引擎搜尋流程：**
```
1. 在預設搜尋路徑中查找模組：
   - qrc:/qt/qml/QmlLab/     ← Qt 6 標準路徑
   - 檔案系統路徑
   - addImportPath() 添加的路徑

2. 讀取 qmldir 檔案

3. 根據 qmldir 中的類型註冊找到 Main 類型

4. 載入對應的 QML 檔案
```

**優點：**
- 遵循 Qt 6 模組化架構
- 不需要硬編碼路徑
- 支援版本管理
- 更好的程式碼組織

**缺點：**
- 需要正確配置資源前綴
- 依賴 qmldir 檔案

---

## 四、常見問題與解決方案

### 4.1 錯誤：Module "QmlLab" contains no type named "Main"

**原因：**
QML 引擎在預設搜尋路徑中找不到模組。

**檢查清單：**
1. 是否設定 `qt_policy(SET QTP0001 NEW)`？
2. 資源是否位於 `:/qt/qml/<URI>/`？
3. qmldir 檔案是否正確生成？

**解決方案 A：使用標準路徑（推薦）**
```cmake
qt_policy(SET QTP0001 NEW)
qt_add_qml_module(myapp
    URI QmlLab
    QML_FILES src/app/qml/Main.qml
)
```

**解決方案 B：添加自訂搜尋路徑**
```cpp
// C++ 端
engine.addImportPath(":/");  // 將根目錄加入搜尋路徑
engine.loadFromModule("QmlLab", "Main");
```

---

### 4.2 資源路徑錯誤

**問題：** `load()` 載入失敗，找不到檔案。

**除錯步驟：**
```bash
# 1. 查看生成的資源結構
find build -name "*.qrc" -exec cat {} \;

# 2. 檢查 qmldir 內容
cat build/<URI>/qmldir

# 3. 確認實際資源路徑
# 在 build 目錄搜尋編譯後的 QML 檔案
find build -name "*.qml"
```

---

### 4.3 何時使用哪種載入方式？

| 情境 | 建議方式 | 理由 |
|------|----------|------|
| 新專案 | `loadFromModule()` | 符合 Qt 6 最佳實踐 |
| 簡單應用 | `load()` | 簡單快速 |
| 模組化專案 | `loadFromModule()` | 更好的程式碼組織 |
| 需要版本控制 | `loadFromModule()` | 支援版本管理 |
| 快速原型 | `load()` | 減少配置複雜度 |

---

## 五、最佳實踐建議

### 5.1 推薦配置

```cmake
# CMakeLists.txt
cmake_minimum_required(VERSION 3.21)
project(myapp)

find_package(Qt6 COMPONENTS Quick REQUIRED)

# 啟用 Qt 6 標準政策
qt_policy(SET QTP0001 NEW)
qt_standard_project_setup()

# 配置 QML 模組
qt_add_executable(myapp)
qt_add_qml_module(myapp
    URI MyApp
    VERSION 1.0
    QML_FILES
        qml/Main.qml
        qml/Components/Button.qml
)

target_link_libraries(myapp PRIVATE Qt6::Quick)
```

```cpp
// main.cpp
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    
    // 使用模組載入
    engine.loadFromModule("MyApp", "Main");
    
    if (engine.rootObjects().isEmpty())
        return -1;
        
    return app.exec();
}
```

```qml
// qml/Main.qml
import QtQuick
import QtQuick.Window

Window {
    width: 640
    height: 480
    visible: true
    title: "My Application"
}
```

---

### 5.2 目錄結構建議

```
project/
├── CMakeLists.txt
├── src/
│   ├── main.cpp
│   └── qml/
│       ├── Main.qml
│       ├── Components/
│       │   ├── Button.qml
│       │   └── TextField.qml
│       └── Views/
│           ├── HomePage.qml
│           └── SettingsPage.qml
└── build/
    └── MyApp/
        ├── qmldir                    # 自動生成
        └── qml/...                   # 複製的 QML 檔案
```

---

## 六、總結

### 關鍵概念

1. **URI**：模組的邏輯識別符，用於 import 語句
2. **RESOURCE_PREFIX**：決定資源在 qrc 系統中的位置
3. **QML_FILES**：相對於 CMakeLists.txt 的原始檔案路徑
4. **qrc 路徑**：RESOURCE_PREFIX + URI + QML_FILES 路徑

### 載入方式選擇

- **`load()`**：適合簡單場景，直接使用 qrc URL
- **`loadFromModule()`**：適合模組化專案，需要配置標準路徑

### 最重要的建議

**對於 Qt 6 新專案，始終使用：**
```cmake
qt_policy(SET QTP0001 NEW)
```
並搭配 `loadFromModule()` 進行載入，這是 Qt 官方推薦的標準做法。

---

## 參考資源

- [Qt Documentation: qt_add_qml_module](https://doc.qt.io/qt-6/qt-add-qml-module.html)
- [Qt Documentation: QTP0001 Policy](https://doc.qt.io/qt-6/qt-cmake-policy-qtp0001.html)
- [Qt Documentation: QQmlApplicationEngine](https://doc.qt.io/qt-6/qqmlapplicationengine.html)

---

*最後更新：2026-01-29*
