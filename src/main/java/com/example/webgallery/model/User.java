package com.example.webgallery.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.UUID;

@Getter
@Setter
@ToString
public class User {
    private String username;
    private String password;
    private String id;

    public User(String username, String password) {
        this.username = username;
        this.password = password;
        this.id = UUID.randomUUID().toString();
    }

    public User() {

    }

}
