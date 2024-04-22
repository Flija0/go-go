package com.example.back.serviceInterfaces;

import com.example.back.entities.Demand;

import java.util.List;

public interface IDemandService {

    Demand addDemand(int userid, int rideid);

    List<Demand> getAllDemandsForTheRideCreator(int id);

    Demand getSelectedDemand(int id);

    Demand ChangeDemandStatus(int id, String status);
}
