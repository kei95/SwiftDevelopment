package com.example.musicdatabase;

import android.support.annotation.NonNull;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Toast;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.FirebaseApp;
import com.google.firebase.firestore.CollectionReference;
import com.google.firebase.firestore.DocumentReference;
import com.google.firebase.firestore.DocumentSnapshot;
import com.google.firebase.firestore.EventListener;
import com.google.firebase.firestore.FirebaseFirestore;
import com.google.firebase.firestore.FirebaseFirestoreException;
import com.google.firebase.firestore.ListenerRegistration;
import com.google.firebase.firestore.QuerySnapshot;
import com.google.firebase.firestore.Transaction;

import java.util.ArrayList;

import javax.annotation.Nullable;

public class MainActivity extends AppCompatActivity implements OnLongClickListenerDelegate {
    private RecyclerView mArtistRecyclerView;
    private ArtistAdapter mArtistAdapter;
    private EditText mNameEditText;
    private Spinner mGenereSpinner;
    private FirebaseFirestore db = FirebaseFirestore.getInstance();
    private ListenerRegistration mListenerRegistration;


    private ArrayList<Artist> mArtistArrayList;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        mArtistRecyclerView = findViewById(R.id.recyclerView);
        mNameEditText = findViewById(R.id.nameEditText);
        mGenereSpinner = findViewById(R.id.genereSpiner);
        mArtistRecyclerView.setLayoutManager(new LinearLayoutManager(this));
    }

    @Override
    protected void onStart() {
        super.onStart();
        mListenerRegistration =  db.collection("artists")
                .addSnapshotListener(new EventListener<QuerySnapshot>() {
                    @Override
                    public void onEvent(@Nullable QuerySnapshot queryDocumentSnapshots, @Nullable FirebaseFirestoreException e) {
                        mArtistArrayList = new ArrayList<>();
                        for(DocumentSnapshot documentSnapshot: queryDocumentSnapshots.getDocuments()){
                            Artist artist = documentSnapshot.toObject(Artist.class);
                            artist.setId(documentSnapshot.getId());
                            mArtistArrayList.add(artist);
                        }
                        mArtistAdapter = new ArtistAdapter(getApplicationContext(), mArtistArrayList, MainActivity.this);
                        mArtistRecyclerView.setAdapter(mArtistAdapter);
                    }
                });
    }

    @Override
    protected void onStop() {
        super.onStop();
        mListenerRegistration.remove();
    }

    public void addArtist(View view) {

        final String name = mNameEditText.getText().toString().trim();
        String genre = mGenereSpinner.getSelectedItem().toString();
        if(!TextUtils.isEmpty(name)){
        Artist artist = new Artist(name, genre);
        mArtistArrayList.add(artist);
       // mArtistAdapter.notifyDataSetChanged();
        db.collection("artists")
                .add(artist)
                .addOnSuccessListener(new OnSuccessListener<DocumentReference>() {
                    @Override
                    public void onSuccess(DocumentReference documentReference) {
                        Snackbar.make(findViewById(R.id.coordinatorLayout),
                                name + "Successfully added",
                                Snackbar.LENGTH_LONG).show();
                        mNameEditText.setText("");
                        mNameEditText.clearFocus();
                    }
                }).addOnFailureListener(new OnFailureListener() {
            @Override
            public void onFailure(@NonNull Exception e) {

            }
        });


        } else{
            Snackbar.make(findViewById(R.id.coordinatorLayout), "Please set the artist name", Snackbar.LENGTH_LONG).show();

        }


    }

    @Override
    public void onLongClickViewHolder(View view, int position) {
        showAlertDialog(position);
    }

    private void showAlertDialog(int position){
        final Artist artist = mArtistArrayList.get(position);

        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        View dialogView = LayoutInflater
                .from(this)
                .inflate(R.layout.artistedit_dialog, null);
        builder.setView(dialogView);

        final EditText nameET = dialogView.findViewById(R.id.dialogNameEditText);
        nameET.setText(artist.getName());

        final Spinner spinner = dialogView.findViewById(R.id.dialogSpinner);
        spinner.setSelection(getIndexForGenre(artist.getGenere()));

        Button updateButton = dialogView.findViewById(R.id.dialogUpdateButton);
        Button deleteButton = dialogView.findViewById(R.id.dialogDeleteButton);

        builder.setTitle("Update " + artist.getName());
        final AlertDialog alertDialog = builder.create();
        alertDialog.show();

        updateButton.setOnClickListener(new View.OnClickListener(){

            @Override
            public void onClick(View v) {
                String newArtistName = nameET.getText().toString().trim();
                String newGenre = spinner.getSelectedItem().toString();

                if(TextUtils.isEmpty(newArtistName)){
                    nameET.setError("Artist Name Required");
                    return;
                }
                updateArtist(newArtistName, newGenre, artist.getId());
                alertDialog.dismiss();
            }
        });

        deleteButton.setOnClickListener(new View.OnClickListener(){

            @Override
            public void onClick(View v) {
                deletArtist(artist.getId());
                alertDialog.dismiss();
            }
        });
    }

    private void updateArtist(final String Name, final String genre, String id){
        final DocumentReference documentRef = db.collection("artists").document(id);
        db.runTransaction(new Transaction.Function<Void>() {
            @android.support.annotation.Nullable
            @Override
            public Void apply(@NonNull Transaction transaction) throws FirebaseFirestoreException {
                transaction.set(documentRef, new Artist(Name, genre));
                return null;
            }
        });

    }

    private void deletArtist(String id){
        CollectionReference artistRef = db.collection("artists");

        artistRef.document(id)
                .delete()
                .addOnSuccessListener(new OnSuccessListener<Void>() {
                    @Override
                    public void onSuccess(Void aVoid) {

                    }
                })
                .addOnFailureListener(new OnFailureListener() {
            @Override
            public void onFailure(@NonNull Exception e) {

            }
        });
    }

    private int getIndexForGenre(String genere){
        switch (genere){
            case "Hip-Hop":
                return 0;
            case "R and B":
                return 1;
            case "Pop":
                return 2;
            case "Rock":
                return 3;
            case "EDM":
                return 4;
            case "Classival":
                return 5;
            default:
                return 0;
        }
    }

    @Override
    public void onPointerCaptureChanged(boolean hasCapture) {

    }
}