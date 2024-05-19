import sys
import subprocess
from PyQt5.QtWidgets import QApplication, QWidget, QLabel, QVBoxLayout, QPushButton, QLineEdit, QMessageBox, QHBoxLayout
from PyQt5.QtGui import QPixmap, QFont
from PyQt5.QtCore import Qt

class AnimalGUI(QWidget):
    def __init__(self):
        super().__init__()
        self.initUI()
        self.initProlog()
        self.send_query('animal(A).')

    def initUI(self):
        self.setWindowTitle('Animal Identifier')
        self.layout = QVBoxLayout()

        self.setStyleSheet("""
            QWidget {
                background-color: #f0f0f0;
            }
            QLabel {
                font-size: 16px;
                color: #333;
            }
            QLineEdit {
                font-size: 14px;
                padding: 5px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            QPushButton {
                font-size: 14px;
                padding: 5px;
                color: white;
                border: none;
                border-radius: 5px;
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
                background-color: #007bff;
            }
            QPushButton#submitButton:hover {
                background-color: #0056b3;
            }
        """)

        self.question_label = QLabel("Answer the questions to identify the animal:")
        self.question_label.setAlignment(Qt.AlignCenter)
        self.question_label.setContentsMargins(0, 0, 0, 0)
        self.layout.addWidget(self.question_label)

        self.button_layout = QHBoxLayout()
        self.yes_button = QPushButton('Yes')
        self.yes_button.setObjectName('yesButton')
        self.yes_button.clicked.connect(lambda: self.handle_submit('yes'))
        self.button_layout.addWidget(self.yes_button)

        self.no_button = QPushButton('No')
        self.no_button.setObjectName('noButton')
        self.no_button.clicked.connect(lambda: self.handle_submit('no'))
        self.button_layout.addWidget(self.no_button)

        self.layout.addLayout(self.button_layout)

        self.result_label = QLabel("")
        self.result_label.setAlignment(Qt.AlignCenter)
        self.result_label.setFont(QFont('Arial', 14, QFont.Bold))
        self.layout.addWidget(self.result_label)

        self.image_label = QLabel("")
        self.image_label.setAlignment(Qt.AlignCenter)
        self.layout.addWidget(self.image_label)

        self.restart_button = QPushButton('Restart')
        self.restart_button.setObjectName('submitButton')
        self.restart_button.clicked.connect(self.restart)
        self.restart_button.hide()
        self.layout.addWidget(self.restart_button)

        self.setLayout(self.layout)
        self.resize(400, 400)

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
            print(f"Animal name: {animal_name}")
            self.display_animal_image(animal_name)
            self.result_label.setText(f"The animal you're thinking of is a {animal_name}.")
            self.restart_button.show()
        else:
            self.result_label.setText("I'm not sure what animal you're thinking of.")
            self.image_label.clear()
            self.restart_button.show()

    def read_output(self):
        output = []
        while True:
            line = self.prolog_process.stdout.readline()
            if line:
                print("Line: ", line)
                output.append(line)
                if line.strip().endswith('?'):
                    self.question_label.setText(''.join(output))
                    break
                elif '=' in line:
                    self.check_result(line)
                    break
                elif 'false.' in line:
                    self.result_label.setText("I'm not sure what animal you're thinking of.")
                    self.image_label.clear()
                    self.yes_button.hide()
                    self.no_button.hide()
                    self.question_label.hide()
                    self.restart_button.show()
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
        # hide the yes and no buttons
        self.yes_button.hide()
        self.no_button.hide()
        self.question_label.hide()
        pixmap = QPixmap(f"assets/{animal_name}.jpg")
        if pixmap.isNull():
            self.image_label.setText(f"No image found for {animal_name}")
        else:
            self.image_label.setPixmap(pixmap)
            self.image_label.setScaledContents(True)
            self.image_label.resize(200, 200)
        print("Displaying animal image")

    def restart(self):
        self.prolog_process.terminate()
        self.initProlog()
        self.send_query('animal(A).')

        # Reset the UI components
        self.result_label.setText("")
        self.image_label.clear()
        self.yes_button.show()
        self.no_button.show()
        self.question_label.show()
        self.restart_button.hide()
        self.resize(400, 400)
        print("Restart button clicked")

if __name__ == '__main__':
    app = QApplication(sys.argv)
    ex = AnimalGUI()
    ex.show()
    sys.exit(app.exec_())
