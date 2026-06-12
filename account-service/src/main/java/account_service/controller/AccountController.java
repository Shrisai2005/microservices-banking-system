package account_service.controller;

import account_service.dto.CreateAccountRequest;
import account_service.dto.DepositRequest;
import account_service.dto.TransferRequest;
import account_service.dto.WithdrawRequest;
import account_service.entity.Account;
import account_service.service.AccountService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/accounts")
@RequiredArgsConstructor
public class AccountController {

    private final AccountService accountService;

    @PostMapping("/create")
    public Account createAccount(
            @RequestBody CreateAccountRequest request) {

        return accountService.createAccount(request);
    }

    @GetMapping("/{accountNumber}")
    public Account getAccount(
            @PathVariable String accountNumber) {

        return accountService.getAccount(accountNumber);
    }

@GetMapping("/email/{email}")
public Account getAccountByEmail(
        @PathVariable String email) {

    return accountService
            .getAccountByEmail(email);
}

    @GetMapping("/balance/{accountNumber}")
    public Double getBalance(
            @PathVariable String accountNumber) {

        return accountService.getBalance(accountNumber);
    }

    @PostMapping("/deposit")
    public Account deposit(
            @RequestBody DepositRequest request) {

        return accountService.deposit(request);
    }

    @PostMapping("/withdraw")
    public Account withdraw(
            @RequestBody WithdrawRequest request) {

        return accountService.withdraw(request);
    }

    @PostMapping("/transfer")
    public String transfer(
            @RequestBody TransferRequest request) {

        return accountService.transfer(request);
    }
}