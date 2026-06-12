package transaction_service.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import transaction_service.dto.TransactionRequest;
import transaction_service.entity.Transaction;
import transaction_service.service.TransactionService;

import java.util.List;

@RestController
@RequestMapping("/api/transactions")
@RequiredArgsConstructor
public class TransactionController {

    private final TransactionService service;

    @PostMapping
    public Transaction saveTransaction(
            @RequestBody TransactionRequest request) {

        return service.saveTransaction(request);
    }

    @GetMapping("/{accountNumber}")
    public List<Transaction> getTransactions(
            @PathVariable String accountNumber) {

        return service.getTransactions(accountNumber);
    }
}