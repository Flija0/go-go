package com.example.back.serviceInterfaces;

import com.example.back.entities.User;

import java.util.List;

public interface IConsumptionService {

    List<User> TopThreeSavedConsumers();

    int TotalConsumptionSaved();
}
