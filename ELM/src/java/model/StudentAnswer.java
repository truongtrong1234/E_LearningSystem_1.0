package model;

import java.util.Date;

public class StudentAnswer {
    private int answerID;
    private int accountID;
    private int questionID;
    private char selectedAnswer;
    private boolean isCorrect;
    private Date answeredAt; // ✅ Thêm thuộc tính mới

    public StudentAnswer() {}

    public StudentAnswer(int answerID, int accountID, int questionID, char selectedAnswer, boolean isCorrect, Date answeredAt) {
        this.answerID = answerID;
        this.accountID = accountID;
        this.questionID = questionID;
        this.selectedAnswer = selectedAnswer;
        this.isCorrect = isCorrect;
        this.answeredAt = answeredAt;
    }

    public int getAnswerID() { return answerID; }
    public void setAnswerID(int answerID) { this.answerID = answerID; }

    public int getAccountID() { return accountID; }
    public void setAccountID(int accountID) { this.accountID = accountID; }

    public int getQuestionID() { return questionID; }
    public void setQuestionID(int questionID) { this.questionID = questionID; }

    public char getSelectedAnswer() { return selectedAnswer; }
    public void setSelectedAnswer(char selectedAnswer) { this.selectedAnswer = selectedAnswer; }

    public boolean isCorrect() { return isCorrect; }
    public void setCorrect(boolean isCorrect) { this.isCorrect = isCorrect; }

    public Date getAnsweredAt() { return answeredAt; }
    public void setAnsweredAt(Date answeredAt) { this.answeredAt = answeredAt; }
}
