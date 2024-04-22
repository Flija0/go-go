package com.example.back.repositories;

import com.example.back.entities.Ride;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RideRepo extends JpaRepository<Ride,Integer> {
}
