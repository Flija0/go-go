package com.example.back.controllers;

import com.example.back.entities.Demand;
import com.example.back.serviceInterfaces.IDemandService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/demand")
public class DemandController {

    IDemandService iDemandService;

     @PostMapping("/add/{userid}/{rideid}")
     Demand addDemand(@PathVariable int userid, @PathVariable int rideid){
        return iDemandService.addDemand(userid, rideid);
    }

    @PostMapping("/changeStatus/{id}/{status}")
    Demand changeDemandStatus(@PathVariable int id, @PathVariable String status){
        return iDemandService.ChangeDemandStatus(id, status);
    }

    @GetMapping("/getSelectedDemand/{id}")
    Demand getSelectedDemand(@PathVariable int id){
        return iDemandService.getSelectedDemand(id);
    }

    @GetMapping("/getAllDemandsForTheRideCreator/{id}")
    List<Demand> getAllDemandsForTheRideCreator(@PathVariable int id){
        return iDemandService.getAllDemandsForTheRideCreator(id);
    }



}
