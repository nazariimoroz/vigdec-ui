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
                color: Qt.rgba(0, 0, 0, 0)
                Layout.preferredWidth: backButton.width
                Layout.fillHeight: true
            }
        }
    }

    StackView {
        id: mainStackView
        anchors.fill: parent

        initialItem: decoderPageComponent
    }

    Component {
        id: decoderPageComponent

        App.Decoder {
            id: decoderRoot

            decoderService.onBegin: {
                StackView.view.push(processingPageComponent, {
                    "decoderService": decoderRoot.decoderService
                })
            }
        }
    }

    Component {
        id: processingPageComponent

        App.Processing {
            id: processingRoot

            onViewResults: {
                StackView.view.replace(resultPageComponent, {
                    "key": processingRoot.key,
                    "plaintext": processingRoot.plaintext
                })
            }
        }
    }

    Component {
        id: resultPageComponent

        App.Result {
            id: result
        }
    }
}