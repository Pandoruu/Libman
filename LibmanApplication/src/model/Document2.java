package model;

import java.io.Serializable;

public class Document2 implements Serializable {
    private int id;
    private String name;
    private String author;
    private String publisher;
    private String category;

    public Document2() {
        super();
    }

    public Document2(String name, String author, String publisher, String category) {
        super();
        this.name = name;
        this.author = author;
        this.publisher = publisher;
        this.category = category;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
}
