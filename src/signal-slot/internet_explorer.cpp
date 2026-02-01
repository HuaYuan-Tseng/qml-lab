#include "internet_explorer.h"

#include <QDebug>

InternetExplorer::InternetExplorer(QObject* parent)
    : QObject{ parent }
{
    timer_.setInterval(10000);
    timer_.setSingleShot(true);

    connect(this, &InternetExplorer::browseRequested, &timer_, qOverload<>(&QTimer::start));
    connect(&timer_, &QTimer::timeout, this, &InternetExplorer::browse);
}

void InternetExplorer::browse()
{
    qDebug() << "Internet Explorer is not responding...";
}
