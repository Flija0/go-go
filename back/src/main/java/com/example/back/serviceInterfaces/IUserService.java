package com.example.back.serviceInterfaces;

import com.example.back.dto.jwtDTO;
import com.example.back.entities.User;

import java.util.List;

public interface IUserService {
    User decodeToken(String jwtToken);
    jwtDTO addUser(User user);
    //Boolean editUser(User user);
    //Boolean ForgotPassword(LoginDTO loginDTO);
    Boolean validateAccount(String jwt);
    List<User> listUsers();
}
