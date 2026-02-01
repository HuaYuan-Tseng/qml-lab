#include "user_interactor.h"

#include <QDebug>
#include <QTextStream>
#include <QString>

UserInteractor::UserInteractor(QObject* parent)
    : QObject{ parent }
{
}

void UserInteractor::getInput()
{
    qDebug() << "\nType in your search phrase:\n";

    QTextStream s(stdin);
    const auto& phrase = s.readLine();

    if (!phrase.isEmpty())
    {
        this->setPhrase(phrase);
    }
}

QString UserInteractor::phrase() const
{
    return phrase_;
}

void UserInteractor::setPhrase(const QString& new_phrase)
{
    if (phrase_ == new_phrase) return;
    phrase_ = new_phrase;
    emit phraseTyped(phrase_);
}
