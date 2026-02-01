#ifndef QOBJECT_TREE_APPLICATION_WINDOW_H_
#define QOBJECT_TREE_APPLICATION_WINDOW_H_

#include <QObject>
#include <QString>

class ApplicationWindow : public QObject {
    Q_OBJECT

public:
    explicit ApplicationWindow(QString title, QObject* paraent = nullptr);
    ~ApplicationWindow() override;

private:
    QString title_;
};

#endif  // !QOBJECT_TREE_APPLICATION_WINDOW_H_
