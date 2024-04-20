package com.example.back.entities;

import jakarta.persistence.*;
import lombok.*;

import java.io.Serializable;
import java.util.Date;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Ride implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Setter(AccessLevel.NONE)
    private int id;

    private String startLocation;
    private String finalDestination;
    private int numberOfSeats;
    @Temporal(TemporalType.DATE)
    private Date goingOffTime;
    private Boolean femaleOnly;
    private int consumption;

    @ManyToOne
    User creator;
}
