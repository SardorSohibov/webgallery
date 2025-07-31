package com.example.webgallery.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.UUID;

@Getter
@Setter
@ToString
public class Image {
    private String id;
    private String url;
    private String title;
    private String description;
    private String folderId;
    private Integer size;
    private boolean deleted;
    private byte[] bytes;

    public Image(String url, String title, String description, String folderId, Integer size, byte[] bytes) {
        this.url = url;
        this.title = title;
        this.description = description;
        this.folderId = folderId;
        this.id = UUID.randomUUID().toString();
        this.size = size;
        this.deleted = false;
        this.bytes = bytes;
    }

    public Image() {

    }
}
