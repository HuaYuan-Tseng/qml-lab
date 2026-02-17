import QtQuick

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

            songIndex: 0
            title: "11111111"
            authorName: "Rex.Tseng"
            imageColor: "purple"
        }

        AudioInfoBox {
            id: secondSong

            anchors {
                verticalCenter: mainSection.verticalCenter
                left: mainSection.left
                right: mainSection.right
                margins: 20
            }

            songIndex: 1
            title: "222222222"
            authorName: "Rex.Tseng"
            imageColor: "red"
        }

        AudioInfoBox {
            id: thirdSong

            anchors {
                verticalCenter: mainSection.verticalCenter
                left: mainSection.left
                right: mainSection.right
                margins: 20
            }

            songIndex: 2
            title: "3333333333"
            authorName: "Rex.Tseng"
            imageColor: "yellow"
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

            TextBotton {
                id: previousButton

                width: 50
                height: 50

                text: "<"

                onClicked: playerController.switchToPreviousSong()
            }

            TextBotton {
                id: playPauseButton

                width: 75
                height: 50

                text: playerController.playing ? "Pause" : "Play"

                onClicked: playerController.playPause()
            }

            TextBotton {
                id: nextButton

                width: 50
                height: 50

                text: ">"

                onClicked: playerController.switchToNextSong()
            }
        }
    }

    QtObject {
        id: playerController

        property int currentSongIndex: 0
        property int songCount: 3
        property bool playing: false

        function playPause() {
            playing = !playing;
        }

        function switchToPreviousSong() {
            currentSongIndex = (currentSongIndex - 1 + songCount) % songCount;
        }

        function switchToNextSong() {
            currentSongIndex = (currentSongIndex + 1) % songCount;
        }
    }
}
