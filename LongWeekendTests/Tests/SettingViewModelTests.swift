//
//  SettingViewModelTests.swift
//  LongWeekendTests
//
//  Created by funzin on 2019/10/26.
//

import XCTest

@testable import LongWeekend
class SettingViewModelTests: XCTestCase {

    var viewModel: SettingViewModel!
    var mockUserDefaults: MockUserDefautls!
    var dateManager: DateManager!

    override func setUp() {
        self.mockUserDefaults = MockUserDefautls()
        self.viewModel = SettingViewModel(userDefaults: mockUserDefaults)
        self.dateManager = DateManager(formatter: DateManager.Formatter.holidayJpformatter)
    }

    override func tearDown() {
    }

    func test_init() {

        let fromDate = dateManager.date(from: "2018-01-01")
        let toDate = dateManager.date(from: "2018-01-10")
        let nationalHolidaySegment = NationalHolidaySegment.containsNationalHoliday
        let sortCriteriaSegment = SortCriteriaSegment.numberOfHolidays
        let paidDaysCount = 4
        let minimumNumberOfHolidays = 5

        mockUserDefaults[.fromDate] = fromDate
        mockUserDefaults[.toDate] = toDate
        mockUserDefaults[.nationalHolidaySegment] = nationalHolidaySegment
        mockUserDefaults[.sortCriteriaSegment] = sortCriteriaSegment
        mockUserDefaults[.paidDaysCount] = paidDaysCount
        mockUserDefaults[.minimumNumberOfHolidays] = minimumNumberOfHolidays

        self.viewModel = SettingViewModel(userDefaults: mockUserDefaults)

        XCTAssertEqual(viewModel.fromDate, fromDate)
        XCTAssertEqual(viewModel.toDate, toDate)
        XCTAssertEqual(viewModel.nationalHolidaySegment, nationalHolidaySegment)
        XCTAssertEqual(viewModel.sortCriteriaSegment, sortCriteriaSegment)
        XCTAssertEqual(viewModel.minimumNumberOfHolidays, minimumNumberOfHolidays)
    }

    func test_save() {

        let fromDate = dateManager.date(from: "2018-01-01")
        let toDate = dateManager.date(from: "2018-01-10")
        let nationalHolidaySegment = NationalHolidaySegment.containsNationalHoliday
        let sortCriteriaSegment = SortCriteriaSegment.numberOfHolidays
        let paidDaysCount = 4
        let minimumNumberOfHolidays = 5

        viewModel.fromDate = fromDate
        viewModel.toDate = toDate
        viewModel.nationalHolidaySegment = nationalHolidaySegment
        viewModel.sortCriteriaSegment = sortCriteriaSegment
        viewModel.paidDaysCount = paidDaysCount
        viewModel.minimumNumberOfHolidays = minimumNumberOfHolidays

        viewModel.save()

        XCTAssertEqual(mockUserDefaults[.fromDate], fromDate)
        XCTAssertEqual(mockUserDefaults[.toDate], toDate)
        XCTAssertEqual(mockUserDefaults[.nationalHolidaySegment], nationalHolidaySegment)
        XCTAssertEqual(mockUserDefaults[.sortCriteriaSegment], sortCriteriaSegment)
        XCTAssertEqual(mockUserDefaults[.minimumNumberOfHolidays], minimumNumberOfHolidays)
    }
}
