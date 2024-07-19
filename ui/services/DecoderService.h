//
// Copyright 2024 Nazarii Moroz
//

#ifndef DECODERSERVICE_H
#define DECODERSERVICE_H

#include <QObject>
#include <QtQuick>


class DecoderService : public QObject {
    Q_OBJECT
    QML_ELEMENT

public:
    explicit DecoderService(QObject* parent = nullptr);

    Q_INVOKABLE void decode();

signals:
    void onDecoded(QString key, QString plaintext);
    void onError(QString messaga);

};



#endif //DECODERSERVICE_H
