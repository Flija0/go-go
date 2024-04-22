package com.example.back.repositories;

import com.example.back.entities.Demand;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DemandRepo  extends JpaRepository<Demand,Integer> {
}
