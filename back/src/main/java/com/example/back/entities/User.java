package com.example.back.entities;
import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.*;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Setter(AccessLevel.NONE)
    private int id;

    private String firstName;
    private String lastName;
    private String email;
    private String mdp;
    private int phone;
    @Enumerated(EnumType.STRING)
    private Gender gender;
    private int consumptionExpected;
    private Boolean active;
    private Integer verified;
    private LocalDate dateCompte;
    private Integer role;

    @OneToOne(optional = true)
    private Car car;

    @OneToMany(mappedBy = "creator")
    @JsonIgnore
    private List<Ride> rideList;
}
