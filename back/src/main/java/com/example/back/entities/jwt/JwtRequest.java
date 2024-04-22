package com.example.back.entities.jwt;

import com.example.back.entities.Gender;

public class JwtRequest {

    private String userEmail;
    private String userPassword;

    private String firstName;

    private String lastName;

    private Gender Gender;

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public com.example.back.entities.Gender getGender() {
        return Gender;
    }

    public void setGender(com.example.back.entities.Gender gender) {
        Gender = gender;
    }
}
