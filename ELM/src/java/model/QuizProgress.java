/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.math.BigDecimal;

public class QuizProgress {
    private int progressID;
    private int accountID;
    private int quizID;
    private int correctCount;
    private BigDecimal totalScore;

    public QuizProgress() {}

    public QuizProgress(int progressID, int accountID, int quizID, int correctCount, BigDecimal totalScore) {
        this.progressID = progressID;
        this.accountID = accountID;
        this.quizID = quizID;
        this.correctCount = correctCount;
        this.totalScore = totalScore;
    }

    public int getProgressID() { return progressID; }
    public void setProgressID(int progressID) { this.progressID = progressID; }
    public int getAccountID() { return accountID; }
    public void setAccountID(int accountID) { this.accountID = accountID; }
    public int getQuizID() { return quizID; }
    public void setQuizID(int quizID) { this.quizID = quizID; }
    public int getCorrectCount() { return correctCount; }
    public void setCorrectCount(int correctCount) { this.correctCount = correctCount; }
    public BigDecimal getTotalScore() { return totalScore; }
    public void setTotalScore(BigDecimal totalScore) { this.totalScore = totalScore; }
}
