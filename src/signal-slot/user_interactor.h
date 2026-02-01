#ifndef SIGNAL_SLOT_USER_INTERACTOR_H_
#define SIGNAL_SLOT_USER_INTERACTOR_H_

#include <QObject>
#include <QString>

class UserInteractor : public QObject {
    Q_OBJECT

public:
    explicit UserInteractor(QObject* parent = nullptr);

    void getInput();

signals:
    void phraseTyped(const QString& phrase);
};

#endif  // !SIGNAL_SLOT_USER_INTERACTOR_H_
