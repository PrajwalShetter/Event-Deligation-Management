package com.xworkz.eventDeligation.event;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CompanyRegistrationEvent {

    private String companyName;
    private String email;
    private boolean approved;
    private String rejectFeedback;
    private String updateToken;


    // Registration constructor
    public CompanyRegistrationEvent(String companyName, String email) {
        this.companyName = companyName;
        this.email = email;
        this.approved = false;
        this.rejectFeedback = null;
        this.updateToken = null;
    }

    // Approval constructor
    public CompanyRegistrationEvent(String companyName, String email, boolean approved) {
        this.companyName = companyName;
        this.email = email;
        this.approved = approved;
        this.rejectFeedback = null;
        this.updateToken = null;
    }
}