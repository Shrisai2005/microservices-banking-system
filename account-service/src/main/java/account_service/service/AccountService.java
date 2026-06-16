package account_service.service;

import account_service.dto.CreateAccountRequest;
import account_service.dto.DepositRequest;
import account_service.dto.TransferRequest;
import account_service.dto.TransactionRequest;
import account_service.dto.WithdrawRequest;
import account_service.entity.Account;
import account_service.repository.AccountRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
@RequiredArgsConstructor
public class AccountService {

    private final AccountRepository accountRepository;
    private final RestTemplate restTemplate;

    public Account createAccount(CreateAccountRequest request) {

        Account account = Account.builder()
                .accountNumber(String.valueOf(System.currentTimeMillis()))
                .accountType(request.getAccountType())
                .userEmail(request.getUserEmail())
                .balance(0.0)
                .build();

        return accountRepository.save(account);
    }

    public Account getAccount(String accountNumber) {

        return accountRepository
                .findByAccountNumber(accountNumber)
                .orElseThrow(() ->
                        new RuntimeException("Account not found"));
    }

public Account getAccountByEmail(String email) {

    return accountRepository
            .findByUserEmail(email)
            .orElseThrow(() ->
                    new RuntimeException(
                            "Account not found"));
}
    public Double getBalance(String accountNumber) {

        Account account = accountRepository
                .findByAccountNumber(accountNumber)
                .orElseThrow(() ->
                        new RuntimeException("Account not found"));

        return account.getBalance();
    }

    public Account deposit(DepositRequest request) {

        if (request.getAmount() <= 0) {
            throw new RuntimeException(
                    "Deposit amount must be greater than zero");
        }

        Account account = accountRepository
                .findByAccountNumber(request.getAccountNumber())
                .orElseThrow(() ->
                        new RuntimeException("Account not found"));

        account.setBalance(
                account.getBalance() + request.getAmount()
        );

        Account savedAccount = accountRepository.save(account);

        TransactionRequest transaction = new TransactionRequest();
        transaction.setAccountNumber(request.getAccountNumber());
        transaction.setTransactionType("DEPOSIT");
        transaction.setAmount(request.getAmount());

        restTemplate.postForObject(
                "http://transaction-service:8083/api/transactions",
                transaction,
                Object.class
        );

        return savedAccount;
    }

    public Account withdraw(WithdrawRequest request) {

        if (request.getAmount() <= 0) {
            throw new RuntimeException(
                    "Withdrawal amount must be greater than zero");
        }

        Account account = accountRepository
                .findByAccountNumber(request.getAccountNumber())
                .orElseThrow(() ->
                        new RuntimeException("Account not found"));

        if (account.getBalance() < request.getAmount()) {
            throw new RuntimeException("Insufficient balance");
        }

        account.setBalance(
                account.getBalance() - request.getAmount()
        );

        Account savedAccount = accountRepository.save(account);

        TransactionRequest transaction = new TransactionRequest();
        transaction.setAccountNumber(request.getAccountNumber());
        transaction.setTransactionType("WITHDRAW");
        transaction.setAmount(request.getAmount());

        restTemplate.postForObject(
                "http://transaction-service:8083/api/transactions",
                transaction,
                Object.class
        );

        return savedAccount;
    }

    public String transfer(TransferRequest request) {

        if (request.getAmount() <= 0) {
            throw new RuntimeException(
                    "Transfer amount must be greater than zero");
        }

        if (request.getFromAccount()
                .equals(request.getToAccount())) {

            throw new RuntimeException(
                    "Cannot transfer to same account");
        }

        Account sender = accountRepository
                .findByAccountNumber(request.getFromAccount())
                .orElseThrow(() ->
                        new RuntimeException("Sender account not found"));

        Account receiver = accountRepository
                .findByAccountNumber(request.getToAccount())
                .orElseThrow(() ->
                        new RuntimeException("Receiver account not found"));

        if (sender.getBalance() < request.getAmount()) {
            throw new RuntimeException("Insufficient balance");
        }

        sender.setBalance(
                sender.getBalance() - request.getAmount()
        );

        receiver.setBalance(
                receiver.getBalance() + request.getAmount()
        );

        accountRepository.save(sender);
        accountRepository.save(receiver);

        TransactionRequest transaction = new TransactionRequest();
        transaction.setAccountNumber(request.getFromAccount());
        transaction.setTransactionType("TRANSFER");
        transaction.setAmount(request.getAmount());

        restTemplate.postForObject(
                "http://transaction-service:8083/api/transactions",
                transaction,
                Object.class
        );

        return "Transfer Successful";
    }
}