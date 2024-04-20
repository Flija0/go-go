package com.example.back.controllers;

import com.example.back.entities.User;
import com.example.back.serviceInterfaces.IUserService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@AllArgsConstructor
@RequestMapping("/user")
public class UserController {

    IUserService iUserService;

    @PostMapping("/addUser")
    User addUser(@RequestBody User user)
    {
        return iUserService.addUser(user);
    }

    @GetMapping("/getUsers")
    List<User> getUsers()
    {
        return iUserService.listUsers();
    }
}
