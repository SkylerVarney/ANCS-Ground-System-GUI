from PySide6.QtWidgets import QMainWindow, QLabel, QWidget, QGridLayout, QPushButton
from PySide6.QtCore import Qt

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
        euler_angle = QWidget(centralWidget)
        layout.addWidget(euler_angle, 0, 1, Qt.AlignRight)
        euler_angle.setStyleSheet("background-color: gray;")
        euler_angle.setFixedSize(200, 100)

        euler_layout = QGridLayout(euler_angle)
        euler_angle.setLayout(euler_layout)

        euler_title = QLabel(euler_angle)
        euler_title.setText("Euler Angles")
        euler_layout.addWidget(euler_title, 0, 0, 1, 0, Qt.AlignCenter)

        Yaw_deg = 0.0
        Pitch_deg = 0.0
        Roll_deg = 0.0

        Yaw = QLabel(euler_angle)
        euler_layout.addWidget(Yaw, 1, 0, Qt.AlignCenter)
        Yaw.setText("Yaw, deg")

        Pitch = QLabel(euler_angle)
        euler_layout.addWidget(Pitch, 2, 0, Qt.AlignCenter)
        Pitch.setText("Pitch, deg")

        Roll = QLabel(euler_angle)
        euler_layout.addWidget(Roll, 3, 0, Qt.AlignCenter)
        Roll.setText("Roll, deg")

        Yaw_label = QLabel(euler_angle)
        euler_layout.addWidget (Yaw_label, 1, 1, Qt.AlignCenter)
        Yaw_label.setText(str(Yaw_deg))

        Pitch_label = QLabel(euler_angle)
        euler_layout.addWidget (Pitch_label, 2, 1, Qt.AlignCenter)
        Pitch_label.setText(str(Pitch_deg))

        Roll_label = QLabel(euler_angle)
        euler_layout.addWidget (Roll_label, 3, 1, Qt.AlignCenter)
        Roll_label.setText(str(Roll_deg))


        #interal velocity 
        internal_velocity = QWidget(centralWidget)
        layout.addWidget(internal_velocity, 1, 1, Qt.AlignRight)
        internal_velocity.setStyleSheet("background-color: gray;")
        internal_velocity.setFixedSize(200, 100)

        velocity_layout = QGridLayout(internal_velocity)
        internal_velocity.setLayout(velocity_layout)

        velocity_title = QLabel(internal_velocity)
        velocity_title.setText("Vel, Internal")
        velocity_layout.addWidget(velocity_title, 0, 0, 1, 0, Qt.AlignCenter)

        vel_x_value = 0.0
        vel_y_value = 0.0
        vel_z_value = 0.0

        vel_x = QLabel(internal_velocity)
        velocity_layout.addWidget(vel_x, 1, 0, Qt.AlignCenter)
        vel_x.setText("X")

        vel_y = QLabel(internal_velocity)
        velocity_layout.addWidget(vel_y, 2, 0, Qt.AlignCenter)
        vel_y.setText("Y")

        vel_z = QLabel(internal_velocity)
        velocity_layout.addWidget(vel_z, 3, 0, Qt.AlignCenter)
        vel_z.setText("Z")

        vel_x_label = QLabel(internal_velocity)
        velocity_layout.addWidget (vel_x_label, 1, 1, Qt.AlignCenter)
        vel_x_label.setText(str(vel_x_value))

        vel_y_label = QLabel(internal_velocity)
        velocity_layout.addWidget (vel_y_label, 2, 1, Qt.AlignCenter)
        vel_y_label.setText(str(vel_y_value))

        vel_z_label = QLabel(internal_velocity)
        velocity_layout.addWidget (vel_z_label, 3, 1, Qt.AlignCenter)
        vel_z_label.setText(str(vel_z_value))

        #internal acceleration
        internal_acceleration = QWidget(centralWidget)
        layout.addWidget(internal_acceleration, 2, 1, Qt.AlignRight)
        internal_acceleration.setStyleSheet("background-color: gray;")
        internal_acceleration.setFixedSize(200, 100)

        acceleration_layout = QGridLayout(internal_acceleration)
        internal_acceleration.setLayout(acceleration_layout)

        acceleration_title = QLabel(internal_acceleration)
        acceleration_title.setText("Acceleration, Internal")
        acceleration_layout.addWidget(acceleration_title, 0, 0, 1, 0, Qt.AlignCenter)

        accel_x_value = 0.0
        accel_y_value = 0.0
        accel_z_value = 0.0

        accel_x = QLabel(internal_acceleration)
        acceleration_layout.addWidget(accel_x, 1, 0, Qt.AlignCenter)
        accel_x.setText("X")

        accel_y = QLabel(internal_acceleration)
        acceleration_layout.addWidget(accel_y, 2, 0, Qt.AlignCenter)
        accel_y.setText("Y")

        accel_z = QLabel(internal_acceleration)
        acceleration_layout.addWidget(accel_z, 3, 0, Qt.AlignCenter)
        accel_z.setText("Z")

        accel_x_label = QLabel(internal_acceleration)
        acceleration_layout.addWidget (accel_x_label, 1, 1, Qt.AlignCenter)
        accel_x_label.setText(str(accel_y_value))

        accel_y_label = QLabel(internal_acceleration)
        acceleration_layout.addWidget (accel_y_label, 2, 1, Qt.AlignCenter)
        accel_y_label.setText(str(accel_y_value))

        accel_z_label = QLabel(internal_acceleration)
        acceleration_layout.addWidget (accel_z_label, 3, 1, Qt.AlignCenter)
        accel_z_label.setText(str(accel_z_value))

        #fin controls
        fin_controls = QWidget(centralWidget)
        layout.addWidget(fin_controls, 0, 0, 0, 1, Qt.AlignTop | Qt.AlignLeft)
        fin_controls.setFixedSize(300, 200)

        fin_controls.setStyleSheet("background-color: gray;")

        fin_layout = QGridLayout(fin_controls)
        fin_controls.setLayout(fin_layout)


        minus1 = QPushButton("-1")
        minus1.setFixedSize(50, 50)
        fin_layout.addWidget(minus1, 0, 0)

        plus1 = QPushButton("+1")
        plus1.setFixedSize(50, 50)
        fin_layout.addWidget(plus1, 0, 1)

        minus2 = QPushButton("-2")
        minus2.setFixedSize(50, 50)
        fin_layout.addWidget(minus2, 1, 0)

        plus2 = QPushButton("+2")
        plus2.setFixedSize(50, 50)
        fin_layout.addWidget(plus2, 1, 1)

        minus3 = QPushButton("-3")
        minus3.setFixedSize(50, 50)
        fin_layout.addWidget(minus3, 2, 0)

        plus3 = QPushButton("+3")
        plus3.setFixedSize(50, 50)
        fin_layout.addWidget(plus3, 2, 1)

        fin_alignment = QPushButton("fin alignment")
        fin_alignment.setFixedSize(150, 50)
        fin_layout.addWidget(fin_alignment, 1, 2)
        
        fin_test = QPushButton("fin test")
        fin_test.setFixedSize(150, 50)
        fin_layout.addWidget(fin_test, 0, 2)

        done = QPushButton("done")
        done.setFixedSize(150, 50)
        fin_layout.addWidget(done, 2, 2)