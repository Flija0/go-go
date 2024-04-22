package com.example.back.serviceImplements;

import com.example.back.entities.Car;
import com.example.back.repositories.CarRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CarService {

    @Autowired
    private CarRepo carRepository;

    public void deleteCar(int carId, int userId) {
        Car car = carRepository.findById(carId)
                .orElseThrow(() -> new RuntimeException("Car not found with ID: " + carId));
        if (car.getOwner().getId() != userId) {
            throw new RuntimeException("Unauthorized: You are not the owner of this car.");
        }

        carRepository.delete(car);
    }
}
