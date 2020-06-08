//
//  ChartFormatter.swift
//  ChartsTest
//
//  Created by Malcom Jones Jr on 5/7/20.
//  Copyright © 2020 Malcom Jones. All rights reserved.
//

import UIKit
import Foundation
import Charts

@objc(BarChartFormatter)
public class ChartFormatter: NSObject, IAxisValueFormatter
{
  var months: [String]! = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

    public func stringForValue(_ value: Double, axis: AxisBase?) -> String
  {
    return months[Int(value)]
  }
}
