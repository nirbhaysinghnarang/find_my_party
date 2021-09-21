//
//  PartyGroup.swift
//  FindMyParty
//
//  Created by Nirbhay Singh on 21/09/21.
//

import Foundation
class PartyGroup{
    
    var organiser:MainUser
    var members:[MainUser]
    
    init(organiser:MainUser, members:[MainUser]) {
        self.organiser = organiser
        self.members = members
    }
    func addMember(member:MainUser){
        self.members.append(member)
    }
    func removeMember(member:MainUser) -> Bool{
        //primary-key: email
        let memberEmail = member.email
        for (index,elem) in self.members.enumerated(){
            if(elem.email==memberEmail){
                self.members.remove(at: index)
                return true
            }
        }
        return false
    }
    
    func makeRequestForParty(party:Party, availableParties:[Party]) -> Bool{
        for availableParty in availableParties{
            if(party.isSameParty(party: availableParty)){
                availableParty.addGroupRequest(group: self)
                return true
            }
        }
        return false
    }
}
