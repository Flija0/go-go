package com.example.back.controllers;

import com.example.back.entities.User;
import com.example.back.serviceInterfaces.IConsumptionService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/consumption")
public class ConsumptionController {

    IConsumptionService iConsumptionService;

    @GetMapping("/topThreeSavedConsumers")
    public List<User> TopThreeSavedConsumers(){
        return iConsumptionService.TopThreeSavedConsumers();
    }

    @GetMapping("/totalConsumptionSaved")
    public int TotalConsumptionSaved(){
        return iConsumptionService.TotalConsumptionSaved();
    }
}
