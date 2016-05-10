#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QGraphicsScene>
#include "svgdrawer.h"

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT
    
public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

protected:
    bool eventFilter(QObject *object, QEvent *event);
    
private:
    Ui::MainWindow *ui;
    QGraphicsScene *mScene;
    SVGDrawer *mSvgDrawer;

private slots:
    void setLineType();
    void setBrokenLineType();
    void setRectType();
    void setCircleType();
    void setEllipseType();
    void zoomIn();
    void zoomOut();
    void setLineStyle(int index);
    void setLineWidth(double width);
    void setFillColor();
    void setLineColor();
    void saveToSVG();
    void openSVG();
    void clearField();
    void beginTest();
};

#endif // MAINWINDOW_H
