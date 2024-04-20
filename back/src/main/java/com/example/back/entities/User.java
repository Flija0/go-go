package com.example.back.entities;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.annotation.Nullable;
import jakarta.persistence.*;
import lombok.*;
import java.io.Serializable;
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
    private String login;
    private String password;
    private int phone;
    @Enumerated(EnumType.STRING)
    private Gender gender;
    private int consumptionExpected;

    @OneToOne(optional = true)
    @Nullable
    private Car car;

    @ManyToMany(cascade = CascadeType.ALL)
    private List<Conversation> conversationList;

    @OneToMany(mappedBy = "creator")
    @JsonIgnore
    private List<Ride> rideList;
}
