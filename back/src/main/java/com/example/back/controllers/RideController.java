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

    @PutMapping("/update/{rideId}")
    Ride updateRide(@RequestBody Ride ride, @PathVariable int rideId){
        return iRideService.updateRide(ride, rideId);
    }

    @DeleteMapping("/delete/{id}")
    void deleteRide(@PathVariable int id){
        iRideService.deleteRide(id);
    }

    @GetMapping("/getAllRidesForTodayAndTomorrow")
    List<Ride> getAllRidesForTodayAndTomorrow(){
        return iRideService.getAllRidesForTodayAndTomorrow();
    }
}
