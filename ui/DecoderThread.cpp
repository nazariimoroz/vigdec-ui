//
// Copyright 2024 Nazarii Moroz
//

#include "DecoderThread.h"
#include "analyzer.h"

DecoderThread::DecoderThread(std::unique_ptr<analyzer::Analyzer> decoder, QObject* parent)
    : QThread(parent),
      m_decoder(std::move(decoder))
{
}

DecoderThread::~DecoderThread()
{

}

void DecoderThread::run()
{
    m_decoder->load_statistic_file("english_bigrams.txt",
                                    "english_trigrams.txt",
                                    "english_quadgrams.txt");

    emit onStatisticFileLoaded();

    m_decoder->proccess();

    std::vector < char > resultKey = m_decoder->get_key();
    std::vector < char > resultPlain = m_decoder->get_plain_text();

    if (resultKey.size() > 0) {
        if (resultKey.size() == 2) {
            if (resultKey[0] == resultKey[1]) {
                resultKey.pop_back();
            }
        }

        emit onDecoded(QString(QByteArray(resultKey.data(), resultKey.size())),
            QString(QByteArray(resultPlain.data(), resultPlain.size())));

    } else {
        emit onError("Key not found. It was too hard 4 me, mb try bigger heap size :)");
    }

    emit onError("Unknown error");
}
