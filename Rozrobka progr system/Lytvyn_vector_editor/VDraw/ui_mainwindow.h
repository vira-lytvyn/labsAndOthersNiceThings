/********************************************************************************
** Form generated from reading UI file 'mainwindow.ui'
**
** Created: Sat 12. Jan 23:22:19 2013
**      by: Qt User Interface Compiler version 4.7.4
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_MAINWINDOW_H
#define UI_MAINWINDOW_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QComboBox>
#include <QtGui/QDoubleSpinBox>
#include <QtGui/QFormLayout>
#include <QtGui/QGraphicsView>
#include <QtGui/QHBoxLayout>
#include <QtGui/QHeaderView>
#include <QtGui/QLabel>
#include <QtGui/QMainWindow>
#include <QtGui/QMenu>
#include <QtGui/QMenuBar>
#include <QtGui/QPushButton>
#include <QtGui/QToolBar>
#include <QtGui/QWidget>

QT_BEGIN_NAMESPACE

class Ui_MainWindow
{
public:
    QAction *actionOpen;
    QAction *actionSave;
    QAction *actionSave_As;
    QAction *actionExit;
    QAction *actionBegin;
    QWidget *centralWidget;
    QGraphicsView *graphicsView;
    QWidget *layoutWidget;
    QFormLayout *formLayout;
    QPushButton *lineButton;
    QPushButton *circleButton;
    QPushButton *ellipseButton;
    QPushButton *rectButton;
    QWidget *layoutWidget1;
    QFormLayout *formLayout_2;
    QPushButton *lineColorButton;
    QPushButton *zoomInButton;
    QPushButton *zoomOutButton;
    QHBoxLayout *horizontalLayout_2;
    QLabel *label_2;
    QDoubleSpinBox *penWidthSB;
    QHBoxLayout *horizontalLayout_3;
    QLabel *label;
    QComboBox *lineTypeList;
    QPushButton *clearButton;
    QPushButton *fillColorButton;
    QMenuBar *menuBar;
    QMenu *menuMenu;
    QMenu *menuTest;
    QToolBar *mainToolBar;

    void setupUi(QMainWindow *MainWindow)
    {
        if (MainWindow->objectName().isEmpty())
            MainWindow->setObjectName(QString::fromUtf8("MainWindow"));
        MainWindow->resize(838, 533);
        MainWindow->setMinimumSize(QSize(838, 533));
        MainWindow->setMaximumSize(QSize(838, 533));
        actionOpen = new QAction(MainWindow);
        actionOpen->setObjectName(QString::fromUtf8("actionOpen"));
        actionSave = new QAction(MainWindow);
        actionSave->setObjectName(QString::fromUtf8("actionSave"));
        actionSave_As = new QAction(MainWindow);
        actionSave_As->setObjectName(QString::fromUtf8("actionSave_As"));
        actionExit = new QAction(MainWindow);
        actionExit->setObjectName(QString::fromUtf8("actionExit"));
        actionBegin = new QAction(MainWindow);
        actionBegin->setObjectName(QString::fromUtf8("actionBegin"));
        centralWidget = new QWidget(MainWindow);
        centralWidget->setObjectName(QString::fromUtf8("centralWidget"));
        graphicsView = new QGraphicsView(centralWidget);
        graphicsView->setObjectName(QString::fromUtf8("graphicsView"));
        graphicsView->setGeometry(QRect(240, 0, 591, 491));
        graphicsView->setVerticalScrollBarPolicy(Qt::ScrollBarAsNeeded);
        graphicsView->setHorizontalScrollBarPolicy(Qt::ScrollBarAsNeeded);
        graphicsView->setSceneRect(QRectF(0, 0, 585, 400));
        graphicsView->setAlignment(Qt::AlignLeading|Qt::AlignLeft|Qt::AlignTop);
        layoutWidget = new QWidget(centralWidget);
        layoutWidget->setObjectName(QString::fromUtf8("layoutWidget"));
        layoutWidget->setGeometry(QRect(0, 10, 231, 123));
        formLayout = new QFormLayout(layoutWidget);
        formLayout->setSpacing(6);
        formLayout->setContentsMargins(11, 11, 11, 11);
        formLayout->setObjectName(QString::fromUtf8("formLayout"));
        formLayout->setFieldGrowthPolicy(QFormLayout::AllNonFixedFieldsGrow);
        formLayout->setContentsMargins(0, 0, 6, 6);
        lineButton = new QPushButton(layoutWidget);
        lineButton->setObjectName(QString::fromUtf8("lineButton"));
        lineButton->setCheckable(true);
        lineButton->setChecked(true);

        formLayout->setWidget(0, QFormLayout::FieldRole, lineButton);

        circleButton = new QPushButton(layoutWidget);
        circleButton->setObjectName(QString::fromUtf8("circleButton"));
        circleButton->setCheckable(true);

        formLayout->setWidget(3, QFormLayout::FieldRole, circleButton);

        ellipseButton = new QPushButton(layoutWidget);
        ellipseButton->setObjectName(QString::fromUtf8("ellipseButton"));
        ellipseButton->setCheckable(true);
        ellipseButton->setFlat(false);

        formLayout->setWidget(4, QFormLayout::FieldRole, ellipseButton);

        rectButton = new QPushButton(layoutWidget);
        rectButton->setObjectName(QString::fromUtf8("rectButton"));
        rectButton->setCheckable(true);

        formLayout->setWidget(2, QFormLayout::FieldRole, rectButton);

        layoutWidget1 = new QWidget(centralWidget);
        layoutWidget1->setObjectName(QString::fromUtf8("layoutWidget1"));
        layoutWidget1->setGeometry(QRect(0, 210, 229, 171));
        formLayout_2 = new QFormLayout(layoutWidget1);
        formLayout_2->setSpacing(6);
        formLayout_2->setContentsMargins(11, 11, 11, 11);
        formLayout_2->setObjectName(QString::fromUtf8("formLayout_2"));
        formLayout_2->setFieldGrowthPolicy(QFormLayout::AllNonFixedFieldsGrow);
        formLayout_2->setContentsMargins(0, 0, 0, 0);
        lineColorButton = new QPushButton(layoutWidget1);
        lineColorButton->setObjectName(QString::fromUtf8("lineColorButton"));
        lineColorButton->setAutoFillBackground(true);

        formLayout_2->setWidget(1, QFormLayout::FieldRole, lineColorButton);

        zoomInButton = new QPushButton(layoutWidget1);
        zoomInButton->setObjectName(QString::fromUtf8("zoomInButton"));

        formLayout_2->setWidget(2, QFormLayout::FieldRole, zoomInButton);

        zoomOutButton = new QPushButton(layoutWidget1);
        zoomOutButton->setObjectName(QString::fromUtf8("zoomOutButton"));

        formLayout_2->setWidget(3, QFormLayout::FieldRole, zoomOutButton);

        horizontalLayout_2 = new QHBoxLayout();
        horizontalLayout_2->setSpacing(6);
        horizontalLayout_2->setObjectName(QString::fromUtf8("horizontalLayout_2"));
        label_2 = new QLabel(layoutWidget1);
        label_2->setObjectName(QString::fromUtf8("label_2"));

        horizontalLayout_2->addWidget(label_2);

        penWidthSB = new QDoubleSpinBox(layoutWidget1);
        penWidthSB->setObjectName(QString::fromUtf8("penWidthSB"));
        penWidthSB->setMinimum(1);
        penWidthSB->setMaximum(100);

        horizontalLayout_2->addWidget(penWidthSB);


        formLayout_2->setLayout(4, QFormLayout::FieldRole, horizontalLayout_2);

        horizontalLayout_3 = new QHBoxLayout();
        horizontalLayout_3->setSpacing(6);
        horizontalLayout_3->setObjectName(QString::fromUtf8("horizontalLayout_3"));
        label = new QLabel(layoutWidget1);
        label->setObjectName(QString::fromUtf8("label"));

        horizontalLayout_3->addWidget(label);

        lineTypeList = new QComboBox(layoutWidget1);
        lineTypeList->setObjectName(QString::fromUtf8("lineTypeList"));

        horizontalLayout_3->addWidget(lineTypeList);

        clearButton = new QPushButton(layoutWidget1);
        clearButton->setObjectName(QString::fromUtf8("clearButton"));

        horizontalLayout_3->addWidget(clearButton);

        horizontalLayout_3->setStretch(1, 1);

        formLayout_2->setLayout(5, QFormLayout::FieldRole, horizontalLayout_3);

        fillColorButton = new QPushButton(layoutWidget1);
        fillColorButton->setObjectName(QString::fromUtf8("fillColorButton"));
        fillColorButton->setAutoFillBackground(true);

        formLayout_2->setWidget(0, QFormLayout::FieldRole, fillColorButton);

        MainWindow->setCentralWidget(centralWidget);
        layoutWidget->raise();
        layoutWidget->raise();
        graphicsView->raise();
        menuBar = new QMenuBar(MainWindow);
        menuBar->setObjectName(QString::fromUtf8("menuBar"));
        menuBar->setGeometry(QRect(0, 0, 838, 21));
        menuMenu = new QMenu(menuBar);
        menuMenu->setObjectName(QString::fromUtf8("menuMenu"));
        menuTest = new QMenu(menuBar);
        menuTest->setObjectName(QString::fromUtf8("menuTest"));
        MainWindow->setMenuBar(menuBar);
        mainToolBar = new QToolBar(MainWindow);
        mainToolBar->setObjectName(QString::fromUtf8("mainToolBar"));
        MainWindow->addToolBar(Qt::TopToolBarArea, mainToolBar);

        menuBar->addAction(menuMenu->menuAction());
        menuBar->addAction(menuTest->menuAction());
        menuMenu->addAction(actionOpen);
        menuMenu->addAction(actionSave);
        menuMenu->addAction(actionExit);
        menuTest->addAction(actionBegin);

        retranslateUi(MainWindow);
        QObject::connect(actionExit, SIGNAL(triggered()), MainWindow, SLOT(close()));

        QMetaObject::connectSlotsByName(MainWindow);
    } // setupUi

    void retranslateUi(QMainWindow *MainWindow)
    {
        MainWindow->setWindowTitle(QApplication::translate("MainWindow", "VDraw", 0, QApplication::UnicodeUTF8));
        actionOpen->setText(QApplication::translate("MainWindow", "Open", 0, QApplication::UnicodeUTF8));
        actionSave->setText(QApplication::translate("MainWindow", "Save", 0, QApplication::UnicodeUTF8));
        actionSave_As->setText(QApplication::translate("MainWindow", "Save As...", 0, QApplication::UnicodeUTF8));
        actionExit->setText(QApplication::translate("MainWindow", "Exit", 0, QApplication::UnicodeUTF8));
        actionBegin->setText(QApplication::translate("MainWindow", "Begin", 0, QApplication::UnicodeUTF8));
        lineButton->setText(QApplication::translate("MainWindow", "Line", 0, QApplication::UnicodeUTF8));
        circleButton->setText(QApplication::translate("MainWindow", "Circle", 0, QApplication::UnicodeUTF8));
        ellipseButton->setText(QApplication::translate("MainWindow", "Ellipse", 0, QApplication::UnicodeUTF8));
        rectButton->setText(QApplication::translate("MainWindow", "Rectangle", 0, QApplication::UnicodeUTF8));
        lineColorButton->setText(QApplication::translate("MainWindow", "Line color", 0, QApplication::UnicodeUTF8));
        zoomInButton->setText(QApplication::translate("MainWindow", "Zoom +", 0, QApplication::UnicodeUTF8));
        zoomOutButton->setText(QApplication::translate("MainWindow", "Zoom -", 0, QApplication::UnicodeUTF8));
        label_2->setText(QApplication::translate("MainWindow", "Line width", 0, QApplication::UnicodeUTF8));
        label->setText(QApplication::translate("MainWindow", "Line type", 0, QApplication::UnicodeUTF8));
        lineTypeList->clear();
        lineTypeList->insertItems(0, QStringList()
         << QApplication::translate("MainWindow", "Solid", 0, QApplication::UnicodeUTF8)
         << QApplication::translate("MainWindow", "Dash", 0, QApplication::UnicodeUTF8)
         << QApplication::translate("MainWindow", "Dot", 0, QApplication::UnicodeUTF8)
         << QApplication::translate("MainWindow", "Dash dot", 0, QApplication::UnicodeUTF8)
         << QApplication::translate("MainWindow", "Dash dot dot", 0, QApplication::UnicodeUTF8)
        );
        clearButton->setText(QApplication::translate("MainWindow", "Clear field", 0, QApplication::UnicodeUTF8));
        fillColorButton->setText(QApplication::translate("MainWindow", "Fill color", 0, QApplication::UnicodeUTF8));
        menuMenu->setTitle(QApplication::translate("MainWindow", "Menu", 0, QApplication::UnicodeUTF8));
        menuTest->setTitle(QApplication::translate("MainWindow", "Test", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class MainWindow: public Ui_MainWindow {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_MAINWINDOW_H
