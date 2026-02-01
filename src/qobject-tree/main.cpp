#include <QCoreApplication>
#include <QTimer>
#include "application_window.h"

int main(int argc, char** argv)
{
    QCoreApplication app(argc, argv);

    ApplicationWindow root_window("Root Window");
    auto* parent_window1 = new ApplicationWindow("Parent Window 1", &root_window);
    auto* parent_window2 = new ApplicationWindow("Parent Window 2", &root_window);

    for (int i = 0; i < 2; ++i)
    {
        auto* child_window1 =
            new ApplicationWindow(QString("Child window %1 of Parent Window 1").arg(i),
                                  parent_window1);
        auto* child_window2 =
            new ApplicationWindow(QString("Child window %1 of Parent Window 2").arg(i),
                                  parent_window2);
    }

    QTimer::singleShot(5000, [&]() { parent_window1->deleteLater(); });

    return app.exec();
}
