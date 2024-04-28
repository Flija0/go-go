package com.example.back.serviceImplements;

import com.example.back.entities.Day;
import com.example.back.entities.Gender;
import com.example.back.entities.Ride;
import com.example.back.entities.User;
import com.example.back.repositories.DemandRepo;
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

    @Autowired
    DemandRepo demandRepo;


        @Override
    public Ride addRide(Ride ride, int creatorId) {
        userRepo.findById(creatorId).ifPresent(ride::setCreator);

        //decrease time by 1 hour

            ride.setGoingOffTime(new Date(ride.getGoingOffTime().getTime() - 3600000));
            if(ride.getDay().equals(Day.Today))
                ride.setDateCreated(new Date());
            else if(ride.getDay().equals(Day.Tomorrow)){
                Calendar cal = Calendar.getInstance();
                cal.setTime(new Date());
                cal.add(Calendar.DATE, 1);
                ride.setDateCreated(cal.getTime());
            }

        ride.getCreator().setConsumptionExpected(ride.getCreator().getConsumptionExpected() + ride.getConsumption());
        userRepo.save(ride.getCreator());
        return rideRepo.save(ride);
    }

    @Override
    public Ride getRide(int id) {
        //get last ride by the userid
        return rideRepo.findAll().stream()
                .filter(ride->ride.getCreator().getId() == id)
                .reduce((first, second) -> second)
                .orElse(null);
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
        Ride ride = rideRepo.findById(id).orElse(null);
        if(ride == null) return;

        ride.getCreator().setConsumptionExpected(ride.getCreator().getConsumptionExpected() - ride.getConsumption());
        userRepo.save(ride.getCreator());

        //delete all demands for this ride
        demandRepo.findAll().stream()
                .filter(demand -> demand.getRide().getId() == id)
                .forEach(demandRepo::delete);


        rideRepo.deleteById(id);
    }

    @Override
    public List<Ride> getAllRidesForTodayAndTomorrow() {
            return rideRepo.findAll().stream()
                    .filter(ride -> ride.getNumberOfSeats() > 0)
                    .filter(ride -> {
                        Calendar rideDate = Calendar.getInstance();
                        rideDate.setTime(ride.getDateCreated());
                        Calendar currentDate = Calendar.getInstance();
                        // Check if the ride date is either today or tomorrow
                        return (rideDate.get(Calendar.YEAR) == currentDate.get(Calendar.YEAR) &&
                                rideDate.get(Calendar.MONTH) == currentDate.get(Calendar.MONTH) &&
                                rideDate.get(Calendar.DAY_OF_MONTH) == currentDate.get(Calendar.DAY_OF_MONTH)) ||
                                (rideDate.get(Calendar.YEAR) == currentDate.get(Calendar.YEAR) &&
                                        rideDate.get(Calendar.MONTH) == currentDate.get(Calendar.MONTH) &&
                                        rideDate.get(Calendar.DAY_OF_MONTH) == (currentDate.get(Calendar.DAY_OF_MONTH) + 1));
                    })
                    .collect(Collectors.toList());
    }
}
