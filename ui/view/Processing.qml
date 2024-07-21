import QtCore
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Basic

Pane {
    id: rootPane

    property bool finished: false

    function addMessage(message) {
        encodedText.text += message;
    }

    function addError(error) {
        encodedText.text += "<font color=\"#9c1111\">" + error + "</font>";
    }

    ColumnLayout {
        anchors.fill: parent

        ScrollView {
            id: view
            contentHeight: encodedText.height

            Layout.fillHeight: true
            Layout.fillWidth: true

            TextArea {
                id: encodedText
                textFormat: Text.RichText
                font.pointSize: 13
                padding: 0

                text: "Decoding begins"

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

            enabled: rootPane.finished
        }
    }
}

