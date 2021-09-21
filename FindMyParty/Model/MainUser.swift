//
//  MainUser.swift
//  FindMyParty
//
//  Created by Nirbhay Singh on 21/09/21.
//
import Foundation
class MainUser{
    var name:String
    var photoURL:String
    var email:String
    var partiesAttended:Int
    var groupsCreated:[PartyGroup]
    var groupsPartOf:[PartyGroup]
    init(name:String,photoURL:String,email:String,partiesAttended:Int,groupsCreated:[PartyGroup], groupsPartOf:[PartyGroup]) {
        self.name = name
        self.photoURL = photoURL
        self.email = email
        self.partiesAttended = partiesAttended
        self.groupsCreated = groupsCreated
        self.groupsPartOf = groupsPartOf
    }
}
