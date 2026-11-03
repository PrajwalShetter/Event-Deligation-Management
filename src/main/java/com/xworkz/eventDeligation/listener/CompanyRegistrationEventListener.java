package com.xworkz.eventDeligation.listener;

import com.xworkz.eventDeligation.event.CompanyRegistrationEvent;
import com.xworkz.eventDeligation.utils.EmailService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.event.TransactionalEventListener;
import org.springframework.transaction.event.TransactionPhase;

@Component
public class CompanyRegistrationEventListener {

    @Autowired
    private EmailService emailService;

    @TransactionalEventListener(phase = TransactionPhase.AFTER_COMMIT)
    public void sendRegistrationEmail(CompanyRegistrationEvent event) {

        if (event.isApproved()) {

            emailService.sendCompanyApprovalEmail(
                    event.getCompanyName(),
                    event.getEmail()
            );

        } else if (event.getRejectFeedback() != null) {

            emailService.sendCompanyRejectionEmail(
                    event.getCompanyName(),
                    event.getEmail(),
                    event.getRejectFeedback(),
                    event.getUpdateToken()
            );

        } else {

//            emailService.sendCompanyRegistrationEmail(
//                    event.getCompanyName(),
//                    event.getEmail()
//            );

            emailService.sendCompanyRegistrationSimpleEmail(
                    event.getCompanyName(),
                    event.getEmail()
            );
        }
    }
}