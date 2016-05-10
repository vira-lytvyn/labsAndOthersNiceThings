# -*- coding: cp1251 -*-
# test1.py
# Virusya Lytvyn
# -*- coding: utf-8 -*-

import sys
import os
import re
import analiser

##import subprocess

from PyQt4.QtGui import *
from PyQt4.QtCore import *
from PyQt4 import QtCore, QtGui
from mainwindow import Ui_ElectronicLibrarian
from AddKeywordWindow import Ui_AddKeywordWindow
from selectpages import Ui_SelectPagesDialog

class MainAction(QtGui.QMainWindow):
    def __init__(self, parent=None):
        QtGui.QWidget.__init__(self, parent)
        self.ui = Ui_ElectronicLibrarian()
        self.ui.setupUi(self)
        self.connect(self.ui.AddKeyword, QtCore.SIGNAL("clicked()"), self.AddKeywordWindow)
        self.connect(self.ui.AddBooksSourse_button, QtCore.SIGNAL("clicked()"), self.AddNewBookToList)
        self.connect(self.ui.RemoveBooksSourse_button, QtCore.SIGNAL("clicked()"), self.RemoveBooksFromList)
        self.connect(self.ui.Investigate_Btn, QtCore.SIGNAL("clicked()"), self.InvestigateBook)
        self.connect(self.ui.RemoveKeyword_button, QtCore.SIGNAL("clicked()"), self.RemoveKeywordFromList)
        self.connect(self.ui.FindKeywordInDatabase_Btn, QtCore.SIGNAL("clicked()"), self.FindKeywordInDatabase)
        self.connect(self.ui.ShowResults_Btn, QtCore.SIGNAL("clicked()"), self.ShowResults)
        self.connect(self.ui.BookList, QtCore.SIGNAL("cellClicked(int, int)"), self.bookSelected)
        self.connect(self.ui.KeywordList, QtCore.SIGNAL("cellClicked(int, int)"), self.keywordSelected)

        cur.execute("select * from book_list")
        for row in cur:
            tempStr = re.split('\/', row[1])
            bookName = tempStr[len(tempStr) - 1]
            print bookName
            
            self.ui.BookList.insertRow(0)
            tableItemBookName = QTableWidgetItem(bookName)
            tableItemName = QTableWidgetItem(row[1])
            tableItemStatus = QTableWidgetItem(row[2])
            self.ui.BookList.setItem(0, 0, tableItemBookName)
            self.ui.BookList.setItem(0, 1, tableItemName)
            self.ui.BookList.setItem(0, 2, tableItemStatus)
            books.append(bookName)
            

        cur.execute("select * from keyword_list")
        for row in cur:
            self.ui.KeywordList.insertRow(0)
            keywordtableItemName = QTableWidgetItem(row[1])
            self.ui.KeywordList.setItem(0, 0, keywordtableItemName)
            keywords.append(row)

    def bookSelected(self, row, column):
        global selectedBook
        selectedBook = row
        print books[len(books) - selectedBook - 1]

    def keywordSelected(self, row, column):
        selectedKeyword[0] = row
        print row
        
    def AddKeywordWindow(self):
        dialog = QtGui.QDialog()
        dialog.ui = Ui_AddKeywordWindow()
        dialog.ui.setupUi(dialog)

        dialog.exec_()
        keywd = dialog.ui.NewKeywordEdit.text()

        if (keywd != ""):
            self.ui.KeywordList.insertRow(0)
            keywordtableItemName = QTableWidgetItem(keywd)
            keywords.append(keywd)
            self.ui.KeywordList.setItem(0, 0, keywordtableItemName)
            query = "insert into keyword_list(keyword) values (" + "'" + str(keywd).lower() + "')"
            cur.execute(query)
            con.commit()   
        
    def AddNewBookToList(self):
        filename = QtGui.QFileDialog.getOpenFileName(self, 'Open File', '.pdf')

        if (filename != ""):
            tempStr = re.split('\/', filename)
            bookName = tempStr[len(tempStr) - 1]
            print bookName
            
            self.ui.BookList.insertRow(0)

            tableItemName = QTableWidgetItem(filename)
            tableItemStatus = QTableWidgetItem("Not scanned")
            tableItemBookName = QTableWidgetItem(bookName)
            self.ui.BookList.setItem(0, 0, tableItemBookName)
            self.ui.BookList.setItem(0, 1, tableItemName)
            self.ui.BookList.setItem(0, 2, tableItemStatus)

            query = "insert into book_list(name, status) values (" + "'" + str(filename) + "'" + ',' + "'Not scanned')"
            cur.execute(query)
            con.commit()
            print "AddNewBookToList worked"

    def RemoveBooksFromList(self):
        print "RemoveBooksFromList worked"
        self.ui.BookList.removeRow(0)

    def InvestigateBook(self):
        print "InvestigateBook worked"
        dialog = QtGui.QDialog()
        dialog.ui = Ui_SelectPagesDialog()
        dialog.ui.setupUi(dialog)
        dialog.exec_()

        fromPage =  dialog.ui.FromPageNumber.text()
        toPage = dialog.ui.ToPageNumber.text()

        if (int(fromPage) > int(toPage)):
            temp = toPage
            toPage = fromPage
            fromPage = temp

        fileName ="Neuburg Matt - Programming iOS 4 - 2011.pdf"   
        result = analiser.getKeywordfFromBookWithRange(fileName, 814, 816)
        fileName = fileName.replace(" ", "").replace("-", "").replace(".", "");
        print fileName
        
        cur.execute("create table " + fileName + " (id INTEGER PRIMARY KEY, keyword TEXT, pages TEXT)")
        con.commit()

        for page in result:
            for item in page:
                parsed = re.split(',', item)
                if (len(parsed) > 1):
                    pagesNum = parsed[1]
                    lenght = len(parsed)
                    i = 2
                    while (i < lenght):
                        pagesNum = pagesNum + ", " + parsed[i]
                        i = i + 1
                    cur.execute("insert into " + fileName + " (keyword, pages) values('" + str(parsed[0]).lower() + "', '" + pagesNum + "')")
                    con.commit()
##                    print parsed

    def RemoveKeywordFromList(self):
        print "RemoveKeywordFromList worked"

    def FindKeywordInDatabase(self):
        print "FindKeywordInDatabase button worked"

        keywd = self.ui.KeywordList.item(selectedKeyword[0], 0).text()
        cur.execute("select * from NeuburgMattProgrammingiOS42011pdf where keyword = '" + str(keywd) +"'")
        
        self.ui.ResultList.clear()
        i = 0;
        for row in cur:
            
            kewd = QTableWidgetItem(row[1])
            book = QTableWidgetItem(books[selectedBook])
            pages = QTableWidgetItem(row[2])

            self.ui.ResultList.insertRow(0)
            self.ui.ResultList.setItem(i, 0, kewd)
            self.ui.ResultList.setItem(i, 1, book)
            self.ui.ResultList.setItem(i, 2, pages)
            i = i + 1
            print row

    def ShowResults(self):
        print "ShowResults button worked"

    def SetCurrentItemInKeyord(self):
        print "Position is seted"

    def AddPages(self):
        print "the pages added"

import sqlite3

##підєднуємо базу даних, або створюємо, якщо її ще нема
##selected book in BookList

con = sqlite3.connect("Library.db")
con.text_factory = str

cur = con.cursor()

con.commit()

selectedBook = 0
selectedKeyword = []
selectedKeyword.append(0)
books = []
keywords = []
if __name__ == "__main__":
    app = QtGui.QApplication(sys.argv)
    mainprogwind = MainAction()
    mainprogwind.show()
    sys.exit(app.exec_())

