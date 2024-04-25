package com.example.back.entities;


import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
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
    @Temporal(TemporalType.TIME)
    @DateTimeFormat(style = "HH:mm")
    @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="HH:mm")
    private Date goingOffTime;
    @Enumerated(EnumType.STRING)
    private Day Day;

    private Boolean femaleOnly;
    private int consumption;

    private Date dateCreated;

    @ManyToOne
    User creator;
}
