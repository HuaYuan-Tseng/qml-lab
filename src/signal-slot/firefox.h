#ifndef SIGNAL_SLOT_FIREFOX_H_
#define SIGNAL_SLOT_FIREFOX_H_

#include <QtCore/qtmetamacros.h>
#include <QObject>
#include <QString>

class Firefox : public QObject {
    Q_OBJECT

public:
    explicit Firefox(QObject* parent = nullptr);

public slots:
    void browse(const QString& phrase);
};

#endif  // !SIGNAL_SLOT_FIREFOX_H_
