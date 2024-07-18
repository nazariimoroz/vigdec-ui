import QtQuick.Controls
import "." as App

ApplicationWindow {
    id: applicationWindow
    height: 400
    width: 400
    title: "Vigenère decoder"
    visible: true

    StackView {
        id: mainStackView
        anchors.fill: parent

        initialItem: App.Decoder {

        }
    }
}