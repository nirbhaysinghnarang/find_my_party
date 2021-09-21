//
//  Party.swift
//  FindMyParty
//
//  Created by Nirbhay Singh on 21/09/21.
//

import Foundation
import CoreLocation

class Party{
    var organiser:MainUser
    var date:Date
    var location:CLLocationCoordinate2D
    var groupsAttending:[PartyGroup]
    var groupsRequested:[PartyGroup]
    var ticketPrice:Float
    
    init(organiser:MainUser, date:Date, location:CLLocationCoordinate2D, groupsAttending:[PartyGroup], ticketPrice:Float, groupsRequested:[PartyGroup]) {
        self.organiser = organiser
        self.date = date
        self.location = location
        self.groupsAttending = groupsAttending
        self.ticketPrice = ticketPrice
        self.groupsRequested = groupsRequested
    }
    func addGroup(group:PartyGroup){
        self.groupsAttending.append(group)
    }
    func removeGroup(group:PartyGroup) -> Bool{
        //primary-key: group leader email
        let groupLeaderEmail = group.organiser.email
        for (index,elem) in self.groupsAttending.enumerated(){
            if(elem.organiser.email==groupLeaderEmail){
                self.groupsAttending.remove(at: index)
                return true
            }
        }
        return false
    }
    func addGroupRequest(group:PartyGroup){
        self.groupsRequested.append(group)
    }
    func denyGroupRequest(group:PartyGroup) -> Bool{
        let groupLeaderEmail = group.organiser.email
        for (index,elem) in self.groupsRequested.enumerated(){
            if(elem.organiser.email==groupLeaderEmail){
                self.groupsAttending.remove(at: index)
                return true
            }
        }
        return false
    }
    func isSameParty(party:Party)->Bool{
        if(party.date==self.date && party.location.latitude==self.location.latitude && self.location.longitude==self.location.longitude){
            return true
        }
        return false
    }

}
