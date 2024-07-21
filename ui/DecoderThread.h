//
// Copyright 2024 Nazarii Moroz
//

#ifndef DECODERTHREAD_H
#define DECODERTHREAD_H

#include <QThread>

namespace analyzer
{
    class Analyzer;
}

class DecoderThread : public QThread {
    Q_OBJECT

public:
    explicit DecoderThread(std::unique_ptr<analyzer::Analyzer> decoder, QObject* parent = nullptr);
    ~DecoderThread() override;

    void run() override;

signals:
    void statisticFileLoaded();
    void decoded(QString key, QString plaintext);
    void error(QString messaga);

protected:
    std::unique_ptr<analyzer::Analyzer> m_decoder;
};



#endif //DECODERTHREAD_H
