
package user_service.service;

import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import user_service.dto.CreateAccountRequest;
import user_service.dto.LoginRequest;
import user_service.dto.RegisterRequest;
import user_service.entity.User;
import user_service.repository.UserRepository;
import user_service.security.JwtUtil;
import user_service.dto.UserProfileResponse;
import org.springframework.transaction.annotation.Transactional;
@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtil jwtUtil;
    private final RestTemplate restTemplate;

    @Transactional
public String register(RegisterRequest request) {

    if (userRepository.findByEmail(request.getEmail()).isPresent()) {
        return "Email already exists";
    }

    User user = User.builder()
            .fullName(request.getFullName())
            .email(request.getEmail())
            .password(passwordEncoder.encode(request.getPassword()))
            .role("USER")
            .build();

    userRepository.save(user);

    CreateAccountRequest accountRequest =
            new CreateAccountRequest();

    accountRequest.setUserEmail(
            request.getEmail());

    accountRequest.setAccountType(
            "SAVINGS");

    try {

    restTemplate.postForObject(
            "http://account-service:8082/api/accounts/create",
            accountRequest,
            Object.class
    );

} catch (Exception e) {

    e.printStackTrace();

    return "Account Creation Failed";
}

    return "User Registered Successfully";
}

    public String login(LoginRequest request) {

        User user = userRepository
                .findByEmail(request.getEmail())
                .orElse(null);

        if (user == null) {
            return "User Not Found";
        }

        boolean matches = passwordEncoder.matches(
                request.getPassword(),
                user.getPassword()
        );

        if (!matches) {
            return "Invalid Password";
        }

        return jwtUtil.generateToken(
                user.getEmail()
        );
    }
    public UserProfileResponse getProfile(
        String email) {

    User user = userRepository
            .findByEmail(email)
            .orElseThrow();

    return new UserProfileResponse(
            user.getFullName(),
            user.getEmail()
    );
}
}