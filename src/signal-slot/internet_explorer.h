#ifndef SIGNAL_SLOT_INTERNET_EXPLORER_H_
#define SIGNAL_SLOT_INTERNET_EXPLORER_H_

#include <QObject>
#include <QTimer>

class InternetExplorer : public QObject {
    Q_OBJECT

public:
    explicit InternetExplorer(QObject* parent = nullptr);

public slots:
    void browse();

signals:
    void browseRequested(const QString& phrase);

private:
    QTimer timer_;
};

#endif  // !SIGNAL_SLOT_INTERNET_EXPLORER_H_
