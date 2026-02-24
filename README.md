# Ground System GUI for Real-Time Flight Computer

<p align="center">
  <img src="Grounds Station GUI.png" alt="Ground System GUI Screenshot" width="600">
</p>

This project is a custom-built **Ground System Graphical User Interface (GUI)** developed in **Processing (Java)** to visualize and interact with telemetry data from a real-time flight computer. It was designed to display live flight data such as orientation, altitude, velocity, and acceleration while also providing control panels for system testing and launch simulation.

---

## Overview

The GUI connects to a flight computer via a serial interface and continuously receives streamed telemetry data.  
It parses and visualizes this data in real time using custom graph rendering and a 3D rocket model that rotates based on roll, pitch, and yaw values.  

The interface provides:
- A **3D visualization** of the vehicle updated from live orientation data.  
- **Graph panels** for roll, pitch, yaw, altitude, velocity, and acceleration.  
- **System panels** showing GPS, connection, and voltage status.  
- **Interactive UI elements** such as fin angle controls, GNC test buttons, and a simulated launch panel.

This project was created to demonstrate integration between software visualization, embedded data systems, and real-time user interfaces.

---

## Technical Summary

- **Language:** Java (Processing)  
- **Runtime:** Processing IDE, using `P3D` for 3D rendering and `processing.serial` for serial communication.  
- **Input:** CSV-formatted telemetry (`yaw, pitch, roll, altitude, velocity`) at 115200 baud.  
- **Rendering:** Custom-drawn line graphs and a 3D OBJ rocket model (`PShape`).  
- **Architecture:** Serial data → parsed → stored in rolling data arrays → visualized each frame in `draw()` loop.  

---

## Key Features

- **Real-time telemetry visualization** using custom-built graphing logic.  
- **3D attitude display** based on roll, pitch, and yaw rotation data.  
- **Custom UI design** with modular panels for status, control, and data visualization.  
- **Live serial communication** with flight hardware for responsive updates.  
- **Scalable structure** for adding new telemetry metrics or control features.  

---

## Development Goals

This project was developed to:
- Practice integrating embedded flight data with real-time visualization tools.  
- Build a modular, data-driven GUI without relying on external plotting or UI libraries.  
- Demonstrate proficiency in low-level serial communication and data parsing.  
- Apply visual design principles to engineering tools for clarity and usability.  
