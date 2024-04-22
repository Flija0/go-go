package com.example.back.controllers;

import com.example.back.entities.Car;
import com.example.back.entities.User;
import com.example.back.repositories.CarRepo;
import com.example.back.repositories.UserRepo;
import com.example.back.serviceImplements.JwtService;
import com.example.back.serviceImplements.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CarController {

    @Autowired
    private CarRepo carRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private JwtService jwtService;

    @Autowired
    private UserRepo userRepository;

    @Transactional
    @PostMapping("/cars")
    public ResponseEntity<?> createCar(@RequestBody Car car, @RequestHeader("Authorization") String token) {
        String jwtToken = token.substring(7); // Remove "Bearer " prefix

        // Find user ID from the token
        int userId = userService.getUserIdFromToken(jwtToken);

        // Find the user by ID
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found with ID: " + userId));

        // Set the owner of the car to the user
        car.setOwner(user);


        // Save the car
        carRepository.save(car);
        userRepository.save(user);

        return ResponseEntity.ok(car);
    }
}
