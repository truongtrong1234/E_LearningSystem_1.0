package model;

import java.math.BigDecimal;
import java.util.Date;

public class QuizProgress {
    private int progressID;
    private int accountID;
    private int quizID;
    private Integer correctCount;
    private BigDecimal totalScore;
    private Date takenDate;

    public QuizProgress() {}

    public QuizProgress(int progressID, int accountID, int quizID, Integer correctCount,
                        BigDecimal totalScore, Date takenDate) {
        this.progressID = progressID;
        this.accountID = accountID;
        this.quizID = quizID;
        this.correctCount = correctCount;
        this.totalScore = totalScore;
        this.takenDate = takenDate;
    }

    public int getProgressID() { return progressID; }
    public void setProgressID(int progressID) { this.progressID = progressID; }

    public int getAccountID() { return accountID; }
    public void setAccountID(int accountID) { this.accountID = accountID; }

    public int getQuizID() { return quizID; }
    public void setQuizID(int quizID) { this.quizID = quizID; }

    public Integer getCorrectCount() { return correctCount; }
    public void setCorrectCount(Integer correctCount) { this.correctCount = correctCount; }

    public BigDecimal getTotalScore() { return totalScore; }
    public void setTotalScore(BigDecimal totalScore) { this.totalScore = totalScore; }

    public Date getTakenDate() { return takenDate; }
    public void setTakenDate(Date takenDate) { this.takenDate = takenDate; }
}
