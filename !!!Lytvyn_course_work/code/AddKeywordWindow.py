# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'D:\Virusya\Kursova_2\windows\AddKeywordWindow.ui'
#
# Created: Sun Dec 16 14:47:05 2012
#      by: PyQt4 UI code generator 4.9.5
#
# WARNING! All changes made in this file will be lost!

from PyQt4 import QtCore, QtGui

try:
    _fromUtf8 = QtCore.QString.fromUtf8
except AttributeError:
    _fromUtf8 = lambda s: s

class Ui_AddKeywordWindow(object):
    def setupUi(self, AddKeywordWindow):
        AddKeywordWindow.setObjectName(_fromUtf8("AddKeywordWindow"))
        AddKeywordWindow.resize(334, 93)
        self.NewKeywordEdit = QtGui.QLineEdit(AddKeywordWindow)
        self.NewKeywordEdit.setGeometry(QtCore.QRect(10, 10, 311, 41))
        self.NewKeywordEdit.setText(_fromUtf8(""))
        self.NewKeywordEdit.setObjectName(_fromUtf8("NewKeywordEdit"))
        self.CleanButton = QtGui.QPushButton(AddKeywordWindow)
        self.CleanButton.setGeometry(QtCore.QRect(120, 60, 93, 28))
        self.CleanButton.setObjectName(_fromUtf8("CleanButton"))
        self.AddButton = QtGui.QPushButton(AddKeywordWindow)
        self.AddButton.setGeometry(QtCore.QRect(20, 60, 93, 28))
        self.AddButton.setObjectName(_fromUtf8("AddButton"))
        self.CancelButton = QtGui.QPushButton(AddKeywordWindow)
        self.CancelButton.setGeometry(QtCore.QRect(220, 60, 93, 28))
        self.CancelButton.setObjectName(_fromUtf8("CancelButton"))

        self.retranslateUi(AddKeywordWindow)
        QtCore.QObject.connect(self.CancelButton, QtCore.SIGNAL(_fromUtf8("clicked()")), AddKeywordWindow.close)
        QtCore.QObject.connect(self.CleanButton, QtCore.SIGNAL(_fromUtf8("clicked()")), self.NewKeywordEdit.clear)
        QtCore.QObject.connect(self.AddButton, QtCore.SIGNAL(_fromUtf8("clicked()")), AddKeywordWindow.close)
        QtCore.QObject.connect(self.CancelButton, QtCore.SIGNAL(_fromUtf8("clicked()")), self.NewKeywordEdit.clear)
        QtCore.QMetaObject.connectSlotsByName(AddKeywordWindow)

    def retranslateUi(self, AddKeywordWindow):
        AddKeywordWindow.setWindowTitle(QtGui.QApplication.translate("AddKeywordWindow", "Add Word", None, QtGui.QApplication.UnicodeUTF8))
        self.CleanButton.setText(QtGui.QApplication.translate("AddKeywordWindow", "Clean", None, QtGui.QApplication.UnicodeUTF8))
        self.AddButton.setText(QtGui.QApplication.translate("AddKeywordWindow", "Add", None, QtGui.QApplication.UnicodeUTF8))
        self.CancelButton.setText(QtGui.QApplication.translate("AddKeywordWindow", "Cancel", None, QtGui.QApplication.UnicodeUTF8))

