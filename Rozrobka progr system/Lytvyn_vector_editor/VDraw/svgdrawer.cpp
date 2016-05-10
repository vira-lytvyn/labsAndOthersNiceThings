#include "svgdrawer.h"
#include <QtDebug>
#include <QColorDialog>
#include <math.h>
#include <QGraphicsSceneMoveEvent>

SVGDrawer::SVGDrawer()
{
    mScene = new QGraphicsScene;
    mMousePressed = false;
}

SVGDrawer::SVGDrawer(QGraphicsScene *pScene)
{
    mScene = pScene;
    mCurrentShape = Line;
    mMousePressed = false;
    mPenWidth = 1;
    mGraphicsView = new QGraphicsView();
}

////////////////////////////////////////////////////////////////
void SVGDrawer::setGraphicsScene(QGraphicsScene *pScene)
{
    mScene = pScene;
}

void SVGDrawer::setGraphicsView(QGraphicsView *pView)
{
    mGraphicsView = pView;
}

void SVGDrawer::setShape(Shape pShape)
{
    mCurrentShape = pShape;
}

void SVGDrawer::setPen(QPen pen)
{
    mCurrentPen = pen;
    mCurrentPen.setWidth(mPenWidth);
    mCurrentPen.setColor(mCurrentPenColor);
}

void SVGDrawer::setBrush(QBrush brush)
{
    mCurrentBrush = brush;
}

void SVGDrawer::setLineColor(QColor pColor)
{
    mCurrentPen.setColor(pColor);
    mCurrentPenColor = pColor;
}

void SVGDrawer::setFillColor(QColor pColor)
{
    mCurrentBrush.setColor(pColor);
    mCurrentBrush.setStyle(Qt::SolidPattern);
}

void SVGDrawer::setScale(qreal pScale)
{
}

void SVGDrawer::setLineWidth(int pWidth)
{
    mCurrentPen.setWidth(pWidth);
    mPenWidth = pWidth;
}

////////////////////////////////////////////////////////
void SVGDrawer::mousePressEvent(QMouseEvent *event)
{
    mMousePressed = true;
    mMousePressedPoint = mGraphicsView->mapToScene(event->pos());

    mLine = new QGraphicsLineItem;
    mLine->setPen(mCurrentPen);
    mRect = new QGraphicsRectItem;
    mRect->setBrush(mCurrentBrush);
    mRect->setPen(mCurrentPen);
    mEllipse = new QGraphicsEllipseItem;
    mEllipse->setBrush(mCurrentBrush);
    mEllipse->setPen(mCurrentPen);
}

void SVGDrawer::mouseReleaseEvent(QGraphicsSceneMouseEvent *event)
{
    if (mCurrentShape != BrokenLine) {
        mMousePressed = false;
    }
}

void SVGDrawer::mouseDoubleCliclEvent()
{
    mMousePressed = false;
}

void SVGDrawer::drawEvent(QGraphicsSceneMoveEvent *event)
{
    if (mScene) {
        if (mMousePressed) {
            qDebug() << "draw event";
            QPointF lRectPoint = mMousePressedPoint;
            QPointF lEventPoint = mGraphicsView->mapToScene(QPoint(event->newPos().x(), event->newPos().y()));
//            QGraphicsItem *lItem = mScene->itemAt(lEventPoint);
//            if (lItem != NULL) {
//                lItem->setPos(lEventPoint);
//            }
            int lWidth = 0;
            int lHeight = 0;
            if (mCurrentShape == Rectangle || mCurrentShape == Ellipse || mCurrentShape == Circle) {
                if (lEventPoint.x() > mMousePressedPoint.x()) {
                   lWidth = lEventPoint.x() - mMousePressedPoint.x();
                } else if (lEventPoint.x() < mMousePressedPoint.x()) {
                    lRectPoint.setX(lEventPoint.x());
                    lWidth = mMousePressedPoint.x() - lRectPoint.x();
                }

                if (lEventPoint.y() > mMousePressedPoint.y()) {
                    lHeight =lEventPoint.y() - mMousePressedPoint.y();
                } else if (lEventPoint.y() < mMousePressedPoint.y()) {
                    lRectPoint.setY(lEventPoint.y());
                    lHeight = mMousePressedPoint.y() - lEventPoint.y();
                }
            }

            switch (mCurrentShape) {
            case Line:
                mLine->setLine(mMousePressedPoint.x(),
                               mMousePressedPoint.y(),
                               lEventPoint.x(),
                               lEventPoint.y());
                mScene->addItem(mLine);
                qDebug() << lEventPoint;
                break;
            case BrokenLine:
                mLine->setLine(mMousePressedPoint.x(),
                               mMousePressedPoint.y(),
                               lEventPoint.x(),
                               lEventPoint.y());
                mScene->addItem(mLine);
                break;
            case Rectangle:
            {
                mRect->setRect(lRectPoint.x(),
                               lRectPoint.y(),
                               lWidth, lHeight);
                mScene->addItem(mRect);
                break;
            }
            case Square:
                break;
            case Circle:
            {
                int lDiametr = (lWidth + lHeight) / 2;
                mEllipse->setRect(lRectPoint.x(),
                                  lRectPoint.y(),
                                  lDiametr, lDiametr);
                mScene->addItem(mEllipse);
                break;
            }
            case Ellipse:
                mEllipse->setRect(lRectPoint.x(),
                               lRectPoint.y(),
                              lWidth, lHeight);
                mScene->addItem(mEllipse);
                break;
            }
        }
    }
}
