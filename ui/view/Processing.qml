import QtCore
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Basic

Pane {
    id: rootPane

    signal viewResults()

    required property QtObject decoderService
    property bool finished: false
    property string key
    property string plaintext

    function addMessage(message) {
        encodedText.text += message;
    }

    function addError(error) {
        encodedText.text += "<font color=\"#9c1111\">" + error + "</font>";
    }

    Connections {
        target: rootPane.decoderService

        function onError(message) {
            rootPane.addError(message)
        }

        function onEncodedFileLoaded() {
            rootPane.addMessage("Encoded file was successfully loaded")
        }

        function onStatisticFileLoaded() {
            rootPane.addMessage("Statistic files was successfully loaded")
        }

        function onDecoded(key, plaintext) {
            rootPane.addMessage("Decoding was successfully completed")
            rootPane.key = key
            rootPane.plaintext = plaintext
            rootPane.finished = true
        }
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

            onClicked: rootPane.viewResults()
        }
    }
}

