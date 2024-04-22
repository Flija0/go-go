package com.example.back.dto;

import lombok.*;

import java.io.Serializable;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class jwtDTO implements Serializable {
    private String jwtToken;
}

