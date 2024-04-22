package com.example.back.serviceImplements;

import com.example.back.entities.Gender;
import com.example.back.entities.Ride;
import com.example.back.entities.User;
import com.example.back.repositories.RideRepo;
import com.example.back.repositories.UserRepo;
import com.example.back.serviceInterfaces.IRideService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class RideService implements IRideService {

    @Autowired
    RideRepo rideRepo;

    @Autowired
    UserRepo userRepo;


    private boolean isToday(Date date1, Date date2) {
        Calendar cal1 = Calendar.getInstance();
        cal1.setTime(date1);
        Calendar cal2 = Calendar.getInstance();
        cal2.setTime(date2);
        return cal1.get(Calendar.YEAR) == cal2.get(Calendar.YEAR) &&
                cal1.get(Calendar.DAY_OF_YEAR) == cal2.get(Calendar.DAY_OF_YEAR);
    }

    private boolean isTomorrow(Date date1, Date date2) {
        Calendar cal1 = Calendar.getInstance();
        cal1.setTime(date1);
        Calendar cal2 = Calendar.getInstance();
        cal2.setTime(date2);
        return cal1.get(Calendar.YEAR) == cal2.get(Calendar.YEAR) &&
                cal1.get(Calendar.DAY_OF_YEAR) == cal2.get(Calendar.DAY_OF_YEAR) + 1;
    }


        @Override
    public Ride addRide(Ride ride, int creatorId) {
        userRepo.findById(creatorId).ifPresent(ride::setCreator);
        return rideRepo.save(ride);
    }

    @Override
    public Ride getRide(int id) {
        return rideRepo.findById(id).orElse(null);
    }

    @Override
    public Ride updateRide(Ride ride, int rideId) {
        Ride rideToUpdate = rideRepo.findById(rideId).orElse(null);
        if(rideToUpdate == null) return null;

        if(ride.getFinalDestination() != null)
            rideToUpdate.setFinalDestination(ride.getFinalDestination());

        if(ride.getGoingOffTime() != null)
            rideToUpdate.setGoingOffTime(ride.getGoingOffTime());

        return rideRepo.save(rideToUpdate);
    }

    @Override
    public void deleteRide(int id) {
        rideRepo.deleteById(id);
    }

    @Override
    public List<Ride> getAllRidesForTodayAndTomorrow(int id) {

        Date today = new Date();
        Date tomorrow = new Date(today.getTime() + 24 * 60 * 60 * 1000);

        User user = userRepo.findById(id).orElse(null);
        if(user == null) return null;

        if(user.getGender() == Gender.Female)
            return rideRepo.findAll().stream()
                    .filter(ride -> ride.getNumberOfSeats() > 0)
                    .filter(ride -> !ride.getGoingOffTime().before(today))
                    .filter(ride -> isToday(ride.getGoingOffTime(), today) || isTomorrow(ride.getGoingOffTime(), tomorrow))
                    .collect(Collectors.toList());
        else
        return rideRepo.findAll().stream()
                .filter(ride -> ride.getNumberOfSeats() > 0)
                .filter(ride -> !ride.getGoingOffTime().before(today))
                .filter(ride -> isToday(ride.getGoingOffTime(), today) || isTomorrow(ride.getGoingOffTime(), tomorrow))
                .filter(ride -> !ride.getFemaleOnly())
                .collect(Collectors.toList());
    }
}
