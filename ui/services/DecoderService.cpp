//
// Copyright 2024 Nazarii Moroz
//

#include "DecoderService.h"
#include "analyzer.h"
#include "DecoderThread.h"

DecoderService::DecoderService(QObject* parent)
    : QObject(parent)
{
}

void DecoderService::decode()
{
    auto decoder = std::make_unique<analyzer::Analyzer>(m_filePath.toStdString());
    decoder->HEAPSIZE = m_heapSize;

    auto decoderThread = new DecoderThread(std::move(decoder), this);

    connect(decoderThread, &DecoderThread::finished,
        decoderThread, &DecoderThread::deleteLater);

    connect(decoderThread, &DecoderThread::onStatisticFileLoaded,
        this, &DecoderService::onStatisticFileLoaded);
    connect(decoderThread, &DecoderThread::onDecoded,
        this, &DecoderService::onDecoded);
    connect(decoderThread, &DecoderThread::onError,
        this, &DecoderService::onError);
}
