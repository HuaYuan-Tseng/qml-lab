#include "application_window.h"

#include <utility>

#include <QDebug>

ApplicationWindow::ApplicationWindow(QString title, QObject* parent)
    : QObject{ parent }
    , title_{ std::move(title) }
{
    qDebug() << "Window created: " << title_;
}

ApplicationWindow::~ApplicationWindow()
{
    qDebug() << "Window closed: " << title_;
}
