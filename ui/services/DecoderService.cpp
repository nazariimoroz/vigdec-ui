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
    std::string filePath;
    if(m_filePathLoaded)
    {
        filePath = m_filePath.toStdString();
    }

    emit begin();
    std::unique_ptr<analyzer::Analyzer> decoder;
    try
    {
        decoder = std::make_unique<analyzer::Analyzer>(filePath);
    } catch (const std::exception& ex)
    {
        emit error(ex.what());
        return;
    }
    decoder->HEAPSIZE = m_heapSize;

    auto decoderThread = new DecoderThread(std::move(decoder), this);

    connect(decoderThread, &DecoderThread::finished,
        decoderThread, &DecoderThread::deleteLater);

    connect(decoderThread, &DecoderThread::statisticFileLoaded,
        this, &DecoderService::statisticFileLoaded);
    connect(decoderThread, &DecoderThread::decoded,
        this, &DecoderService::decoded);
    connect(decoderThread, &DecoderThread::error,
        this, &DecoderService::error);

    decoderThread->start();
}
