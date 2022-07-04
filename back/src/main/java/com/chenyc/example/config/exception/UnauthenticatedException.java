package com.chenyc.example.config.exception;

/**
 * @author chenyc
 * @description: 未登录的异常
 */
public class UnauthenticatedException extends RuntimeException {
    public UnauthenticatedException() {
        super("未登录");
    }
}
