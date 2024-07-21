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

            Connections {
                target: applicationWindow.decoder.decoderService
                function onError(message) {
                    console.log("TEST")
                }
            }
        }
    }
}