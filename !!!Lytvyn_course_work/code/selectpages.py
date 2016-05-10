# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'D:\Virusya\Kursova_2\windows\selectpages.ui'
#
# Created: Sun Dec 16 15:05:44 2012
#      by: PyQt4 UI code generator 4.9.5
#
# WARNING! All changes made in this file will be lost!

from PyQt4 import QtCore, QtGui

try:
    _fromUtf8 = QtCore.QString.fromUtf8
except AttributeError:
    _fromUtf8 = lambda s: s

class Ui_SelectPagesDialog(object):
    def setupUi(self, SelectPagesDialog):
        SelectPagesDialog.setObjectName(_fromUtf8("SelectPagesDialog"))
        SelectPagesDialog.resize(399, 154)
        self.OKButton = QtGui.QPushButton(SelectPagesDialog)
        self.OKButton.setGeometry(QtCore.QRect(60, 100, 93, 28))
        self.OKButton.setObjectName(_fromUtf8("OKButton"))
        self.CancelButton = QtGui.QPushButton(SelectPagesDialog)
        self.CancelButton.setGeometry(QtCore.QRect(200, 100, 93, 28))
        self.CancelButton.setObjectName(_fromUtf8("CancelButton"))
        self.label = QtGui.QLabel(SelectPagesDialog)
        self.label.setGeometry(QtCore.QRect(10, 10, 53, 16))
        self.label.setObjectName(_fromUtf8("label"))
        self.FromPageNumber = QtGui.QSpinBox(SelectPagesDialog)
        self.FromPageNumber.setGeometry(QtCore.QRect(60, 40, 91, 22))
        self.FromPageNumber.setMinimum(1)
        self.FromPageNumber.setMaximum(9999)
        self.FromPageNumber.setObjectName(_fromUtf8("FromPageNumber"))
        self.ToPageNumber = QtGui.QSpinBox(SelectPagesDialog)
        self.ToPageNumber.setGeometry(QtCore.QRect(210, 40, 91, 22))
        self.ToPageNumber.setMinimum(1)
        self.ToPageNumber.setMaximum(9999)
        self.ToPageNumber.setObjectName(_fromUtf8("ToPageNumber"))

        self.retranslateUi(SelectPagesDialog)
        QtCore.QObject.connect(self.CancelButton, QtCore.SIGNAL(_fromUtf8("clicked()")), SelectPagesDialog.close)
        QtCore.QObject.connect(self.OKButton, QtCore.SIGNAL(_fromUtf8("clicked()")), SelectPagesDialog.close)
        QtCore.QMetaObject.connectSlotsByName(SelectPagesDialog)

    def retranslateUi(self, SelectPagesDialog):
        SelectPagesDialog.setWindowTitle(QtGui.QApplication.translate("SelectPagesDialog", "Select Pages", None, QtGui.QApplication.UnicodeUTF8))
        self.OKButton.setText(QtGui.QApplication.translate("SelectPagesDialog", "OK", None, QtGui.QApplication.UnicodeUTF8))
        self.CancelButton.setText(QtGui.QApplication.translate("SelectPagesDialog", "Cancel", None, QtGui.QApplication.UnicodeUTF8))
        self.label.setText(QtGui.QApplication.translate("SelectPagesDialog", "Pages", None, QtGui.QApplication.UnicodeUTF8))

