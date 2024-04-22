package com.example.back.serviceImplements;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.Claim;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.example.back.dto.jwtDTO;
import com.example.back.entities.Car;
import com.example.back.entities.Gender;
import com.example.back.entities.User;
import com.example.back.entities.jwt.JwtRequest;
import com.example.back.repositories.UserRepo;
import com.example.back.serviceInterfaces.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.time.LocalDate;
import java.util.List;

@Service
public class UserService implements IUserService {

    @Autowired
    UserRepo userRepository;

    @Autowired
    JwtService jwtService;
    @Override
    public ResponseEntity<String> addUser(User user) {
        Boolean v = false;
        String motif=null;
        jwtDTO jwtToken = null;
        User user1=  userRepository.findByEmail(user.getEmail());
        if(user1!=null){
            v=true;
            motif="email";
            System.out.println("email");
        }
        if(Boolean.FALSE.equals(v)){
            user.setActive(true);
            user.setDateCompte(LocalDate.now());
            user.setRole(0);
            user.setVerified(1);
            user = userRepository.save(user);
            //Cart cart = new Cart();
            //cartSevice.addCart(user);
            JwtRequest jwtRequest = new JwtRequest();
            jwtRequest.setUserEmail(user.getEmail());
            jwtRequest.setUserPassword(user.getMdp());
            jwtRequest.setFirstName(user.getFirstName());
            jwtRequest.setLastName(user.getLastName());
            jwtRequest.setGender(user.getGender());
            System.out.println(jwtRequest.toString());
            try {
                jwtToken = jwtService.createJwtToken(user);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
            motif = "succes";
            System.out.println("success");
        }
        String successMessage = "User created successfully";
        return ResponseEntity.ok(successMessage);
    }

    public int getUserIdFromToken(String token) {
        DecodedJWT decodedJWT = JWT.decode(token);
        return decodedJWT.getClaim("user").asInt();
    }

    public void addCarToUser(int userId, Car car) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found with ID: " + userId));
        car.setOwner(user);
        userRepository.save(user);
    }
    @Override
    public Boolean validateAccount(String jwt) {
        User user = decodeToken(jwt);
        user = userRepository.findByEmail(user.getEmail());
        if(user == null){
            user = userRepository.findByEmail(user.getEmail());
            if(user == null){
                return false;
            }else{
                user.setVerified(1);
                user = userRepository.save(user);
                return user.getVerified() != 0;
            }
        }else{
            user.setVerified(1);
            user = userRepository.save(user);
            return user.getVerified() != 0;
        }
    }





    @Override
    public User decodeToken(String jwtToken){
        String mail;
        Algorithm algorithm = Algorithm.HMAC512("bleedclt");
        JWTVerifier verifier = JWT.require(algorithm)
                .withIssuer("bleedclt")
                .build();
        try {
            String jwtTokenn = URLDecoder.decode(jwtToken, "UTF-8");
            jwtTokenn=jwtTokenn.replace("Bearer ","");
            DecodedJWT decodedJWT = verifier.verify(jwtTokenn);
            Claim claim = decodedJWT.getClaim("sub");
            mail = claim.asString();
        } catch (JWTVerificationException | UnsupportedEncodingException e) {
            System.out.println(e.getMessage());
            return null;
        }
        User user = userRepository.findByEmail(mail);
        return user;
    }
    @Override
    public List<User> listUsers() {
        return userRepository.findAll();
    }
}
