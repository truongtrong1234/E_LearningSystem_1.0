-- ====================================
-- 10.10.2025 (ver4)
-- E-LEARNING DATABASE (Udemy-style, FIXED)
-- ====================================

CREATE DATABASE ElearningDB9;
GO
USE ElearningDB9;
GO

-- =========================
-- ACCOUNTS
-- =========================
CREATE TABLE Accounts (
    AccountID INT IDENTITY PRIMARY KEY,
    FullName NVARCHAR(100) NULL,            -- tên người dùng (Local có thể nhập, External tự lấy)
    Email NVARCHAR(200) NOT NULL UNIQUE,    -- luôn có email
    Provider NVARCHAR(50) 
        CHECK (Provider IN ('Local', 'Google', 'Facebook', 'Microsoft')) 
        NOT NULL DEFAULT 'Local',           -- nguồn đăng nhập
    ProviderUserID NVARCHAR(200) NULL,      -- id tài khoản bên thứ 3
    IsVerified BIT DEFAULT 0,               -- true nếu user đã xác thực mail
    Role NVARCHAR(20) 
        CHECK (Role IN ('Student', 'Instructor', 'Admin')) 
        NOT NULL DEFAULT 'Student',
    IsActive BIT DEFAULT 1,
    LastLogin DATETIME NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- =========================
-- COURSES
-- =========================
CREATE TABLE Courses (
    CourseID INT IDENTITY PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX),
    InstructorID INT NOT NULL,
    Price DECIMAL(10,2) CHECK (Price >= 0) DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (InstructorID) REFERENCES Accounts(AccountID)
);

-- =========================
-- CHAPTERS
-- =========================
CREATE TABLE Chapters (
    ChapterID INT IDENTITY PRIMARY KEY,
    CourseID INT NOT NULL,
    Title NVARCHAR(200) NOT NULL,
    OrderIndex INT DEFAULT 1,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE
);

-- =========================
-- LESSONS
-- =========================
CREATE TABLE Lessons (
    LessonID INT IDENTITY PRIMARY KEY,
    ChapterID INT NOT NULL,
    Title NVARCHAR(200) NOT NULL,
    OrderIndex INT DEFAULT 1,
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
    CreatedAt DATETIME DEFAULT GETDATE(),
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
    Method NVARCHAR(50) CHECK (Method IN ('Momo','CreditCard','BankTransfer')) NOT NULL DEFAULT 'Momo',
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
    QuestionID INT IDENTITY PRIMARY KEY,
    QuizID INT NOT NULL,
    QuestionText NVARCHAR(MAX) NOT NULL,
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
    IsCorrect BIT,
    AnsweredAt DATETIME DEFAULT GETDATE(),
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

INSERT INTO Accounts (FullName, Email, Provider, ProviderUserID, Role, IsVerified)
VALUES
(N'John Doe', 'john@student.com', 'Local', NULL, 'Student', 1),
(N'Jane Smith', 'jane@student.com', 'Local', NULL, 'Student', 1),
(N'Mr. Brown', 'brown@instructor.com', 'Google', 'G123', 'Instructor', 1),
(N'Admin', 'admin@elearning.com', 'Facebook', 'F321', 'Admin', 1);

INSERT INTO Courses (Title, Description, InstructorID, Price)
VALUES (N'Java Programming', N'Learn Java step-by-step', 3, 120.00);

INSERT INTO Chapters (CourseID, Title, OrderIndex)
VALUES (1, N'Introduction to Java', 1),
       (1, N'OOP Basics', 2);

INSERT INTO Lessons (ChapterID, Title, OrderIndex)
VALUES (1, N'What is Java?', 1),
       (1, N'Setup JDK', 2),
       (2, N'Understanding Classes', 1),
       (2, N'Inheritance in Java', 2);

INSERT INTO Materials (LessonID, Title, ContentURL, MaterialType)
VALUES
(1, N'Java Overview Video', 'http://example.com/java-overview.mp4', 'Video'),
(3, N'OOP Concepts PDF', 'http://example.com/oop.pdf', 'PDF');

INSERT INTO Enrollments (AccountID, CourseID)
VALUES (1, 1);

INSERT INTO Payments (EnrollmentID, Amount, Method, Status, TransactionID)
VALUES (1, 120.00, 'Momo', 'Success', 'TXN1001');

INSERT INTO CourseProgress (EnrollmentID, CompletedPercent)
VALUES (1, 25.0);

INSERT INTO LessonProgress (EnrollmentID, LessonID, IsCompleted)
VALUES (1, 1, 1);

INSERT INTO Notifications (AccountID, Type, Title, Message)
VALUES 
(1, 'System', N'Welcome', N'Welcome to Java Programming!'),
(1, 'CourseUpdate', N'New Lesson Added', N'A new lesson has been added to your Java course.');

INSERT INTO Quizzes (LessonID, Title)
VALUES (1, N'Java Basics Quiz');

INSERT INTO Questions (QuizID, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectAnswer)
VALUES
(1, N'What does JVM stand for?', N'Java Virtual Machine', N'Java Version Manager', N'Java Verified Mode', N'Just Virtual Memory', 'A'),
(1, N'Which keyword is used for inheritance?', N'implements', N'import', N'extends', N'include', 'C');

INSERT INTO StudentAnswers (AccountID, QuestionID, SelectedAnswer, IsCorrect)
VALUES
(1, 1, 'A', 1),
(1, 2, 'C', 1);
