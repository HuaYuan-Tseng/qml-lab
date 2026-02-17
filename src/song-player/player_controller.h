#ifndef PLAYERCONTROLLER_H
#define PLAYERCONTROLLER_H

#include <QObject>

class PlayerController : public QObject {
    Q_OBJECT

    Q_PROPERTY(int currentSongIndex READ currentSongIndex NOTIFY currentSongIndexChanged)
    Q_PROPERTY(int songCount READ songCount NOTIFY songCountChanged)
    Q_PROPERTY(bool playing READ playing NOTIFY playingChanged)

public:
    explicit PlayerController(QObject* parent = nullptr);

    [[nodiscard]] int currentSongIndex() const;

    [[nodiscard]] int songCount() const;

    [[nodiscard]] bool playing() const;

    // 暴露 C++ 函式給 QML 的方法(1): 在函式面前加上 `Q_INVOKABLE`
    Q_INVOKABLE void switchToNextSong();

    // 暴露 C++ 函式給 QML 的方法(2): 使用 `public slots`
public slots:
    void switchToPreviousSong();
    void playPause();

signals:
    void currentSongIndexChanged();
    void songCountChanged();
    void playingChanged();

private:
    int m_currentSongIndex = 0;
    int m_songCount = 3;
    bool m_playing = false;
};

#endif  // PLAYERCONTROLLER_H
