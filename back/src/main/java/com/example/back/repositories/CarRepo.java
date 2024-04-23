package com.example.back.repositories;

import com.example.back.entities.Car;
import com.example.back.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CarRepo extends JpaRepository<Car,Integer> {
    Car findByOwner(User user);


}
