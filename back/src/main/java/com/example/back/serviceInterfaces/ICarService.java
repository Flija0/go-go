package com.example.back.serviceInterfaces;

import com.example.back.entities.Car;
import com.example.back.entities.Ride;
import com.example.back.entities.User;

public interface ICarService {
    Car addCar(User user);

    Car getCar (int id);

}
