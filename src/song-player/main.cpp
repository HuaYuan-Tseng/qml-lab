#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>

int main(int argc, char** argv)
{
    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon("qrc:qt/qml/SongPlayer/src/song-player/asset/icon/app_icon.ico"));

    QQmlApplicationEngine engine;
    engine.loadFromModule("SongPlayer", "Main");
    if (engine.rootObjects().isEmpty())
    {
        return -1;
    }

    return app.exec();
}
