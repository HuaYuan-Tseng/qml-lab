#include <QCoreApplication>

#include "firefox.h"
#include "internet_explorer.h"
#include "user_interactor.h"

int main(int argc, char** argv)
{
    QCoreApplication app(argc, argv);

    UserInteractor interactor;
    Firefox firefox;
    InternetExplorer internetExplorer;

    QObject::connect(&interactor, &UserInteractor::phraseTyped, &firefox, &Firefox::browse);
    QObject::connect(&interactor,
                     &UserInteractor::phraseTyped,
                     &internetExplorer,
                     &InternetExplorer::browseRequested);

    interactor.getInput();

    return app.exec();
}
