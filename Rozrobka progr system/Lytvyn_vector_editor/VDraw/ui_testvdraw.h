/********************************************************************************
** Form generated from reading UI file 'testvdraw.ui'
**
** Created by: Qt User Interface Compiler version 4.8.2
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_TESTVDRAW_H
#define UI_TESTVDRAW_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QDialog>
#include <QtGui/QFormLayout>
#include <QtGui/QHeaderView>
#include <QtGui/QLabel>
#include <QtGui/QPushButton>
#include <QtGui/QSpinBox>
#include <QtGui/QVBoxLayout>

QT_BEGIN_NAMESPACE

class Ui_TestVDraw
{
public:
    QFormLayout *formLayout;
    QVBoxLayout *verticalLayout;
    QPushButton *circleTestButton;
    QPushButton *lineTestButton;
    QPushButton *rectangleTestButton;
    QPushButton *ellipsesTestButto;
    QLabel *label;
    QVBoxLayout *verticalLayout_2;
    QSpinBox *circleCount;
    QSpinBox *linesCoun;
    QSpinBox *rectanglesCount;
    QSpinBox *ellipsesCount;
    QSpinBox *lineWidth;

    void setupUi(QDialog *TestVDraw)
    {
        if (TestVDraw->objectName().isEmpty())
            TestVDraw->setObjectName(QString::fromUtf8("TestVDraw"));
        TestVDraw->resize(226, 152);
        formLayout = new QFormLayout(TestVDraw);
        formLayout->setObjectName(QString::fromUtf8("formLayout"));
        formLayout->setFieldGrowthPolicy(QFormLayout::ExpandingFieldsGrow);
        verticalLayout = new QVBoxLayout();
        verticalLayout->setObjectName(QString::fromUtf8("verticalLayout"));
        circleTestButton = new QPushButton(TestVDraw);
        circleTestButton->setObjectName(QString::fromUtf8("circleTestButton"));

        verticalLayout->addWidget(circleTestButton);

        lineTestButton = new QPushButton(TestVDraw);
        lineTestButton->setObjectName(QString::fromUtf8("lineTestButton"));

        verticalLayout->addWidget(lineTestButton);

        rectangleTestButton = new QPushButton(TestVDraw);
        rectangleTestButton->setObjectName(QString::fromUtf8("rectangleTestButton"));

        verticalLayout->addWidget(rectangleTestButton);

        ellipsesTestButto = new QPushButton(TestVDraw);
        ellipsesTestButto->setObjectName(QString::fromUtf8("ellipsesTestButto"));

        verticalLayout->addWidget(ellipsesTestButto);

        label = new QLabel(TestVDraw);
        label->setObjectName(QString::fromUtf8("label"));

        verticalLayout->addWidget(label);


        formLayout->setLayout(0, QFormLayout::LabelRole, verticalLayout);

        verticalLayout_2 = new QVBoxLayout();
        verticalLayout_2->setObjectName(QString::fromUtf8("verticalLayout_2"));
        circleCount = new QSpinBox(TestVDraw);
        circleCount->setObjectName(QString::fromUtf8("circleCount"));
        circleCount->setMinimum(1);
        circleCount->setMaximum(999999999);

        verticalLayout_2->addWidget(circleCount);

        linesCoun = new QSpinBox(TestVDraw);
        linesCoun->setObjectName(QString::fromUtf8("linesCoun"));
        linesCoun->setMinimum(1);
        linesCoun->setMaximum(999999999);

        verticalLayout_2->addWidget(linesCoun);

        rectanglesCount = new QSpinBox(TestVDraw);
        rectanglesCount->setObjectName(QString::fromUtf8("rectanglesCount"));
        rectanglesCount->setMinimum(1);
        rectanglesCount->setMaximum(999999999);

        verticalLayout_2->addWidget(rectanglesCount);

        ellipsesCount = new QSpinBox(TestVDraw);
        ellipsesCount->setObjectName(QString::fromUtf8("ellipsesCount"));
        ellipsesCount->setMinimum(1);
        ellipsesCount->setMaximum(999999999);

        verticalLayout_2->addWidget(ellipsesCount);

        lineWidth = new QSpinBox(TestVDraw);
        lineWidth->setObjectName(QString::fromUtf8("lineWidth"));
        lineWidth->setMinimum(1);
        lineWidth->setMaximum(1000);

        verticalLayout_2->addWidget(lineWidth);


        formLayout->setLayout(0, QFormLayout::FieldRole, verticalLayout_2);


        retranslateUi(TestVDraw);

        QMetaObject::connectSlotsByName(TestVDraw);
    } // setupUi

    void retranslateUi(QDialog *TestVDraw)
    {
        TestVDraw->setWindowTitle(QApplication::translate("TestVDraw", "Dialog", 0, QApplication::UnicodeUTF8));
        circleTestButton->setText(QApplication::translate("TestVDraw", "Circles", 0, QApplication::UnicodeUTF8));
        lineTestButton->setText(QApplication::translate("TestVDraw", "Lines", 0, QApplication::UnicodeUTF8));
        rectangleTestButton->setText(QApplication::translate("TestVDraw", "Rectangles", 0, QApplication::UnicodeUTF8));
        ellipsesTestButto->setText(QApplication::translate("TestVDraw", "Ellipses", 0, QApplication::UnicodeUTF8));
        label->setText(QApplication::translate("TestVDraw", "LIne width", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class TestVDraw: public Ui_TestVDraw {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_TESTVDRAW_H
