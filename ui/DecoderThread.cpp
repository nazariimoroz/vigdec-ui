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
    try
    {
        m_decoder->load_statistic_file("english_bigrams.txt",
                                        "english_trigrams.txt",
                                        "english_quadgrams.txt");

        emit statisticFileLoaded();

        m_decoder->proccess();

        std::vector < char > resultKey = m_decoder->get_key();
        std::vector < char > resultPlain = m_decoder->get_plain_text();

        if (resultKey.size() > 0) {
            if (resultKey.size() == 2) {
                if (resultKey[0] == resultKey[1]) {
                    resultKey.pop_back();
                }
            }

            emit decoded(QString(QByteArray(resultKey.data(), resultKey.size())),
                QString(QByteArray(resultPlain.data(), resultPlain.size())));
            return;

        } else {
            emit error("Key not found. It was too hard 4 me, mb try bigger heap size :)");
            return;
        }

        emit error("Unknown error");
        return;
    } catch (const std::runtime_error& ex)
    {
        emit error(ex.what());
    }
}
