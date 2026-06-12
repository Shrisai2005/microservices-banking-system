package transaction_service.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import transaction_service.dto.TransactionRequest;
import transaction_service.entity.Transaction;
import transaction_service.repository.TransactionRepository;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class TransactionService {

    private final TransactionRepository repository;

    public Transaction saveTransaction(
            TransactionRequest request) {

        Transaction transaction =
                Transaction.builder()
                        .accountNumber(
                                request.getAccountNumber())
                        .transactionType(
                                request.getTransactionType())
                        .amount(request.getAmount())
                        .transactionTime(
                                LocalDateTime.now())
                        .build();

        return repository.save(transaction);
    }

    public List<Transaction> getTransactions(
            String accountNumber) {

        return repository.findByAccountNumber(
                accountNumber);
    }
}