#include <QtQml/qqml.h>
#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>
#include "player_controller.h"

int main(int argc, char** argv)
{
    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon("qrc:qt/qml/SongPlayer/src/song-player/asset/icon/app_icon.ico"));

    auto* player_controller = new PlayerController(&app);
    qmlRegisterSingletonInstance("com.PlayerController",
                                 1,
                                 0,
                                 "PlayerController",
                                 player_controller);

    QQmlApplicationEngine engine;
    engine.loadFromModule("SongPlayer", "Main");
    if (engine.rootObjects().isEmpty())
    {
        return -1;
    }

    return app.exec();
}
