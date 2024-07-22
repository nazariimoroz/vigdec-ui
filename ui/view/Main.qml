import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "." as App

ApplicationWindow {
    id: applicationWindow
    height: 500
    width: 700
    title: "Vigenère decoder"
    visible: true

    header: ToolBar {
        RowLayout {
            anchors.fill: parent

            ToolButton {
                id: backButton
                text: enabled ? "‹" : " "

                enabled: mainStackView.depth > 1 && !mainStackView.currentItem.forbidBack

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