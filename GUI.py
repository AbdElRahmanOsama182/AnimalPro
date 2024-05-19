import sys
import subprocess
from PyQt5.QtWidgets import QApplication, QWidget, QLabel, QVBoxLayout, QPushButton, QHBoxLayout, QMessageBox
from PyQt5.QtGui import QPixmap, QFont, QIcon
from PyQt5.QtCore import Qt

class AnimalGUI(QWidget):
    def __init__(self):
        super().__init__()
        self.initUI()
        self.initProlog()
        self.send_query('animal(A).')

    def initUI(self):
        self.setWindowTitle('AnimalPro')
        self.setWindowIcon(QIcon('assets/mystery.jpg'))
        self.layout = QVBoxLayout()

        self.setStyleSheet("""
            QWidget {
                background-color: #018cc7;
            }
            QLabel {
                color: azure;
                padding: 0px;
                margin: 0px;
                font-family: Arial;
            }
            QLabel#questionLabel {
                font-size: 26px;
            }
            QLineEdit {
                font-size: 16px;
                padding: 5px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            QPushButton {
                font-size: 18px;
                font-weight: bold;
                font-family: Arial;
                padding: 10px;
                color: white;
                border: none;
                border-radius: 7px;
            }
            QPushButton#yesButton {
                background-color: #28a745;
            }
            QPushButton#yesButton:hover {
                background-color: #218838;
            }
            QPushButton#noButton {
                background-color: #dc3545;
            }
            QPushButton#noButton:hover {
                background-color: #c82333;
            }
            QPushButton#submitButton {
                background-color: #fd8d01;
            }
            QPushButton#submitButton:hover {
                background-color: #f76b00;
            }
        """)


        self.title = QLabel("Answer the questions to identify the animal:")
        self.title.setFixedHeight(50)
        self.title.setFont(QFont('Arial', 12, QFont.Bold))
        self.layout.addWidget(self.title)

        self.question_label = QLabel("")
        self.question_label.setObjectName('questionLabel')
        self.question_label.setFixedHeight(50)
        self.question_label.setAlignment(Qt.AlignCenter)
        self.question_label.setContentsMargins(0, 0, 0, 0)
        self.layout.addWidget(self.question_label)

        self.button_layout = QHBoxLayout()
        self.yes_button = QPushButton('Yes')
        self.yes_button.setCursor(Qt.PointingHandCursor)
        self.yes_button.setObjectName('yesButton')
        self.yes_button.setFixedWidth(160)
        self.yes_button.clicked.connect(lambda: self.handle_submit('yes'))
        self.button_layout.addWidget(self.yes_button)

        self.no_button = QPushButton('No')
        self.no_button.setCursor(Qt.PointingHandCursor)
        self.no_button.setObjectName('noButton')
        self.no_button.setFixedWidth(160)
        self.no_button.clicked.connect(lambda: self.handle_submit('no'))
        self.button_layout.addWidget(self.no_button)
        self.button_layout.setContentsMargins(0, 0, 0, 0)

        self.layout.addLayout(self.button_layout)

        self.result_label = QLabel("")
        self.result_label.setAlignment(Qt.AlignCenter)
        self.result_label.setFont(QFont('Arial', 14, QFont.Bold))
        self.result_label.setContentsMargins(15, 20, 15, 20)
        self.result_label.setFixedWidth(570)
        self.result_label.setFixedHeight(100)
        self.result_label.setWordWrap(True)
        self.result_label.hide()
        self.layout.addWidget(self.result_label)

        self.image_label = QLabel("")
        self.image_label.setAlignment(Qt.AlignCenter)
        self.image_label.setFixedHeight(60)
        self.layout.addWidget(self.image_label)

        self.restart_button = QPushButton('Restart')
        self.restart_button.setObjectName('submitButton')
        self.restart_button.setFixedWidth(200)
        self.restart_button.setFont(QFont('Arial', 14, QFont.Bold))
        self.restart_button.setCursor(Qt.PointingHandCursor)
        self.restart_button.clicked.connect(self.restart)
        self.restart_button.hide()
        # remove margin and padding
        self.restart_button.setContentsMargins(0, 0, 0, 0)
        self.layout.addWidget(self.restart_button, alignment=Qt.AlignCenter)
        self.layout.setAlignment(Qt.AlignCenter)
        self.layout.setContentsMargins(10, 10, 10, 10)
        # self.layout.addWidget(self.restart_button)

        self.setLayout(self.layout)
        self.resize(600, 600)

        # Display the mystery image initially
        self.display_mystery_image()

    def initProlog(self):
        self.prolog_process = subprocess.Popen(
            ['swipl', '-s', 'animals.pl'],
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )

    def send_query(self, query):
        self.prolog_process.stdin.write(query + '\n')
        self.prolog_process.stdin.flush()
        print(f"Sending query: {query}")
        self.read_output()

    def check_result(self, output):
        if '=' in output:
            # A = animal_name
            animal_name = output.split('=')[1].strip().strip('.')
            # remove single quotes if exist
            animal_name = animal_name.strip('\'')
            print(f"Animal name: {animal_name}")
            self.display_animal_image(animal_name)
            self.restart_button.show()
        else:
            self.result_label.setText("I'm not sure what animal you're thinking of.")
            self.result_label.show()
            self.restart_button.show()
            self.adjustSize()

    def read_output(self):
        output = []
        while True:
            line = self.prolog_process.stdout.readline()
            if line:
                print("Line: ", line)
                output.append(line)
                if line.strip().endswith('?'):
                    question = line.strip().capitalize()[:-1] + ' ?'
                    self.question_label.setText(question)
                    break
                elif '=' in line:
                    self.check_result(line)
                    break
                elif 'false.' in line:
                    self.result_label.setText("I'm not sure what animal you're thinking of.")
                    self.result_label.show()
                    self.yes_button.hide()
                    self.no_button.hide()
                    self.title.hide()
                    self.question_label.hide()
                    self.restart_button.show()
                    self.adjustSize()
                    break
            else:
                break

    def handle_submit(self, answer):
        if answer in ['yes', 'no']:
            self.send_query(answer + '.')
        else:
            QMessageBox.warning(self, "Invalid Input", "Please answer 'yes' or 'no'.")
        print("Submit button clicked")

    def display_animal_image(self, animal_name):
        # Hide the yes and no buttons
        self.yes_button.hide()
        self.no_button.hide()
        self.title.hide()
        self.question_label.hide()
        text = "The animal you're thinking of is "
        if animal_name[0].lower() in ['a', 'e', 'i', 'o', 'u']:
            text += "an "
        else:
            text += "a "
        text += animal_name.capitalize() + "."
        self.result_label.setText(text)
        self.result_label.show()
        pixmap = QPixmap(f"assets/{animal_name}.jpg")
        if pixmap.isNull():
            self.image_label.setText(f"No image found for {animal_name}")
        else:
            self.image_label.setPixmap(pixmap)
            self.image_label.setScaledContents(True)
            # self.image_label.resize(200, 200)
            self.image_label.setFixedHeight(600)
            self.image_label.setFixedWidth(600)
            self.image_label.setAlignment(Qt.AlignCenter)
        self.adjustSize()
        print("Displaying animal image")

    def display_mystery_image(self):
        # Display the mystery image initially
        pixmap = QPixmap("assets/mystery.jpg")
        if pixmap.isNull():
            self.image_label.setText("No mystery image found")
        else:
            self.image_label.setPixmap(pixmap)
            self.image_label.setScaledContents(True)
            # self.image_label.resize(200, 200)
            self.image_label.setFixedHeight(600)
            self.image_label.setFixedWidth(600)
            self.image_label.setAlignment(Qt.AlignCenter)
        print("Displaying mystery image")

    def restart(self):
        self.prolog_process.terminate()
        self.initProlog()
        self.send_query('animal(A).')

        # Reset the UI components
        self.result_label.setText("")
        self.image_label.clear()
        self.display_mystery_image()
        self.yes_button.show()
        self.no_button.show()
        self.title.show()
        self.question_label.show()
        self.restart_button.hide()
        self.result_label.hide()
        self.adjustSize()
        print("Restart button clicked")

if __name__ == '__main__':
    app = QApplication(sys.argv)
    ex = AnimalGUI()
    ex.show()
    sys.exit(app.exec_())
