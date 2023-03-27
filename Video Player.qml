import QtQuick 2.15
import QtMultimedia 5.15

Rectangle {
    width: 800
    height: 600

    MediaPlayer {
        id: mediaPlayer
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
        source: mediaPlayer
    }

    Rectangle {
        id: controls
        width: parent.width
        height: 50
        color: "#00000088"
        anchors.bottom: parent.bottom

        Row {
            anchors.centerIn: parent

            Button {
                id: playButton
                width: 50
                height: 50
                text: mediaPlayer.playbackState == MediaPlayer.PlayingState ? "||" : ">"
                onClicked: {
                    if (mediaPlayer.playbackState == MediaPlayer.PlayingState) {
                        mediaPlayer.pause()
                    } else {
                        mediaPlayer.play()
                    }
                }
            }

            Slider {
                id: progressSlider
                width: parent.width - playButton.width - pauseButton.width - 20
                value: mediaPlayer.position
                maximumValue: mediaPlayer.duration
                onValueChanged: mediaPlayer.position = value
            }

            Button {
                id: pauseButton
                width: 50
                height: 50
                text: "[]"
                onClicked: mediaPlayer.pause()
            }
        }
    }

    FileDialog {
        id: fileDialog
        title: "Choose video file"
        nameFilters: [ "Video files (*.mp4 *.avi)", "All files (*)" ]
        onAccepted: {
            mediaPlayer.source = fileDialog.fileUrl
            mediaPlayer.play()
        }
    }

    Component.onCompleted: {
        fileDialog.open()
    }
}
