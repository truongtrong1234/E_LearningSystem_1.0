package model;

public class MaterialProgress {
    private int materialProgressID;
    private int enrollmentID;
    private int materialID;
    private boolean isCompleted;

    public MaterialProgress() {}

    public MaterialProgress(int materialProgressID, int enrollmentID, int materialID, boolean isCompleted) {
        this.materialProgressID = materialProgressID;
        this.enrollmentID = enrollmentID;
        this.materialID = materialID;
        this.isCompleted = isCompleted;
    }

    public int getMaterialProgressID() { return materialProgressID; }
    public void setMaterialProgressID(int materialProgressID) { this.materialProgressID = materialProgressID; }

    public int getEnrollmentID() { return enrollmentID; }
    public void setEnrollmentID(int enrollmentID) { this.enrollmentID = enrollmentID; }

    public int getMaterialID() { return materialID; }
    public void setMaterialID(int materialID) { this.materialID = materialID; }

    public boolean isCompleted() { return isCompleted; }
    public void setCompleted(boolean completed) { isCompleted = completed; }
}
