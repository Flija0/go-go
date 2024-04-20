package com.example.back.serviceImplements;

import com.example.back.entities.User;
import com.example.back.repositories.UserRepo;
import com.example.back.serviceInterfaces.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService implements IUserService {
    @Autowired
    UserRepo userRepo;

    @Override
    public User addUser(User user) {
        return userRepo.save(user);
    }

    @Override
    public List<User> listUsers() {
        return userRepo.findAll();
    }
}
