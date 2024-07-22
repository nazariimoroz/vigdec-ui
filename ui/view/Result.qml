import QtCore
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Pane {
    id: rootPane

    property string key
    property string plaintext

    ColumnLayout {
        anchors.fill: parent

        Label {
            font.pointSize: 13

            text: "Key: "
        }
        ScrollView {
            contentHeight: keyText.height
            Layout.preferredHeight: keyText.height
            Layout.fillWidth: true

            TextArea {
                id: keyText
                font.pointSize: 13
                padding: 0

                text: rootPane.key

                selectByMouse: true
                readOnly: true
            }
        }

        Label {
            font.pointSize: 13

            text: "Plaintext: "
        }
        ScrollView {
            contentHeight: plaintextText.height
            Layout.fillHeight: true
            Layout.fillWidth: true

            TextArea {
                id: plaintextText
                font.pointSize: 13
                padding: 0

                text: rootPane.plaintext

                selectByMouse: true
                readOnly: true

                wrapMode: TextEdit.WrapAnywhere
            }
        }

    }
}
