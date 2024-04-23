package com.example.back.serviceImplements;

import com.example.back.entities.Car;
import com.example.back.entities.Ride;
import com.example.back.entities.User;
import com.example.back.repositories.CarRepo;
import com.example.back.repositories.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CarService {

    @Autowired
    private CarRepo carRepository;

    @Autowired
    private UserRepo userRepository;

    public void deleteCar(int carId, int userId) {
        Car car = carRepository.findById(carId)
                .orElseThrow(() -> new RuntimeException("Car not found with ID: " + carId));
        if (car.getOwner().getId() != userId) {
            throw new RuntimeException("Unauthorized: You are not the owner of this car.");
        }
        carRepository.delete(car);
    }

    public Car getCar (int id) {
        User user = userRepository.findById(id).orElse(null);
        Car car   = carRepository.findByOwner(user);
        return car;
    }

}
