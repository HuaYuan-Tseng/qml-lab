import QtQuick
import com.PlayerController

Window {
    id: root

    width: 640
    height: 480

    visible: true

    title: qsTr("Song Player")

    Rectangle {
        id: topbar

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        height: 50
        color: "#5F8575"
    }

    Rectangle {
        id: mainSection

        anchors {
            top: topbar.bottom
            bottom: bottombar.top
            left: parent.left
            right: parent.right
        }

        color: "#1E1E1E"

        AudioInfoBox {
            id: firstSong

            anchors {
                verticalCenter: mainSection.verticalCenter
                left: mainSection.left
                right: mainSection.right
                margins: 20
            }

            infoProvider {
                songIndex: 0
                title: "11111111"
                authorName: "Rex.Tseng"
                imageSource: "qrc:qt/qml/SongPlayer/src/song-player/asset/image/song_1.jpg"
                audioSource: "qrc:qt/qml/SongPlayer/src/song-player/asset/audio/air_on_the_g_string.mp3"
            }
        }

        AudioInfoBox {
            id: secondSong

            anchors {
                verticalCenter: mainSection.verticalCenter
                left: mainSection.left
                right: mainSection.right
                margins: 20
            }

            infoProvider {
                songIndex: 1
                title: "222222222"
                authorName: "Rex.Tseng"
                imageSource: "qrc:qt/qml/SongPlayer/src/song-player/asset/image/song_2.jpg"
                audioSource: "qrc:qt/qml/SongPlayer/src/song-player/asset/audio/eine_kleine_nachtmusik.mp3"
            }
        }

        AudioInfoBox {
            id: thirdSong

            anchors {
                verticalCenter: mainSection.verticalCenter
                left: mainSection.left
                right: mainSection.right
                margins: 20
            }

            infoProvider {
                songIndex: 2
                title: "3333333333"
                authorName: "Rex.Tseng"
                imageSource: "qrc:qt/qml/SongPlayer/src/song-player/asset/image/song_3.jpg"
                videoSource: "qrc:qt/qml/SongPlayer/src/song-player/asset/video/video_1.avi"
                audioSource: "qrc:qt/qml/SongPlayer/src/song-player/asset/audio/symphony_no_5.mp3"
            }
        }
    }

    Rectangle {
        id: bottombar

        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        height: 100
        color: "#333333"

        Row {
            anchors.centerIn: parent

            spacing: 20

            ImageBotton {
                id: previousButton

                width: 64
                height: 64

                source: "qrc:/qt/qml/SongPlayer/src/song-player/asset/icon/previous_icon.png"

                onClicked: PlayerController.switchToPreviousSong()
            }

            ImageBotton {
                id: playPauseButton

                width: 64
                height: 64

                source: PlayerController.playing ? "qrc:qt/qml/SongPlayer/src/song-player/asset/icon/pause_icon.png" : "qrc:/qt/qml/SongPlayer/src/song-player/asset/icon/play_icon.png"

                onClicked: PlayerController.playPause()
            }

            ImageBotton {
                id: nextButton

                width: 64
                height: 64

                source: "qrc:/qt/qml/SongPlayer/src/song-player/asset/icon/next_icon.png"

                onClicked: PlayerController.switchToNextSong()
            }
        }
    }
}
