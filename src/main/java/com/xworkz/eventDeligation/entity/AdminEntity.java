package com.xworkz.eventDeligation.entity;

import com.xworkz.eventDeligation.constants.Gender;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "admin_table")
@NamedQueries({
        @NamedQuery(name = "findByEmail", query = "select admin from AdminEntity admin where admin.email = :email"),
        @NamedQuery(name = "findByPhone", query = "select admin from AdminEntity admin where admin.phone= :phone")
})

public class AdminEntity  {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "email", nullable = false, unique = true, length = 100)
    private String email;

    @Column(name = "firstName", nullable = false, length = 20)
    private String firstName;

    @Column(name = "lastName", nullable = false, length = 20)
    private String lastname;

    @Column(name = "phone", unique = true, nullable = false, length = 10)
    private String phone;

    @Enumerated(EnumType.STRING)
    @Column(name = "gender", nullable = false)
    private Gender gender;

    @Column(name = "age")
    private Integer age;

    @Column(name = "password",nullable = false)
    private String password;

    @Column(name = "status")
    private Boolean status;

    @Column(name = "count")
    private Integer count;

    @Column(name = "otp")
    private String otp;

    private String picName;

}
