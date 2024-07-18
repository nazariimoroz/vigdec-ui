//
// Copyright 2024 Nazarii Moroz
//

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>

int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);

    QQuickStyle::setStyle("Fusion");

    /*
    QDirIterator it(":", QDirIterator::Subdirectories);
    while (it.hasNext()) {
        qDebug() << it.next();
    }*/

    QQmlApplicationEngine engine;
    engine.setOutputWarningsToStandardError(true);
    const QUrl url(u"qrc:/VigdecUi/view/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
            &app, [url, &engine](QObject *obj, const QUrl &objUrl) {
                if (!obj && url == objUrl)
                {
                    const auto error = engine.catchError();
                    QDebug(QtFatalMsg) << error.toString();
                    QCoreApplication::exit(-1);
                }
            }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
