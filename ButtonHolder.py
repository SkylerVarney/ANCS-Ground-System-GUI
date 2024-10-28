from PySide6.QtWidgets import QMainWindow, QLabel, QWidget, QGridLayout

class ButtonHolder(QMainWindow):
    def __init__(self):
        super().__init__()

        #main window
        self.setWindowTitle("this is the window name")
        centralWidget = QWidget(self)
        self.setCentralWidget(centralWidget)
        #layout of main window
        layout = QGridLayout(centralWidget)
        centralWidget.setLayout(layout)

        #euler angle

        #interal velocity 

        #internal acceleration

        #fin controls