import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Pane {
    anchors.fill: parent

    ColumnLayout {
        anchors.fill: parent

        Column {
            Layout.fillWidth: true
            Layout.fillHeight: true

            ScrollView {
                id: view
                width: parent.width
                height: parent.height * 0.6
                contentHeight: encodedText.height

                TextArea {
                    id: encodedText
                    textFormat: Text.MarkdownText
                    font.pointSize: 15
                    text: ""

                    Text {
                        anchors.fill: parent
                        anchors.leftMargin: parent.leftPadding
                        anchors.rightMargin: parent.rightPadding
                        anchors.topMargin: parent.topPadding
                        anchors.bottomMargin: parent.bottomPadding

                        text: "Enter encoded text here..."

                        color: Qt.darker(parent.color)
                        font.pointSize: parent.font.pointSize
                        textFormat: parent.textFormat
                        visible: !parent.text
                    }
                }
            }
        }

        Button {
            Layout.fillWidth: true
            Layout.maximumHeight: 80
            Layout.minimumHeight: 40
            text: "DECODE"
            font.pointSize: 18
        }
    }
}
