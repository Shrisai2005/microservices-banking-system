package account_service.dto;

import lombok.Data;

@Data
public class CreateAccountRequest {

    private String accountType;
    private String userEmail;
}