package com.xworkz.eventDeligation.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "admin_login_table")
public class AdminLoginEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

   @ManyToOne
    @JoinColumn(name = "adminId", nullable = false)
    private AdminEntity admin;

   @Column(name = "date", nullable = false)
    private LocalDate date;

   @Column(name="time",nullable = false)
   private LocalTime time;

}
