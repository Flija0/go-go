package com.example.back.controllers;

import com.example.back.entities.Ride;
import com.example.back.serviceInterfaces.IRideService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/ride")
public class RideController {

    IRideService iRideService;

    @PostMapping("/add/{userid}")
    Ride addRide(@PathVariable int userid, @RequestBody Ride ride){
        return iRideService.addRide(ride , userid);
    }

    @GetMapping("/get/{id}")
    Ride getRide(@PathVariable int id){
        return iRideService.getRide(id);
    }

    @PutMapping("/update")
    Ride updateRide(@RequestBody Ride ride){
        return iRideService.updateRide(ride);
    }

    @DeleteMapping("/delete/{id}")
    void deleteRide(@PathVariable int id){
        iRideService.deleteRide(id);
    }

    @GetMapping("/getAllRidesForTodayAndTomorrow/{id}")
    List<Ride> getAllRidesForTodayAndTomorrow(@PathVariable int id){
        return iRideService.getAllRidesForTodayAndTomorrow(id);
    }
}
