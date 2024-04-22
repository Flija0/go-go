package com.example.back.controllers;

import com.example.back.dto.jwtDTO;
import com.example.back.entities.User;
import com.example.back.serviceImplements.JwtService;
import com.example.back.serviceInterfaces.IUserService;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@AllArgsConstructor
@RequestMapping("/user")
public class UserController {

    @Autowired
    IUserService userService;

    @Autowired
    JwtService jwtService;

    @PostMapping("/add")
    public ResponseEntity<String> addUser(@RequestBody User user) {
         userService.addUser(user);
        String successMessage = "User created successfully";
        return ResponseEntity.ok(successMessage);
    }
    @PostMapping({"/authenticate"})
    public jwtDTO createJwtToken(@RequestBody User user) throws Exception {
        return jwtService.createJwtToken(user);
    }

    @PostMapping("/confirm/{jwt}")
    public Boolean confirmMail(@PathVariable("jwt") String jwt){
        return userService.validateAccount(jwt);
    }
}
