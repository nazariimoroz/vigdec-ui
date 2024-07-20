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

    Q_PROPERTY(QString  filePath        MEMBER m_filePath)
    Q_PROPERTY(bool     filePathLoaded  MEMBER m_filePathLoaded)
    Q_PROPERTY(QString  decodedText     MEMBER m_decodedText)
    Q_PROPERTY(int      heapSize        MEMBER m_heapSize)

public:
    explicit DecoderService(QObject* parent = nullptr);

    Q_INVOKABLE void decode();

signals:
    void onStatisticFileLoaded();
    void onDecoded(QString key, QString plaintext);
    void onError(QString messaga);

protected:
    QString m_filePath;
    bool m_filePathLoaded;
    QString m_decodedText;
    int m_heapSize;
};



#endif //DECODERSERVICE_H
