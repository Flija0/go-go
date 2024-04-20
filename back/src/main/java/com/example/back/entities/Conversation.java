package com.example.back.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Conversation implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Setter(AccessLevel.NONE)
    private int id;

    @Temporal(TemporalType.DATE)
    private Date createdAt;

    @ManyToMany(mappedBy = "conversationList")
    @JsonIgnore
    private List<User> userList;

    @OneToMany(mappedBy = "conversation")
    @JsonIgnore
    private List<Message> messageList;

}