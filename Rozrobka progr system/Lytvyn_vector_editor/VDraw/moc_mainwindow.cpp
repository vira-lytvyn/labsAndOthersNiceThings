/****************************************************************************
** Meta object code from reading C++ file 'mainwindow.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "mainwindow.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'mainwindow.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_MainWindow[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      15,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      12,   11,   11,   11, 0x08,
      26,   11,   11,   11, 0x08,
      46,   11,   11,   11, 0x08,
      60,   11,   11,   11, 0x08,
      76,   11,   11,   11, 0x08,
      93,   11,   11,   11, 0x08,
     102,   11,   11,   11, 0x08,
     118,  112,   11,   11, 0x08,
     142,  136,   11,   11, 0x08,
     163,   11,   11,   11, 0x08,
     178,   11,   11,   11, 0x08,
     193,   11,   11,   11, 0x08,
     205,   11,   11,   11, 0x08,
     215,   11,   11,   11, 0x08,
     228,   11,   11,   11, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_MainWindow[] = {
    "MainWindow\0\0setLineType()\0setBrokenLineType()\0"
    "setRectType()\0setCircleType()\0"
    "setEllipseType()\0zoomIn()\0zoomOut()\0"
    "index\0setLineStyle(int)\0width\0"
    "setLineWidth(double)\0setFillColor()\0"
    "setLineColor()\0saveToSVG()\0openSVG()\0"
    "clearField()\0beginTest()\0"
};

void MainWindow::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        MainWindow *_t = static_cast<MainWindow *>(_o);
        switch (_id) {
        case 0: _t->setLineType(); break;
        case 1: _t->setBrokenLineType(); break;
        case 2: _t->setRectType(); break;
        case 3: _t->setCircleType(); break;
        case 4: _t->setEllipseType(); break;
        case 5: _t->zoomIn(); break;
        case 6: _t->zoomOut(); break;
        case 7: _t->setLineStyle((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 8: _t->setLineWidth((*reinterpret_cast< double(*)>(_a[1]))); break;
        case 9: _t->setFillColor(); break;
        case 10: _t->setLineColor(); break;
        case 11: _t->saveToSVG(); break;
        case 12: _t->openSVG(); break;
        case 13: _t->clearField(); break;
        case 14: _t->beginTest(); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData MainWindow::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject MainWindow::staticMetaObject = {
    { &QMainWindow::staticMetaObject, qt_meta_stringdata_MainWindow,
      qt_meta_data_MainWindow, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &MainWindow::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *MainWindow::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *MainWindow::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_MainWindow))
        return static_cast<void*>(const_cast< MainWindow*>(this));
    return QMainWindow::qt_metacast(_clname);
}

int MainWindow::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QMainWindow::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 15)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 15;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
