# Vigour

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#program-structure)
- [Screenshots](#screenshots)

## Introduction
Vigour is a fitness application designed to help users manage and track their workout routines efficiently. Users are encouraged to complete their workouts using the application's interactive workout logging feature which has a rest timer for in between exercise sets. The application utilises CoreData for persistent data storage. The application fetches workout data and step data from the user's HealthStore and integrates this in it's goal-oriented logging features. The home view features a dumbbell animation made with Blender.

## Features
- **Program Management**: Create, edit, and manage strength-training programs.
- **Workout Management**: Create, edit, and manage workouts within each strength-training program.
- **Exercise Management**: Create, edit, and manage exercises within each workout.
- **Customisability**: Add sets to exercises with customised weights, repetitions, tempo, and rest time.
- **Workout Logging**: Workouts are logged once they have been completed within the application.
- **HealthKit Integration**: Integrates with HealthKit to track daily steps and Functional Strength Training workouts.
- **Calendar**: Displays workouts and steps completed on each day of the calendar week.
- **User-Friendly and Interactive Interface**: Easy-to-use and interactive interface with smooth navigation and clean design.

## Installation
1. Clone the repository:
    ```bash
    git clone https://github.com/mxlodyk/Vigour.git
    ```
2. Navigate to the project directory:
    ```bash
    cd Vigour
    ```
3. Open the project in Xcode:
    ```bash
    open Vigour.xcodeproj
    ```

### Prerequisites
- Xcode 10.2+

## Usage
1. Build the project in Xcode:
    - Select your target device or simulator.
    - Press `Cmd + B` to build the project.
2. Run the project:
    - Press `Cmd + R` to run the app on the simulator or a connected device.

## Project Structure
The project follows the **Model-View-ViewModel (MVVM)** architecture, so the directory is structured as follows:
- `Models`: Contains the data models and business logic of the application.
- `ViewModels`: Responsible for providing data to the Views and managing the app’s logic.
- `Views`: Contains the UI components of the app.
- `Helpers`: Contains utility classes and methods that help with common tasks throughout the app. 

## Screenshots

<div style="display: flex; flex-wrap: wrap; gap: 10px;">
  <img src="Screenshots/HomeView2.png" alt="Home View" width="200"/>
  <img src="Screenshots/WorkoutsWidgetView2.png" alt="Workouts Widget View" width="200"/>
  <img src="Screenshots/StepsWidgetView2.png" alt="Steps Widget View" width="200"/>
  <img src="Screenshots/AddWorkoutView.png" alt="Add Workout View" width="200"/>
  <img src="Screenshots/AddExerciseView.png" alt="Add Exercise View" width="200"/>
  <img src="Screenshots/AddSetView.png" alt="Add Set View" width="200"/>
  <img src="Screenshots/LogWorkoutView.png" alt="Log Workout View" width="200"/>
  <img src="Screenshots/StartTimerView.png" alt="Start Timer View" width="200"/>
</div>

