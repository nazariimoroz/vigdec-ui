import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Basic
import "." as App

ApplicationWindow {
    id: applicationWindow
    height: 400
    width: 400
    title: "Vigenère decoder"
    visible: true

    property alias decoder: mainStackView.initialItem

    header: ToolBar {
        RowLayout {
            anchors.fill: parent

            ToolButton {
                id: backButton
                text: mainStackView.depth > 1 ? "‹" : " "
                onClicked: mainStackView.pop()
            }

            Label {
                Layout.fillWidth: true

                text: "Vigenère decoder"
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter

                font.pointSize: 15
            }

            Rectangle {
                color: Qt.rgba(0,0,0,0)
                Layout.preferredWidth: backButton.width
                Layout.fillHeight: true
            }
        }
    }

    StackView {
        id: mainStackView
        anchors.fill: parent

        initialItem: App.Decoder {
            decoderService.onBegin: {
                mainStackView.push(processingPageComponent)
            }
        }
    }

    Component {
        id: processingPageComponent

        App.Processing {
            id: processing

            Connections {
                target: applicationWindow.decoder.decoderService
                function onError(message) {
                    processing.addError(message)
                }

                function onEncodedFileLoaded() {
                    processing.addMessage("Encoded file was successfully loaded")
                }

                function onStatisticFileLoaded() {
                    processing.addMessage("Statistics file was successfully loaded")
                }

                function onDecoded(key, plaintext) {
                    processing.addMessage("Decoding was successfully completed")
                }
            }
        }
    }
}