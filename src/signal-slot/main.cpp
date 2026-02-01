#include <QCoreApplication>

#include <QDebug>
#include <QVariant>
#include "firefox.h"
#include "internet_explorer.h"
#include "user_interactor.h"

int main(int argc, char** argv)
{
    QCoreApplication app(argc, argv);

    UserInteractor interactor;
    Firefox firefox;
    InternetExplorer internetExplorer;

    // QObject::connect(&interactor, &UserInteractor::phraseTyped, &firefox, &Firefox::browse);
    //
    // QObject::connect(&interactor,
    //                  &UserInteractor::phraseTyped,
    //                  &internetExplorer,
    //                  &InternetExplorer::browseRequested);

    firefox.setProperty("version", "0.0.1");

    QObject::connect(&interactor,
                     &UserInteractor::phraseTyped,
                     &app,
                     [&]()
                     {
                         QObject* obj = &interactor;
                         qDebug() << interactor.property("phrase");
                         qDebug() << obj->property("phrase");
                         qDebug() << firefox.property("version");
                     });

    interactor.getInput();

    return app.exec();
}
