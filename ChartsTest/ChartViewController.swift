//
//  ChartViewController.swift
//  ChartsTest
//
//  Created by Malcom Jones on 5/4/20.
//  Copyright © 2020 Malcom Jones. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController {

    @IBOutlet weak var bedtimeEnd: UIDatePicker!
    @IBOutlet weak var lineChart: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lineChartUpdate(morningWakeTime: bedtimeEnd)
    }
    
    @IBAction func renderCharts() {
        lineChartUpdate(morningWakeTime: bedtimeEnd)
    }
    
    func convertTimeToNumeric(inputDatePicker: UIDatePicker) -> Int {
        // Convert any time into numeric value, from 0-2399
        // Used to plot sleep and wake times on line plot as x values
        print(inputDatePicker)
        let components = Calendar.current.dateComponents([.hour, .minute], from:inputDatePicker.date)
        let hour = components.hour!
        let minute = components.minute!
        
        let integerTime = (hour*100) + ((minute/60)*100)
        //let integerTime = 0650 // test for 6:30 AM wake time
        return integerTime
    }
    
//    func createTimelineDataEntry(sleepStart: Int, sleepEnd:Int) -> Array<ChartDataEntry> {
//        var timelineEntry = [ChartDataEntry]()
//        for i in sleepStart...sleepEnd {
//            let value = ChartDataEntry(x:Double(i), y:Double(0))
//            timelineEntry.append(value)
//        }
//        return timelineEntry
//    }
    
//    func createTimelineDataEntry(hoursSlept: [Int]) -> Array<ChartDataEntry> {
//        var timelineEntry = [ChartDataEntry]()
//        for i in 0..<hoursSlept.count {
//            let value = ChartDataEntry(x: Double(i), y: Double(hoursSlept[i]))
//            timelineEntry.append(value)
//        }
//        return timelineEntry
//    }
    
    func createTimelineDataEntry(sleepHour: [Double], day: Int) -> Array<ChartDataEntry> {
        var timelineEntry = [ChartDataEntry]()
        var dayCount = 0
        if(day == 1) {
            dayCount = 1
        }
        if(day == 2) {
            dayCount = 2
        }
        if(day == 3) {
            dayCount = 3
        }
        if(day == 4) {
            dayCount = 4
        }
        if(day == 5) {
            dayCount = 5
        }
        if(day == 6) {
            dayCount = 6
        }
        if(day == 7) {
            dayCount = 7
        }
        
        for i in sleepHour {
            let value = ChartDataEntry(x: i, y: Double(dayCount))
            timelineEntry.append(value)
        }
        return timelineEntry
    }
    
    func lineChartUpdate(morningWakeTime: UIDatePicker) {
        // This view creation needs to be cleaned up! It could be improved by:
        // 1. Not recreating the full-day timeline every time the chart is updated. Possible to render and update separately?
        // 2. Creating a function to create each data set. Should be pretty easy, but wake and bedtimes have single entries and naps have start and stop times
        //      A. Done, but this function is still a lot of duplicate code. How can it be further converted to functions? By child age, there will be 5 data entries per day; these can be looped but can they be assigned to different variables? Do they need to be different variables if the chart is not interactive?
        // 3. Actually make it work? I can't test because xcode simulator on this computer shows blank white screen... probably the LaunchScreen storyboard but I don't know how to get past it!
        // 4. Plot times for all naps, including those that have not happened yet, based on user-input Schedule in Nudge. Variables should already exist and be available to ViewController
        // 5. Decrease opacity on naps taking place in the future to differentiate current and planned naps
        //      A. Hardest to do, imo
        // 6. Hide all axes and gridlines
        //      A. possible that axes are hidden
        
        let sleepTimes01 = [6.5, 8, 9, 11.25, 12.25, 15, 14, 17.5]
        let sleepTimes02 = [6.5, 8, 9, 11.25, 12.25, 15, 14, 17.5]
        let sleepTimes03 = [6.5, 8, 9, 11.25, 12.25, 15, 14, 17.5]
        let sleepTimes04 = [6.5, 8, 9, 11.25, 12.25, 15, 14, 17.5]
        let sleepTimes05 = [6.5, 8, 9, 11.25, 12.25, 15, 14, 17.5]
        let sleepTimes06 = [6.5, 8, 9, 11.25, 12.25, 14.5, 14, 17.5]
        let sleepTimes07 = [6.5, 8, 9, 11.25, 12.25, 15, 14, 17.5]
        
        var allSleepTimes = [[Double]]()
        allSleepTimes.append(sleepTimes01)
        allSleepTimes.append(sleepTimes02)
        allSleepTimes.append(sleepTimes03)
        allSleepTimes.append(sleepTimes04)
        allSleepTimes.append(sleepTimes05)
        allSleepTimes.append(sleepTimes06)
        allSleepTimes.append(sleepTimes07)
        
        let data = LineChartData()
        
        
        for (index, i) in allSleepTimes.enumerated() {
            let dailyTimelineEntry = createTimelineDataEntry(sleepHour: i, day: index+1 )
            let dailyTimelineDataSet = LineChartDataSet(dailyTimelineEntry)
            dailyTimelineDataSet.colors = [UIColor.blue]
            dailyTimelineDataSet.lineWidth = 5
            dailyTimelineDataSet.drawValuesEnabled = false
            
            for nudgeDataSet in [dailyTimelineDataSet]{
                data.addDataSet(nudgeDataSet)
            }
        }
//        let dailyTimelineEntry = createTimelineDataEntry(sleepHour: sleepTimes, day: 1)
//        let dailyTimelineDataSet = LineChartDataSet(dailyTimelineEntry)
//        dailyTimelineDataSet.colors = [UIColor.blue]
//        dailyTimelineDataSet.lineWidth = 5
//        dailyTimelineDataSet.drawValuesEnabled = false
        
//        let sleepTimes02 = [6.5, 8, 9, 11.25, 12.25, 15, 14, 17.5]
//        let dailyTimelineEntry02 = createTimelineDataEntry(sleepHour: sleepTimes02, day: 2)
//        let dailyTimelineDataSet02 = LineChartDataSet(dailyTimelineEntry02)
//        dailyTimelineDataSet02.colors = [UIColor.red]
//        dailyTimelineDataSet02.lineWidth = 5
//        dailyTimelineDataSet02.drawValuesEnabled = false
        
        // Next, add in timeline entries for each wake and nap time
        // Bedtime wake
//        let morningWakeTimeInteger = convertTimeToNumeric(inputDatePicker: morningWakeTime) // Convert wake time to integer with base-100 minutes
//        let wakeTimelineEntry = createTimelineDataEntry(sleepStart: 0, sleepEnd: morningWakeTimeInteger) // Create timeline data from 0 minute to wake minute
//        let wakeTimelineDataSet = LineChartDataSet(wakeTimelineEntry) // Convert DataEntry to DataSet
//        wakeTimelineDataSet.colors = [NSUIColor.blue] // Change to Nudge purple later
//        wakeTimelineDataSet.lineWidth=7 // Set thicker width for active sleep time
        
        // Nap 1
        // Nap 2
        // Nap 3
        
        // Bedtime
        
        // Finally, add all data sets to the data that is plotted on the chart view
//        let data = LineChartData()
//        for nudgeDataSet in [dailyTimelineDataSet, wakeTimelineDataSet]{
//        for nudgeDataSet in [dailyTimelineDataSet]{
//            data.addDataSet(nudgeDataSet)
//        }
//        for nudgeDataSet in [dailyTimelineDataSet02]{
//            data.addDataSet(nudgeDataSet)
//        }
        lineChart.data = data
        lineChart.rightAxis.enabled = false
        
        lineChart.leftAxis.enabled = false
        lineChart.leftAxis.axisMinimum = 0
        lineChart.leftAxis.axisMaximum  = 8
        lineChart.leftAxis.resetCustomAxisMax()
        
        lineChart.xAxis.enabled = true
        lineChart.xAxis.labelPosition = XAxis.LabelPosition.bottom
        lineChart.xAxis.axisMinimum = 4
        lineChart.xAxis.axisMaximum  = 20
        lineChart.xAxis.resetCustomAxisMax()
//        let months = ["Morning Wake", "N1D", "N1W", "N2D", "N2W", "N3D", "N3W", "Evening Down"]
//        lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
//        lineChart.xAxis.granularity = 1
        
        //TODO: Pull data from Core
        //TODO: Dynamically create arrays
        //TODO: Create line charts for total sleep
        //TODO:  What kind of charts for daily data? Bar?
        
    }

}

