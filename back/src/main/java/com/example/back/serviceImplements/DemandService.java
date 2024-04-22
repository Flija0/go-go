package com.example.back.serviceImplements;

import com.example.back.entities.Demand;
import com.example.back.entities.Ride;
import com.example.back.entities.Status;
import com.example.back.entities.User;
import com.example.back.repositories.DemandRepo;
import com.example.back.repositories.RideRepo;
import com.example.back.repositories.UserRepo;
import com.example.back.serviceInterfaces.IDemandService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class DemandService implements IDemandService {

    @Autowired
    DemandRepo demandRepo;

    @Autowired
    UserRepo userRepo;

    @Autowired
    RideRepo rideRepo;

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
    public Demand addDemand(int userid, int rideid) {
        User user = userRepo.findById(userid).orElse(null);
        if(user == null) return null;
        Ride ride = rideRepo.findById(rideid).orElse(null);
        if(ride == null) return null;
        Demand demand = new Demand();
        demand.setUser(user);
        demand.setRide(ride);
        demand.setStatus(Status.Waiting);

        return demandRepo.save(demand);
    }

    @Override
    public List<Demand> getAllDemandsForTheRideCreator(int id) {

        Calendar today = Calendar.getInstance(); // Get today's date
        today.set(Calendar.HOUR_OF_DAY, 0); // Set hours, minutes, seconds, and milliseconds to 0 for accurate comparison
        today.set(Calendar.MINUTE, 0);
        today.set(Calendar.SECOND, 0);
        today.set(Calendar.MILLISECOND, 0);

        return demandRepo.findAll().stream().filter(demand -> demand.getRide().getCreator().getId() == id &&
                isToday(demand.getRide().getGoingOffTime(), today.getTime() ) || isTomorrow(demand.getRide().getGoingOffTime(), today.getTime())
        ).collect(Collectors.toList());
    }

    @Override
    public Demand getSelectedDemand(int id) {
        return demandRepo.findById(id).orElse(null);
    }

    @Override
    public Demand ChangeDemandStatus(int id, String status) {
        Demand demand = demandRepo.findById(id).orElse(null);
        if(demand == null) return null;
        demand.setStatus(Status.valueOf(status));
        return demandRepo.save(demand);
    }
}
