-- ====================================
-- 10.10.2025 (ver4)
-- E-LEARNING DATABASE (Udemy-style, FIXED)

USE ElearningDB10;
GO

-- =========================
-- ACCOUNTS
-- =========================
CREATE TABLE Accounts (
    AccountID INT IDENTITY(1,1) PRIMARY KEY,
    email NVARCHAR(255) UNIQUE NOT NULL,
    password NVARCHAR(255) NULL,               -- null nếu đăng nhập bằng Google
    name NVARCHAR(255) NULL,
    picture NVARCHAR(500) NULL,
	role NVARCHAR(20) CHECK (role IN ('learner','instructor','admin')),  

);

-- =========================
-- COURSES
-- =========================

CREATE TABLE [dbo].[Category](
    [CategoryID] INT IDENTITY(1,1) PRIMARY KEY,
    [Name] NVARCHAR(100) NOT NULL
);
CREATE TABLE [dbo].[Courses](
    [CourseID] INT IDENTITY(1,1) PRIMARY KEY,
    [Title] NVARCHAR(200) NOT NULL,
    [Description] NVARCHAR(MAX),
    [InstructorID] INT NOT NULL,
    [CategoryID] INT NOT NULL,
    [Price] DECIMAL(10,2) CHECK (Price >= 0) DEFAULT 0,
    [Thumbnail] VARBINARY(MAX) NULL,

    FOREIGN KEY (InstructorID) REFERENCES Accounts(AccountID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

-- =========================
-- CHAPTERS
-- =========================
CREATE TABLE Chapters (
    ChapterID INT IDENTITY PRIMARY KEY,
    CourseID INT NOT NULL,
    Title NVARCHAR(200) NOT NULL,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE
);

-- =========================
-- LESSONS
-- =========================
CREATE TABLE Lessons (
    LessonID INT IDENTITY (1,1) PRIMARY KEY,
    ChapterID INT NOT NULL,
    Title NVARCHAR(200) NOT NULL,
    FOREIGN KEY (ChapterID) REFERENCES Chapters(ChapterID) ON DELETE CASCADE
);
-- =========================
-- MATERIALS
-- =========================
CREATE TABLE Materials (
    MaterialID INT IDENTITY PRIMARY KEY,
    LessonID INT NOT NULL,
    Title NVARCHAR(200) NOT NULL,
    ContentURL NVARCHAR(500),
    MaterialType NVARCHAR(50) CHECK (MaterialType IN ('Video','PDF','Slide','Other')),
    FOREIGN KEY (LessonID) REFERENCES Lessons(LessonID) ON DELETE CASCADE
);

-- =========================
-- ENROLLMENTS
-- =========================
CREATE TABLE Enrollments (
    EnrollmentID INT IDENTITY PRIMARY KEY,
    AccountID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrolledAt DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(20) DEFAULT 'Active',
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    UNIQUE(AccountID, CourseID)
);

-- =========================
-- PAYMENTS
-- =========================
CREATE TABLE Payments (
    PaymentID INT IDENTITY PRIMARY KEY,
    EnrollmentID INT NOT NULL,
    Amount DECIMAL(10,2) CHECK (Amount >= 0) NOT NULL,
    Status NVARCHAR(20) CHECK (Status IN ('Pending','Success','Failed','Refunded')) DEFAULT 'Pending',
    TransactionID NVARCHAR(100) UNIQUE NULL,
    PaidAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (EnrollmentID) REFERENCES Enrollments(EnrollmentID)
);

-- =========================
-- QUIZZES
-- =========================
CREATE TABLE Quizzes (
    QuizID INT IDENTITY PRIMARY KEY,
    LessonID INT NOT NULL,
    Title NVARCHAR(200) NOT NULL,
    FOREIGN KEY (LessonID) REFERENCES Lessons(LessonID)
);
CREATE TABLE Questions (
    QuestionID INT IDENTITY (1,1) PRIMARY KEY,
    QuizID INT NOT NULL,
    QuestionContent NVARCHAR(MAX) NOT NULL,
    OptionA NVARCHAR(255) NOT NULL,
    OptionB NVARCHAR(255) NOT NULL,
    OptionC NVARCHAR(255) NOT NULL,
    OptionD NVARCHAR(255) NOT NULL,
    CorrectAnswer CHAR(1) CHECK (CorrectAnswer IN ('A','B','C','D')) NOT NULL,
    FOREIGN KEY (QuizID) REFERENCES Quizzes(QuizID)
);
CREATE TABLE StudentAnswers (
    AnswerID INT IDENTITY PRIMARY KEY,
    AccountID INT NOT NULL,
    QuestionID INT NOT NULL,
    SelectedAnswer CHAR(1) CHECK (SelectedAnswer IN ('A','B','C','D')),
    IsCorrect BIT default 1 ,
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID),
    FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID)

);

-- =========================
-- PROGRESS TRACKING
-- =========================
CREATE TABLE LessonProgress (
    LessonProgressID INT IDENTITY PRIMARY KEY,
    EnrollmentID INT NOT NULL,
    LessonID INT NOT NULL,
    IsCompleted BIT DEFAULT 0,
    CompletedAt DATETIME NULL,
    FOREIGN KEY (EnrollmentID) REFERENCES Enrollments(EnrollmentID) ON DELETE CASCADE,
    FOREIGN KEY (LessonID) REFERENCES Lessons(LessonID) ON DELETE CASCADE,
    UNIQUE(EnrollmentID, LessonID)
);

CREATE TABLE CourseProgress (
    ProgressID INT IDENTITY PRIMARY KEY,
    EnrollmentID INT NOT NULL,
    CompletedPercent DECIMAL(5,2) DEFAULT 0,
    LastAccess DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (EnrollmentID) REFERENCES Enrollments(EnrollmentID) ON DELETE CASCADE,
    UNIQUE(EnrollmentID)
);
CREATE TABLE QuizProgress (
    ProgressID INT IDENTITY PRIMARY KEY,
    AccountID INT NOT NULL,
    QuizID INT NOT NULL,
    CorrectCount INT DEFAULT 0,       -- số câu đúng
    TotalScore DECIMAL(5,2) DEFAULT 0, -- điểm hiện tại
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID),
    FOREIGN KEY (QuizID) REFERENCES Quizzes(QuizID)
);
-- =========================
-- NOTIFICATIONS
-- =========================
CREATE TABLE Notifications (
    NotificationID INT IDENTITY PRIMARY KEY,
    AccountID INT NOT NULL,
    Type NVARCHAR(50) 
        CHECK (Type IN ('System', 'Email', 'CourseUpdate', 'Payment', 'Reminder')) 
        DEFAULT 'System',
    Title NVARCHAR(200) NOT NULL,
    Message NVARCHAR(1000) NOT NULL,
    IsRead BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

-- =========================
-- SAMPLE DATA
-- =========================
