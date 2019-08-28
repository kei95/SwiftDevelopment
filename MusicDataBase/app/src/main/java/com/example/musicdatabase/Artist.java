package com.example.musicdatabase;

import java.util.Date;
import com.google.firebase.Timestamp;
import com.google.firebase.firestore.Exclude;

public class Artist {
    private String id;
    private String name;
    private String genere;
    private Timestamp addedDate;


    public Artist(String name, String genere){
        this.name = name;
        this.genere = genere;
        this.addedDate = new Timestamp(new Date()); //Current Time
    }

    @Exclude
    public String getId() {
        // uer @Exclude on the getter of id field to make sure
        // the id does not get sent to Firestore on save
        return id; }

    public String setId(String id) {
        return this.id = id;
    }

    public String getName() {
        return name;
    }

    public String getGenere() {
        return genere;
    }

    public Timestamp getAddedDate() {
        return addedDate;
    }
}
