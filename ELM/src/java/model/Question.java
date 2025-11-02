package model;

public class Question {
    private int questionID;
    private int quizID;
    private String questionText;
    private String optionA, optionB, optionC, optionD;
    private String correctAnswer;

    public Question() {}

    public Question(int questionID, int quizID, String questionText, String optionA,
                    String optionB, String optionC, String optionD, String correctAnswer) {
        this.questionID = questionID;
        this.quizID = quizID;
        this.questionText = questionText;
        this.optionA = optionA;
        this.optionB = optionB;
        this.optionC = optionC;
        this.optionD = optionD;
        this.correctAnswer = correctAnswer;
    }

    // getters & setters
    public int getQuestionID() { return questionID; }
    public int getQuizID() { return quizID; }
    public String getQuestionText() { return questionText; }
    public String getOptionA() { return optionA; }
    public String getOptionB() { return optionB; }
    public String getOptionC() { return optionC; }
    public String getOptionD() { return optionD; }
    public String getCorrectAnswer() { return correctAnswer; }

    public void setQuestionID(int id) { this.questionID = id; }
    public void setQuizID(int id) { this.quizID = id; }
    public void setQuestionText(String text) { this.questionText = text; }
    public void setOptionA(String s) { this.optionA = s; }
    public void setOptionB(String s) { this.optionB = s; }
    public void setOptionC(String s) { this.optionC = s; }
    public void setOptionD(String s) { this.optionD = s; }
    public void setCorrectAnswer(String s) { this.correctAnswer = s; }
}
