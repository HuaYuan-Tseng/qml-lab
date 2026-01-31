#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char** argv)
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    // engine.load(QUrl("qrc:/HelloQML/src/hello-qml/qml/Main.qml"));
    engine.loadFromModule("HelloQML", "Main");
    if (engine.rootObjects().isEmpty())
    {
        return -1;
    }
    return app.exec();
}
