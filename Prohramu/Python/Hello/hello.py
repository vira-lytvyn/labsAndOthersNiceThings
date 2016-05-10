#!c:\Python27\python.exe
#
# buttons.py
#

from PyQt4 import QtCore, QtGui
import sys

class MainWindow(QMainWindow):

    def __init__(self, *args):
        apply(QMainWindow.__init__, (self,) + args)
        self.setCaption("Buttons")
        
        self.grid=QGrid(2, self)
        self.grid.setFrameShape(QFrame.StyledPanel)

        self.bn1=QPushButton("Hello World", self.grid)
        self.bn1.setFlat(1)

        self.bn2=QPushButton("Hello World", self.grid)
        self.bn2.setDefault(1)
        
        self.bn3=QPushButton("Hello World", self.grid)
        self.bn3.setToggleButton(1)
        self.bn3.setDown(1)
        
        self.bn4=QPushButton("Hello", self.grid)
                           
        self.setCentralWidget(self.grid)
        
def main(args):
    app=QApplication(args)
    win=MainWindow()
    win.show()
    app.connect(app, SIGNAL("lastWindowClosed()")
                   , app
                   , SLOT("quit()")
                   )
    app.exec_loop()
  
if __name__=="__main__":
    main(sys.argv)
