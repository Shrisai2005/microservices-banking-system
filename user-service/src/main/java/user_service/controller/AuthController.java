package user_service.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import user_service.dto.LoginRequest;
import user_service.dto.RegisterRequest;
import user_service.service.UserService;
import user_service.dto.UserProfileResponse;
@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final UserService userService;

    @PostMapping("/register")
    public String register(@RequestBody RegisterRequest request) {
        return userService.register(request);
    }

    @PostMapping("/login")
    public String login(@RequestBody LoginRequest request) {
        return userService.login(request);
    }
    @GetMapping("/profile/{email}")
public UserProfileResponse getProfile(
        @PathVariable String email) {

    return userService.getProfile(email);
}
}