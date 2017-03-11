#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtWebView>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QtWebView::initialize();

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    return app.exec();
}
