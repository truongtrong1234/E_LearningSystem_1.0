package model;

public class StudentAnswer {
    private int answerID;
    private int accountID;
    private int questionID;
    private char selectedAnswer;
    private boolean isCorrect;

    public StudentAnswer() {}

    public StudentAnswer(int answerID, int accountID, int questionID, char selectedAnswer, boolean isCorrect) {
        this.answerID = answerID;
        this.accountID = accountID;
        this.questionID = questionID;
        this.selectedAnswer = selectedAnswer;
        this.isCorrect = isCorrect;
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
    public void setCorrect(boolean correct) { isCorrect = correct; }
}
