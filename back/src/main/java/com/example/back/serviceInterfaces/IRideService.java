package com.example.back.serviceInterfaces;

import com.example.back.entities.Ride;

import java.util.List;

public interface IRideService {

    Ride addRide(Ride ride, int creatorId);

    Ride getRide(int id);

    Ride updateRide(Ride ride, int rideId);

    void deleteRide(int id);

    List<Ride> getAllRidesForTodayAndTomorrow();


}
