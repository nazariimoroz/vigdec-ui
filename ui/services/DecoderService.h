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
    Q_PROPERTY(QString  encodedText     MEMBER m_encodedText)
    Q_PROPERTY(int      heapSize        MEMBER m_heapSize)

public:
    explicit DecoderService(QObject* parent = nullptr);

    Q_INVOKABLE void decode();

signals:
    void begin();
    void encodedFileLoaded();
    void statisticFileLoaded();
    void decoded(QString key, QString plaintext);
    void error(QString messaga);

protected:
    QString m_filePath;
    bool m_filePathLoaded;
    QString m_encodedText;
    int m_heapSize;
};



#endif //DECODERSERVICE_H
