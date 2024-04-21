package com.example.back.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Car implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Setter(AccessLevel.NONE)
    private int id;
    private int power;
    private String brand;
    private String serialNumber;
    private String photo;

    @NotFound(action= NotFoundAction.IGNORE)
    @JsonIgnore
    @OneToOne(mappedBy="car")
    private User owner;
}
