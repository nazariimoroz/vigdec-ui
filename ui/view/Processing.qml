import QtCore
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Basic

Pane {
    id: rootPane

    ColumnLayout {
        anchors.fill: parent

        ScrollView {
            id: view
            contentHeight: encodedText.height

            Layout.fillHeight: true
            Layout.fillWidth: true

            TextArea {
                id: encodedText
                textFormat: Text.MarkdownText
                font.pointSize: 15

                selectByMouse: true
                readOnly: true
            }
        }

        Button {
            Layout.fillWidth: true
            Layout.maximumHeight: 80
            Layout.minimumHeight: 40
            text: "VIEW RESULT"
            font.pointSize: 18

            enabled: false
        }
    }
}

