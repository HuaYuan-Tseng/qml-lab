#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QString>
#include "PlayerController.h"
#include "AudioInfoModel.h"
#include "AudioSearchModel.h"

int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);

    app.setWindowIcon(
        QIcon("qrc:qt/qml/SongPlayerWithHttp/src/song-player-with-http/assets/icons/app_icon.ico"));

    QQmlApplicationEngine engine;

    auto* playerController = new PlayerController(&app);
    qmlRegisterSingletonInstance("com.company.PlayerController",
                                 1,
                                 0,
                                 "PlayerController",
                                 playerController);

    auto* audioInfoModel = new AudioInfoModel(&app);
    qmlRegisterSingletonInstance("com.company.AudioInfoModel",
                                 1,
                                 0,
                                 "AudioInfoModel",
                                 audioInfoModel);

    auto* audioSearchModel = new AudioSearchModel(&app);
    qmlRegisterSingletonInstance("com.company.AudioSearchModel",
                                 1,
                                 0,
                                 "AudioSearchModel",
                                 audioSearchModel);

    const QUrl url("qrc:qt/qml/SongPlayerWithHttp/src/song-player-with-http/qml/main.qml");
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject* obj, const QUrl& objUrl)
        {
            if (!obj && url == objUrl) QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
