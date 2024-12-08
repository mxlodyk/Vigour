//  ExerciseDataProviderTests.swift
//  VigourTests
//  Created by Melody Flavel on 7/12/2024.

import XCTest
@testable import Vigour

// MARK: Exercise Data Provider Tests
final class ExerciseDataProviderTests: XCTestCase {

    var testExerciseDataProvider: ExerciseDataProvider!
    var testCoreDataManager: CoreDataManager!
    
    override func setUp() {
        super.setUp()
        
        testCoreDataManager = CoreDataManager(inMemory: true)
        let calendarDataProvider = CalendarDataProvider()
        testExerciseDataProvider = ExerciseDataProvider(calendarDataProvider: calendarDataProvider)
    }
    
    override func tearDown() {
        testCoreDataManager = nil
        testExerciseDataProvider = nil
        super.tearDown()
    }
    
    // MARK: Test that the user's preferred measurement unit is saved to the CoreData stack successfully.
    func testSaveUnit() {
        // Arrange (given)
        let unit = MeasurementSystem.metric
        
        // Act (when)
        testExerciseDataProvider.saveMeasurementSystem(unit)
        
        // Assert (then)
        let savedUnit = testExerciseDataProvider.getMeasurementSystem()
        XCTAssertEqual(savedUnit, unit, "The unit was not saved correctly.")
    }
}
