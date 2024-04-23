package com.example.back.serviceImplements;



import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.example.back.dto.jwtDTO;
import com.example.back.entities.User;
import com.example.back.repositories.UserRepo;
import com.example.back.util.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

@Service
public class JwtService implements UserDetailsService {

    private static final String SECRET = "bleedclt";
    @Autowired
    private JwtUtil jwtUtil;


    @Autowired
    private  UserRepo userRepository;

    @Autowired
    private AuthenticationManager authenticationManager;



    public  jwtDTO createJwtToken(User jwtRequest) throws Exception {
        String jwtToken ="";
        Algorithm algorithm = Algorithm.HMAC512(SECRET.getBytes());
        String userEmail = jwtRequest.getEmail();
        String userPassword = jwtRequest.getMdp();
        User user = userRepository.findByEmail(userEmail);

        if(user != null && userPassword.equals(user.getMdp())) {
            System.out.println(user.getEmail() + " found by email");

            jwtToken = JWT.create()
                    .withIssuer("bleedclt")
                    .withSubject(user.getEmail())
                    .withClaim("user", user.getId())
                    .withClaim("email", user.getEmail()) // Add user email to the token
                    .withClaim("role", user.getRole()) // Add the 'role' claim to the token
                    .withClaim("firstName", user.getFirstName()) // Add the 'role' claim to the token
                    .withClaim("lastName", user.getLastName()) // Add the 'role' claim to the token
                    .withClaim("Gender", user.getGender().toString())
                    .withIssuedAt(new Date())
                    .withExpiresAt(new Date(System.currentTimeMillis() + 24 * 60 * 60 * 1000L))
                    .withJWTId(UUID.randomUUID().toString())
                    .sign(Algorithm.HMAC512(SECRET.getBytes()));

            return new jwtDTO(jwtToken);
        } else {
            return null;
        }
    }

    public String extractUserEmail(String token) {
        DecodedJWT decodedJWT = JWT.decode(token);
        return decodedJWT.getClaim("email").asString();
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findByEmail(username);
        if (user != null) {
            return new org.springframework.security.core.userdetails.User(
                    user.getEmail(),
                    user.getMdp(),
                    getAuthority(user)
            );
        } else {
            throw new UsernameNotFoundException("User not found with username: " + username);
        }
    }

    private Set getAuthority(User user) {
        Set<SimpleGrantedAuthority> authorities = new HashSet<>();
        Integer role = user.getRole();
        if(role==99){
            authorities.add(new SimpleGrantedAuthority("ADMIN"));
        }else{
            authorities.add(new SimpleGrantedAuthority("CLIENT"));
        }
        return authorities;
    }

    private void authenticate(String userName, String userPassword) throws Exception {
        try {
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(userName, userPassword));
        } catch (DisabledException e) {
            throw new Exception("USER_DISABLED", e);
        } catch (BadCredentialsException e) {
            throw new Exception("INVALID_CREDENTIALS", e);
        }
    }


}