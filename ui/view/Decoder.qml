import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import VigdecUi

Pane {
    id: rootPane

    property string filePath: ""
    property bool filePathLoaded: false

    property alias decoderService: _decoderService

    function readFileContentIntoEncodedText() {
        let xhr = new XMLHttpRequest;
        let configaddress = "File:///" + filePath
        xhr.open("GET", configaddress);
        xhr.onreadystatechange = () => {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                encodedText.text = xhr.responseText
            }
        };
        xhr.overrideMimeType("text/plain; charset=x-user-defined");
        xhr.send();
    }

    ColumnLayout {
        anchors.fill: parent

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ScrollView {
                id: view
                contentHeight: encodedText.height

                Layout.fillHeight: true
                Layout.fillWidth: true

                TextArea {
                    id: encodedText
                    font.pointSize: 15

                    placeholderText: "Enter encoded text here..."

                    readOnly: rootPane.filePathLoaded
                }
            }

            RowLayout {
                Button {
                    text: "Load"
                    font.pointSize: 15

                    onClicked: fileDialog.open()
                }
                Button {
                    text: "Unload"
                    font.pointSize: 15

                    action: unloadAction
                }

                ScrollView {
                    Layout.fillWidth: true
                    Layout.preferredHeight: filePathLabel.height
                    contentWidth: filePathLabel.width

                    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                    ScrollBar.vertical.policy: ScrollBar.AlwaysOff

                    clip: true

                    TextArea {
                        id: filePathLabel
                        anchors.verticalCenter: parent.verticalCenter
                        padding: 0

                        font.pointSize: 15

                        selectByMouse: true
                        readOnly: true

                        text: rootPane.filePath

                        placeholderText: "File is not loaded"
                    }
                }
            }

            RowLayout {
                Label {
                    text: "Heap Size: "
                    font.pointSize: 15
                }
                TextField {
                    id: heapSizeTextField
                    Layout.fillWidth: true

                    text: "100"
                    font.pointSize: 15

                    validator: IntValidator {bottom: 1; top: 1000}
                }
            }
        }

        Button {
            Layout.fillWidth: true
            Layout.maximumHeight: 80
            Layout.minimumHeight: 40
            text: "DECODE"
            font.pointSize: 18

            onClicked: decoderService.decode()
        }
    }

    DecoderService {
        id: _decoderService

        filePath: rootPane.filePath
        filePathLoaded: rootPane.filePathLoaded
        encodedText: encodedText.text
        heapSize: heapSizeTextField.text
    }

    FileDialog {
        id: fileDialog
        currentFolder: StandardPaths.standardLocations(StandardPaths.DocumentsLocation)[0]
        acceptLabel: "Load"

        onAccepted: {
            let path = fileDialog.selectedFile.toString();
            path = path.replace(/^(file:\/{3})/,"");
            const cleanPath = decodeURIComponent(path);
            rootPane.filePath = cleanPath;
            rootPane.filePathLoaded = true

            rootPane.readFileContentIntoEncodedText()
        }
    }

    Action {
        id: unloadAction

        onTriggered: {
            rootPane.filePath = ""
            rootPane.filePathLoaded = false
        }
    }
}
