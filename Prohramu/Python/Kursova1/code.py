# code.py
# Virusya Lytvyn
# -*- coding: utf-8 -*-
import sys
import gdata.spreadsheet.service
import gdata.service
import atom.service
import gdata.spreadsheet
import atom
import gdata
from PyQt4 import QtCore, QtGui
from form import Ui_MainWindow

class GoogleSpreadSheet(QtGui.QMainWindow):
    def __init__(self, parent=None):
        QtGui.QWidget.__init__(self, parent)
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)
        self.connect(self.ui.sendButton, QtCore.SIGNAL("clicked()"), self.readDataFromForm)

    def readDataFromForm(self):
        #print "button %s was pressed" % self.sender()
        firstName = unicode(self.ui.firstnameLineEdit.text())
        secondName = unicode(self.ui.secondnameLineEdit.text())
        lastName = unicode(self.ui.lastnameLineEdit.text())
        birthday = unicode(self.ui.CBday.itemText(self.ui.CBday.currentIndex()))
        month = unicode(self.ui.CBmounce.itemText(self.ui.CBmounce.currentIndex()))
        year = unicode(self.ui.CByear.itemText(self.ui.CByear.currentIndex()))
        malefemale = unicode(self.ui.CBmale.itemText(self.ui.CBmale.currentIndex()))
        married = unicode(self.ui.CBmerr.itemText(self.ui.CBmerr.currentIndex()))
        religious = unicode(self.ui.CBChist.itemText(self.ui.CBChist.currentIndex()))
##        firstName = unicode(firstName)
##        secondName = unicode(secondName)
##        lastName = unicode(lastName)
##        birthday = unicode(birthday)
##        month = unicode(month)
##        year = unicode(year)
##        malefemale = unicode(malefemale)
##        married = unicode(married)
##        religious = unicode(religious)
        
##        print month
##        print birthday
##        print married
##        print religious

        gd_client = gdata.spreadsheet.service.SpreadsheetsService()
        gd_client.email = 'baterfluy@gmail.com'
        gd_client.password = '369741369'
        gd_client.ProgrammaticLogin()
        spreadsheet_feed = gd_client.GetSpreadsheetsFeed()
        for spreadsheet in spreadsheet_feed.entry:
            print spreadsheet.id.text.rsplit('/', 1)[1]
            spreadsheet_key = spreadsheet.id.text.rsplit('/', 1)[1]
            feed = gd_client.GetWorksheetsFeed(spreadsheet_key)
            for worksheet in feed.entry:
                worksheet_key = worksheet.id.text.rsplit('/', 1)[1]
                print worksheet_key
        gd_client = gdata.spreadsheet.service.SpreadsheetsService(spreadsheet_key, worksheet_key)
        gd_client.email = 'baterfluy@gmail.com'
        gd_client.password = '369741369'
        gd_client.ProgrammaticLogin()
        dict = {'firstname':firstName, 'secondname':secondName, 'lastname':lastName,
                'birthdayday':birthday, 'birthdaymonth':month, 'age':year,
                'malefemale':malefemale, 'marriage':married, 'religion':religious}
        #dict = {'month':month}
        #gd_client.InsertRow(dict, spreadsheet_key, worksheet_key)
        entry = gd_client.InsertRow(dict, spreadsheet_key, worksheet_key)
        if isinstance(entry, gdata.spreadsheet.SpreadsheetsList):
            print "Insert row is success."
        
        
#Run the program
if __name__ == "__main__":
    app = QtGui.QApplication(sys.argv)
    myapp = GoogleSpreadSheet()
    myapp.show()
    sys.exit(app.exec_())
        
