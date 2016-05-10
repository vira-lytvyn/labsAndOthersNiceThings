#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QtDebug>
#include <QtEvents>
#include <QColorDialog>
#include <QMessageBox>
#include <QtSvg/QSvgGenerator>
#include <QtSvg/QSvgRenderer>
#include <QtSvg/QGraphicsSvgItem>
#include <QGraphicsSceneMoveEvent>
#include <QFileDialog>
#include "testvdraw.h"

#define SCALE_FACTOR 1.15

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    ui->graphicsView->installEventFilter(this);

    mScene = new QGraphicsScene(this);
    mScene->setSceneRect(0, 0, ui->graphicsView->width(), ui->graphicsView->height());
    mScene->installEventFilter(this);

    mSvgDrawer = new SVGDrawer(mScene);
    ui->graphicsView->setScene(mScene);
    mSvgDrawer->setGraphicsView(ui->graphicsView);

    ui->lineColorButton->setPalette(QPalette(Qt::black));

    connect(ui->lineButton, SIGNAL(clicked(bool)), this, SLOT(setLineType()));
    connect(ui->rectButton, SIGNAL(clicked(bool)), this, SLOT(setRectType()));
    connect(ui->circleButton, SIGNAL(clicked(bool)), this, SLOT(setCircleType()));
    connect(ui->ellipseButton, SIGNAL(clicked(bool)), this, SLOT(setEllipseType()));
    connect(ui->zoomInButton, SIGNAL(clicked()), this, SLOT(zoomIn()));
    connect(ui->zoomOutButton, SIGNAL(clicked()), this, SLOT(zoomOut()));
    connect(ui->lineTypeList, SIGNAL(currentIndexChanged(int)), this, SLOT(setLineStyle(int)));
    connect(ui->penWidthSB, SIGNAL(valueChanged(double)), this, SLOT(setLineWidth(double)));
    connect(ui->lineColorButton, SIGNAL(clicked()), this, SLOT(setLineColor()));
    connect(ui->fillColorButton, SIGNAL(clicked()), this, SLOT(setFillColor()));
    connect(ui->actionSave, SIGNAL(triggered()), this, SLOT(saveToSVG()));
    connect(ui->actionOpen, SIGNAL(triggered()), this, SLOT(openSVG()));
    connect(ui->clearButton, SIGNAL(clicked()), this, SLOT(clearField()));
    connect(ui->actionBegin, SIGNAL(triggered()), this, SLOT(beginTest()));
}

bool MainWindow::eventFilter(QObject *object, QEvent *event)
{
    if (event->type() == QEvent::GraphicsSceneMouseMove) {
        QGraphicsSceneMoveEvent *lHoverEvetn = reinterpret_cast<QGraphicsSceneMoveEvent *>(event);
        qDebug() << lHoverEvetn->newPos();
        mSvgDrawer->drawEvent(lHoverEvetn);
    } else if (event->type() == QEvent::MouseButtonPress) {
        QMouseEvent *lMouseEvent = reinterpret_cast<QMouseEvent *>(event);
        qDebug() << lMouseEvent->pos();
        mSvgDrawer->mousePressEvent(lMouseEvent);
    } else if (event->type() == QEvent::GraphicsSceneMouseRelease) {
        qDebug() << event;
        QGraphicsSceneMouseEvent *lEvent = reinterpret_cast<QGraphicsSceneMouseEvent *>(event);
        mSvgDrawer->mouseReleaseEvent(lEvent);
    } else if (event->type() == QEvent::GraphicsSceneMouseDoubleClick) {
        mSvgDrawer->mouseDoubleCliclEvent();
    }

    qDebug() << event;
    return false;
}

void MainWindow::setLineType()
{
    ui->lineButton->setChecked(true);
    ui->rectButton->setChecked(false);
    ui->circleButton->setChecked(false);
    ui->ellipseButton->setChecked(false);

    mSvgDrawer->setShape(Line);
}

void MainWindow::setBrokenLineType()
{
    ui->lineButton->setChecked(false);
    ui->rectButton->setChecked(false);
    ui->circleButton->setChecked(false);
    ui->ellipseButton->setChecked(false);

    mSvgDrawer->setShape(BrokenLine);
}

void MainWindow::setRectType()
{
    ui->lineButton->setChecked(false);
    ui->rectButton->setChecked(true);
    ui->circleButton->setChecked(false);
    ui->ellipseButton->setChecked(false);

    mSvgDrawer->setShape(Rectangle);
}

void MainWindow::setCircleType()
{
    ui->lineButton->setChecked(false);
    ui->rectButton->setChecked(false);
    ui->circleButton->setChecked(true);
    ui->ellipseButton->setChecked(false);

    mSvgDrawer->setShape(Circle);
}

void MainWindow::setEllipseType()
{
    ui->lineButton->setChecked(false);
    ui->rectButton->setChecked(false);
    ui->circleButton->setChecked(false);
    ui->ellipseButton->setChecked(true);

    mSvgDrawer->setShape(Ellipse);
}

void MainWindow::zoomIn()
{
    mSvgDrawer->setScale(SCALE_FACTOR);
    ui->graphicsView->scale(SCALE_FACTOR, SCALE_FACTOR);
}

void MainWindow::zoomOut()
{
    mSvgDrawer->setScale(1 / SCALE_FACTOR);
    ui->graphicsView->scale(1/ SCALE_FACTOR, 1 / SCALE_FACTOR);
}

void MainWindow::setLineStyle(int index)
{
    switch (index) {
    case 0:
        mSvgDrawer->setPen(QPen(Qt::SolidLine));
        break;
    case 1:
        mSvgDrawer->setPen(QPen(Qt::DashLine));
        break;
    case 2:
        mSvgDrawer->setPen(QPen(Qt::DotLine));
        break;
    case 3:
        mSvgDrawer->setPen(QPen(Qt::DashDotLine));
        break;
    case 4:
        mSvgDrawer->setPen(QPen(Qt::DashDotDotLine));
        break;
    }
}

void MainWindow::setLineWidth(double width)
{
    mSvgDrawer->setLineWidth((int)width);
}

void MainWindow::setLineColor()
{
    QColor lColor = QColorDialog::getColor(Qt::black, this, "Text Color",  QColorDialog::DontUseNativeDialog);
    if(lColor.isValid())
    {
        mSvgDrawer->setLineColor(lColor);
        ui->lineColorButton->setPalette(QPalette(lColor));
    }
}

void MainWindow::setFillColor()
{    QColor lColor = QColorDialog::getColor(Qt::black, this, "Text Color",  QColorDialog::DontUseNativeDialog);
     if(lColor.isValid())
     {
         mSvgDrawer->setFillColor(lColor);
         ui->fillColorButton->setPalette(QPalette(lColor));
     }
}

void MainWindow::saveToSVG()
{
    QString fileName = QFileDialog::getSaveFileName(this,
         tr("Open Image"), "", tr("SVG (*.svg)"));

    qDebug() << "File name: " + fileName;
    if (fileName.length() > 0) {
        QSvgGenerator *generator = new QSvgGenerator();
        generator->setFileName(fileName + ".svg");
        generator->setSize(QSize(mScene->sceneRect().width(), mScene->sceneRect().height()));
    //    generator->setViewBox(QRect(0, 0, this->width(), this->height()));
        generator->setTitle(tr("SVG Generator Example Drawing"));
        generator->setDescription(tr("Generated svg by VDraw"));
        QPainter painter(generator);
        mScene->render(&painter);
    }
}

void MainWindow::openSVG()
{
    QFileDialog lFileDialog;
    lFileDialog.setConfirmOverwrite(false);
    QString fileName = lFileDialog.getOpenFileName(this,
         tr("Open Image"), "", tr("SVG (*.svg)"));
    qDebug() << "File name: " + fileName;
    if (fileName.length() > 0) {
        mScene->clear();
        QSvgRenderer *lSvgRender = new QSvgRenderer(fileName, this);
        QGraphicsSvgItem *lItem = new QGraphicsSvgItem();
        lItem->setSharedRenderer(lSvgRender);
        mScene->addItem(lItem);
    }
}

void MainWindow::clearField()
{
    mScene->clear();
}

void MainWindow::beginTest()
{
    TestVDraw *lTestDraw = new TestVDraw(this);
    lTestDraw->setGraphicsScene(mScene);
    lTestDraw->show();
}

MainWindow::~MainWindow()
{
    delete ui;
}
