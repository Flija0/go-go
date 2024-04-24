package com.example.back.controllers;

import com.example.back.entities.Car;
import com.example.back.entities.Ride;
import com.example.back.entities.User;
import com.example.back.repositories.CarRepo;
import com.example.back.repositories.UserRepo;
import com.example.back.serviceImplements.CarService;
import com.example.back.serviceImplements.JwtService;
import com.example.back.serviceImplements.UserService;
import com.example.back.serviceInterfaces.ICarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

@RestController
public class CarController {

    @Autowired
    private CarRepo carRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private CarService carService;

    @Autowired
    private UserRepo userRepository;

    @Transactional
    @PostMapping("/addCar")
    public ResponseEntity<?> createCar(@RequestBody Car car, @RequestHeader("Authorization") String token) {
        String jwtToken = token.substring(7); // Remove "Bearer " prefix
        int userId = userService.getUserIdFromToken(jwtToken);
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found with ID: " + userId));

        car.setOwner(user);

        carRepository.save(car);
        userRepository.save(user);

        return ResponseEntity.ok(car);
    }

    @GetMapping("/getCar")
    public Car getCar(@RequestHeader(HttpHeaders.AUTHORIZATION) String jwtToken){
        User user = userService.decodeToken(jwtToken);
        return carService.getCar(user.getId());
    }


    @DeleteMapping("/deleteCar/{carId}")
    public ResponseEntity<String> deleteCar(@PathVariable int carId, @RequestHeader("Authorization") String token) {
        String jwtToken = token.substring(7); // Remove "Bearer " prefix
        int userId = userService.getUserIdFromToken(jwtToken);
        carService.deleteCar(carId, userId);
        return ResponseEntity.ok("Car deleted successfully.");
    }
}
