Python 2.7 (r27:82525, Jul  4 2010, 09:01:59) [MSC v.1500 32 bit (Intel)] on win32
Type "copyright", "credits" or "license()" for more information.
>>> 
#!/usr/bin/python
# -*- coding: utf-8 -*-  
import sys
from PyQt4 import QtCore, QtGui

# ����� MyTableWidget - ��������� QTableWidget
class MyTableWidget(QtGui.QTableWidget):
    def __init__(self,*args):
        # *args - �������� ������������ ���������� ���������� � �����������
        QtGui.QTableWidget.__init__(self,*args)

if __name__ == "__main__":
    app = QtGui.QApplication(sys.argv)

    # ���������� �����/�������� � �������
    n=5; m=3
    # ������� ������� n �����, m ��������
    mytable = MyTableWidget(n,m)

    # ������� ���� ����������
    lst = ["First","Second","Third","Fourth","Fifth"]

    # ����������� list-����� � QStringList()-Qt
    lst = QtCore.QStringList(lst)

    # ������������� ��������������/������������ ���������
    mytable.setHorizontalHeaderLabels(lst)
    mytable.setVerticalHeaderLabels  (lst)

    # ��������� ������� ����������( ������.������� )
    for i in range(n):
        for j in range(m):
            tablewidgetitem = QtGui.QTableWidgetItem(QtCore.QString("%1,%2").arg(i+1).arg(j+1))
            mytable.setItem(i, j, tablewidgetitem)

    mytable.resize(360,200)
    mytable.show()
    sys.exit(app.exec_())
