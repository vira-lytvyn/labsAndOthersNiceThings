#ifndef SVGDRAWER_H
#define SVGDRAWER_H

#include <QGraphicsView>
#include <QGraphicsScene>
#include <QGraphicsItem>
#include <QtEvents>
#include <QPoint>
#include <QtSvg/QGraphicsSvgItem>

enum Shape {
    Line,
    BrokenLine,
    Rectangle,
    Square,
    Circle,
    Ellipse
};

class QGraphicsSceneMoveEvent;
class SVGDrawer
{
public:
    SVGDrawer();
    SVGDrawer(QGraphicsScene *pScene);
    void setGraphicsScene(QGraphicsScene *pScene);
    void setGraphicsView(QGraphicsView *pView);
    void drawEvent(QGraphicsSceneMoveEvent *event);
    void mousePressEvent(QMouseEvent *event);
    void mouseReleaseEvent(QGraphicsSceneMouseEvent *event);
    void mouseDoubleCliclEvent();
    void setShape(Shape pShape);
    void setPen(QPen pen);
    void setBrush(QBrush brush);
    void setLineColor(QColor pColor);
    void setFillColor(QColor pColor);
    void setScale(qreal pScale);
    void setLineWidth(int pWidth);

private:
    void setPointForShape(QPoint pEventPoint, QPoint &pPoint, int &pWidth, int &pHeight);

private:
    bool mMousePressed;
    int mPenWidth;

    QGraphicsScene *mScene;

    QGraphicsLineItem *mLine;
    QGraphicsRectItem *mRect;
    QGraphicsEllipseItem *mEllipse;
    QGraphicsPolygonItem *mPolygon;
    QGraphicsSvgItem *mItem;
    QGraphicsView *mGraphicsView;

    QBrush mCurrentBrush;
    QPen mCurrentPen;
    QColor mCurrentPenColor;

    QPointF mMousePressedPoint;
    QPointF mLastMousePoint;
    Shape mCurrentShape;

};

#endif // SVGDRAWER_H
