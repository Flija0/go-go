package com.example.back.serviceInterfaces;

import com.example.back.entities.User;

import java.util.List;

public interface IUserService {
    User addUser(User user);
    List<User> listUsers();
}
