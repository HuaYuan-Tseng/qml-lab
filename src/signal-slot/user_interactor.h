#ifndef SIGNAL_SLOT_USER_INTERACTOR_H_
#define SIGNAL_SLOT_USER_INTERACTOR_H_

#include <QtCore/qtmetamacros.h>
#include <QObject>
#include <QString>

class UserInteractor : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString phrase READ phrase WRITE setPhrase NOTIFY phraseTyped)

public:
    explicit UserInteractor(QObject* parent = nullptr);

    void getInput();

    [[nodiscard]] QString phrase() const;
    void setPhrase(const QString& new_phrase);

signals:
    void phraseTyped(const QString& phrase);

private:
    QString phrase_;
};

#endif  // !SIGNAL_SLOT_USER_INTERACTOR_H_
