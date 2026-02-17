#ifndef AUDIOINFO_H
#define AUDIOINFO_H

#include <QObject>
#include <QUrl>
#include <qqml.h>

class AudioInfo : public QObject {
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(int songIndex READ songIndex WRITE setSongIndex NOTIFY songIndexChanged REQUIRED)
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(QString authorName READ authorName WRITE setAuthorName NOTIFY authorNameChanged)
    Q_PROPERTY(QUrl imageSource READ imageSource WRITE setImageSource NOTIFY imageSourceChanged)
    Q_PROPERTY(QUrl videoSource READ videoSource WRITE setVideoSource NOTIFY videoSourceChanged)
    Q_PROPERTY(
        QUrl audioSource READ audioSource WRITE setAudioSource NOTIFY audioSourceChanged REQUIRED)

public:
    explicit AudioInfo(QObject* parent = nullptr);

    [[nodiscard]] int songIndex() const;
    void setSongIndex(int newSongIndex);

    [[nodiscard]] QString title() const;
    void setTitle(const QString& newTitle);

    [[nodiscard]] QString authorName() const;
    void setAuthorName(const QString& newAuthorName);

    [[nodiscard]] QUrl imageSource() const;
    void setImageSource(const QUrl& newImageSource);

    [[nodiscard]] QUrl videoSource() const;
    void setVideoSource(const QUrl& newVideoSource);

    [[nodiscard]] QUrl audioSource() const;
    void setAudioSource(const QUrl& newAudioSource);

signals:
    void songIndexChanged();
    void titleChanged();
    void authorNameChanged();
    void imageSourceChanged();
    void videoSourceChanged();

    void audioSourceChanged();

private:
    int m_songIndex = 0;
    QString m_title;
    QString m_authorName;
    QUrl m_imageSource;
    QUrl m_videoSource;
    QUrl m_audioSource;
};

#endif  // AUDIOINFO_H
