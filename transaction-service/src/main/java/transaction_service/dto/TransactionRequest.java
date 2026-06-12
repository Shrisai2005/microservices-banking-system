package transaction_service.dto;

import lombok.Data;

@Data
public class TransactionRequest {

    private String accountNumber;
    private String transactionType;
    private Double amount;
}