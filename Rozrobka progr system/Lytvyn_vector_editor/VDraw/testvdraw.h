#ifndef TESTVDRAW_H
#define TESTVDRAW_H

#include <QDialog>
#include "svgdrawer.h"
#include <QGraphicsScene>

namespace Ui {
class TestVDraw;
}

class TestVDraw : public QDialog
{
    Q_OBJECT
    
public:
    explicit TestVDraw(QWidget *parent = 0);
    ~TestVDraw();

    void setGraphicsScene(QGraphicsScene *pScene);

private slots:
    void lineTest();
    void rectangleTest();
    void circleTest();
    void ellipseTest();

private:
    Ui::TestVDraw *ui;
    QGraphicsScene *mScene;
};

#endif // TESTVDRAW_H
