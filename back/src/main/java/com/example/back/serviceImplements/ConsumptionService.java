package com.example.back.serviceImplements;

import com.example.back.entities.Demand;
import com.example.back.entities.Ride;
import com.example.back.entities.User;
import com.example.back.repositories.DemandRepo;
import com.example.back.repositories.RideRepo;
import com.example.back.repositories.UserRepo;
import com.example.back.serviceInterfaces.IConsumptionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ConsumptionService implements IConsumptionService {
    @Autowired
    UserRepo userRepo;

    @Autowired
    RideRepo rideRepo;

    @Override
    public List<User> TopThreeSavedConsumers() {
        return userRepo.findAll().stream().sorted((u1, u2) -> u2.getConsumptionExpected() - u1.getConsumptionExpected()).limit(3).collect(Collectors.toList());
    }

    @Override
    public int TotalConsumptionSaved() {
        int TotalConsumptionSavedForThisWeek = 0;
        for (User user : userRepo.findAll()) {
            TotalConsumptionSavedForThisWeek += user.getConsumptionExpected();
        }

        for (Ride ride : rideRepo.findAll()) {
            TotalConsumptionSavedForThisWeek -= ride.getConsumption();
        }

        return TotalConsumptionSavedForThisWeek;
    }
}
