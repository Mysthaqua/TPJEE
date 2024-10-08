package tibo.jee.tpjee.entity;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Data
@NoArgsConstructor
@Builder
public class Patient {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    protected int id;
    protected String firstName;
    protected String lastName;
    protected LocalDate birthDate;
    protected String phone;
    protected String photo;
    @Enumerated(EnumType.STRING)
    protected Gender gender;
    @OneToMany(mappedBy = "patient", fetch = FetchType.EAGER)
    protected List<Consultation> consultations;

    public Patient(int id, String firstName, String lastName, LocalDate birthDate, String phone, String photo, Gender gender, List<Consultation> consultations) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.birthDate = birthDate;
        this.phone = phone;
        this.gender = gender;
        this.photo = photo != null ? photo : gender == Gender.MALE ? "images/patients/defaultImages/m-default.png" : gender == Gender.FEMALE ? "images/defaultImages/f-default.png" : "images/defaultImages/o-default.png";
        this.consultations = consultations != null ? consultations : new ArrayList<>();
    }

    public enum Gender {
        MALE, FEMALE, OTHER
    }
}
