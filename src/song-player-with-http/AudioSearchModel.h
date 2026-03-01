#ifndef AUDIOSEARCHMODEL_H
#define AUDIOSEARCHMODEL_H

#include <cstdint>

#include <QAbstractListModel>
#include <QNetworkAccessManager>

class AudioInfo;

class AudioSearchModel : public QAbstractListModel {
    Q_OBJECT
    Q_PROPERTY(bool isSearching READ isSearching NOTIFY isSearchingChanged)

public:
    enum Role : uint16_t {
        AudioNameRole = Qt::UserRole + 1,
        AudioAuthorRole,
        AudioImageSourceRole,
        AudioSourceRole
    };

    explicit AudioSearchModel(QObject* parent = nullptr);

    [[nodiscard]] int rowCount(const QModelIndex& parent) const override;
    [[nodiscard]] QVariant data(const QModelIndex& index, int role) const override;
    [[nodiscard]] QHash<int, QByteArray> roleNames() const override;

    [[nodiscard]] bool isSearching() const;
    void setIsSearching(bool newIsSearching);

public slots:
    void searchSong(const QString& name);
    void parseData();

signals:
    void isSearchingChanged();

private:
    QList<AudioInfo*> m_audioList;
    QNetworkAccessManager m_networkManager;
    QNetworkReply* m_reply{ nullptr };
    bool m_isSearching{ false };
};

#endif  // AUDIOSEARCHMODEL_H
