//
//  DataGroup11.swift
//
//  Created by Andy Qua on 01/02/2021.
//

import Foundation

@available(iOS 13, macOS 10.15, *)
public class DataGroup11 : DataGroup {
    
    public public(set) var fullName : String?
    public public(set) var personalNumber : String?
    public public(set) var dateOfBirth : String?
    public public(set) var placeOfBirth : String?
    public public(set) var address : String?
    public public(set) var telephone : String?
    public public(set) var profession : String?
    public public(set) var title : String?
    public public(set) var personalSummary : String?
    public public(set) var proofOfCitizenship : String?
    public public(set) var tdNumbers : String?
    public public(set) var custodyInfo : String?

    public override var datagroupType: DataGroupId { .DG11 }

    public required init( _ data : [UInt8] ) throws {
        try super.init(data)
    }

    override func parse(_ data: [UInt8]) throws {
        var tag = try getNextTag()
        try verifyTag(tag, equals: 0x5C)
        _ = try getNextValue()
        
        repeat {
            tag = try getNextTag()
            let val = try String( bytes:getNextValue(), encoding:.utf8)
            if tag == 0x5F0E {
                fullName = val
            } else if tag == 0x5F10 {
                personalNumber = val
            } else if tag == 0x5F11 {
                placeOfBirth = val
            } else if tag == 0x5F2B {
                dateOfBirth = val
            } else if tag == 0x5F42 {
                address = val
            } else if tag == 0x5F12 {
                telephone = val
            } else if tag == 0x5F13 {
                profession = val
            } else if tag == 0x5F14 {
                title = val
            } else if tag == 0x5F15 {
                personalSummary = val
            } else if tag == 0x5F16 {
                proofOfCitizenship = val
            } else if tag == 0x5F17 {
                tdNumbers = val
            } else if tag == 0x5F18 {
                custodyInfo = val
            }
        } while pos < data.count
    }
}
