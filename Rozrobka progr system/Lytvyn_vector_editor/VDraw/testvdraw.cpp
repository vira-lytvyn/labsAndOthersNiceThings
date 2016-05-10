#include "testvdraw.h"
#include "ui_testvdraw.h"
#include <QMouseEvent>

TestVDraw::TestVDraw(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::TestVDraw)
{
    ui->setupUi(this);

    connect(ui->lineTestButton, SIGNAL(clicked()), this, SLOT(lineTest()));
    connect(ui->circleTestButton, SIGNAL(clicked()), this, SLOT(circleTest()));
    connect(ui->rectangleTestButton, SIGNAL(clicked()), this, SLOT(rectangleTest()));
    connect(ui->ellipsesTestButto, SIGNAL(clicked()), this, SLOT(ellipseTest()));
}

void TestVDraw::setGraphicsScene(QGraphicsScene *pScene)
{
    mScene = pScene;
}

void TestVDraw::lineTest()
{
    mScene->clear();
    QPen lPen(Qt::black);
    lPen.setWidth(ui->lineWidth->value());

    int lCount = 0;
    int lLineIndex = 0;
    while (lCount < ui->linesCoun->value()) {
        if (lLineIndex < 830) {
            lLineIndex++;
        } else {
            lLineIndex--;
        }

        mScene->addLine(lLineIndex, 0, lLineIndex, 430, lPen);
        lCount++;
    }

}

void TestVDraw::rectangleTest()
{
    mScene->clear();
    QPen lPen(Qt::black);
    lPen.setWidth(ui->lineWidth->value());

    int lCount = 0;
    int lRectIndex = 0;
    while (lCount < ui->rectanglesCount->value()) {
        if (lRectIndex < 830) {
            lRectIndex++;
        } else {
            lRectIndex--;
        }

        mScene->addRect(lRectIndex, 0, 10, 430, lPen, QBrush(Qt::transparent));
        lCount++;
    }
}

void TestVDraw::circleTest()
{
    mScene->clear();
    QPen lPen(Qt::black);
    lPen.setWidth(ui->lineWidth->value());

    int lCount = 0;
    int lCircleIndex = 0;
    while (lCount < ui->circleCount->value()) {
        if (lCircleIndex < 830) {
            lCircleIndex++;
        } else {
            lCircleIndex--;
        }

        mScene->addEllipse(lCircleIndex, 0, 430, 430, lPen, QBrush(Qt::transparent));

        lCount++;
    }
}

void TestVDraw::ellipseTest()
{
    mScene->clear();
    QPen lPen(Qt::black);
    lPen.setWidth(ui->lineWidth->value());

    int lCount = 0;
    int lEllipseIndex = 0;
    while (lCount < ui->ellipsesCount->value()) {
        if (lEllipseIndex < 830) {
            lEllipseIndex++;
        } else {
            lEllipseIndex--;
        }
        mScene->addEllipse(lEllipseIndex, 0, 50, 430, lPen, QBrush(Qt::transparent));
        lCount++;
    }
}

TestVDraw::~TestVDraw()
{
    delete ui;
}
