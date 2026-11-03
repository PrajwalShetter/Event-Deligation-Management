
package com.xworkz.eventDeligation.exception;

import com.xworkz.eventDeligation.dto.ResponseDto;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.util.stream.Collectors;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(DuplicateCompanyException.class)
    public ResponseEntity<ResponseDto<Void>> handleDuplicateCompany(
            DuplicateCompanyException exception) {

        ResponseDto<Void> response = new ResponseDto<>(
                false,
                exception.getMessage(),
                null
        );

        return ResponseEntity.status(HttpStatus.CONFLICT).body(response);
    }

    @ExceptionHandler(CompanyNotFoundException.class)
    public ResponseEntity<ResponseDto<Void>> handleCompanyNotFound(
            CompanyNotFoundException exception) {

        ResponseDto<Void> response = new ResponseDto<>(
                false,
                exception.getMessage(),
                null
        );

        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ResponseDto<Void>> handleValidationErrors(
            MethodArgumentNotValidException exception) {

        String message = exception.getBindingResult()
                .getFieldErrors()
                .stream()
                .map(error -> error.getField() + ": "
                        + error.getDefaultMessage())
                .collect(Collectors.joining("; "));

        ResponseDto<Void> response = new ResponseDto<>(
                false,
                message,
                null
        );

        return ResponseEntity.badRequest().body(response);
    }

    @ExceptionHandler(CompanyRegistrationException.class)
    public ResponseEntity<ResponseDto<Void>> handleRegistrationError(
            CompanyRegistrationException exception) {

        ResponseDto<Void> response = new ResponseDto<>(
                false,
                exception.getMessage(),
                null
        );

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(response);
    }
}
