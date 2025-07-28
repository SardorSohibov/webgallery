package com.example.webgallery.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.UUID;

@Getter
@Setter
@ToString
public class Folder {
    private String id;
    private String folderName;
    private String ownerId;
    private boolean deleted;

    public Folder(String folderName, String ownerId) {
        this.folderName = folderName;
        this.ownerId = ownerId;
        this.id = UUID.randomUUID().toString();
        this.deleted = false;
    }

    public Folder() {

    }

}
