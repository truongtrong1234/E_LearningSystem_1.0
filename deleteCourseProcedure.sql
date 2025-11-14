CREATE PROCEDURE deleteCourse
    @CourseID INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1️⃣ Xóa QnAReply → QnAQuestion
        DELETE QR
        FROM QnAReply QR
        INNER JOIN QnAQuestion Q ON QR.QnAID = Q.QnAID
        WHERE Q.CourseID = @CourseID;

        DELETE FROM QnAQuestion
        WHERE CourseID = @CourseID;

        -- 2️⃣ Xóa StudentAnswers liên quan đến Questions của Quizzes
        DELETE SA
        FROM StudentAnswers SA
        INNER JOIN Questions Q ON SA.QuestionID = Q.QuestionID
        INNER JOIN Quizzes Qu ON Q.QuizID = Qu.QuizID
        INNER JOIN Chapters C ON Qu.ChapterID = C.ChapterID
        WHERE C.CourseID = @CourseID;

        -- 3️⃣ Xóa Questions → Quizzes
        DELETE Q
        FROM Questions Q
        INNER JOIN Quizzes Qu ON Q.QuizID = Qu.QuizID
        INNER JOIN Chapters C ON Qu.ChapterID = C.ChapterID
        WHERE C.CourseID = @CourseID;

        DELETE Qu
        FROM Quizzes Qu
        INNER JOIN Chapters C ON Qu.ChapterID = C.ChapterID
        WHERE C.CourseID = @CourseID;

        -- 4️⃣ Xóa MaterialProgress → Materials
        DELETE MP
        FROM MaterialProgress MP
        INNER JOIN Materials M ON MP.MaterialID = M.MaterialID
        INNER JOIN Lessons L ON M.LessonID = L.LessonID
        INNER JOIN Chapters C ON L.ChapterID = C.ChapterID
        WHERE C.CourseID = @CourseID;

        -- 5️⃣ Xóa LessonProgress → Lessons
        DELETE LP
        FROM LessonProgress LP
        INNER JOIN Lessons L ON LP.LessonID = L.LessonID
        INNER JOIN Chapters C ON L.ChapterID = C.ChapterID
        WHERE C.CourseID = @CourseID;

        -- 6️⃣ Xóa ChapterProgress
        DELETE CP
        FROM ChapterProgress CP
        INNER JOIN Chapters C ON CP.ChapterID = C.ChapterID
        WHERE C.CourseID = @CourseID;

        -- 7️⃣ Xóa CourseProgress → Enrollments
        DELETE CP
        FROM CourseProgress CP
        INNER JOIN Enrollments E ON CP.EnrollmentID = E.EnrollmentID
        WHERE E.CourseID = @CourseID;

        -- 8️⃣ Xóa Payments → Enrollments
        DELETE P
        FROM Payments P
        INNER JOIN Enrollments E ON P.EnrollmentID = E.EnrollmentID
        WHERE E.CourseID = @CourseID;

        -- 9️⃣ Xóa Enrollments
        DELETE FROM Enrollments
        WHERE CourseID = @CourseID;

        -- 10️⃣ Xóa Notifications liên quan đến course (nếu có)
        DELETE N
        FROM Notifications N
        INNER JOIN Courses C ON N.AccountID = C.InstructorID
        WHERE C.CourseID = @CourseID;

        -- 11️⃣ Xóa Reports → ReportReplies
        DELETE RR
        FROM ReportReplies RR
        INNER JOIN Reports R ON RR.ReportID = R.ReportID
        WHERE R.AccountID IN (
            SELECT InstructorID FROM Courses WHERE CourseID = @CourseID
        );

        DELETE R
        FROM Reports R
        WHERE R.AccountID IN (SELECT InstructorID FROM Courses WHERE CourseID = @CourseID
        );

        -- 12️⃣ Xóa Chapters, Lessons, Materials
        -- ✅ Bạn đã có cascade delete, nhưng xóa thủ công cũng ok
        DELETE M
        FROM Materials M
        INNER JOIN Lessons L ON M.LessonID = L.LessonID
        INNER JOIN Chapters C ON L.ChapterID = C.ChapterID
        WHERE C.CourseID = @CourseID;

        DELETE L
        FROM Lessons L
        INNER JOIN Chapters C ON L.ChapterID = C.ChapterID
        WHERE C.CourseID = @CourseID;

        DELETE FROM Chapters
        WHERE CourseID = @CourseID;

        -- 13️⃣ Cuối cùng xóa Course
        DELETE FROM Courses
        WHERE CourseID = @CourseID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

CREATE PROCEDURE deleteChapter
    @ChapterID INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1️⃣ Xóa Quizzes và các bảng con
        DELETE SA
        FROM StudentAnswers SA
        INNER JOIN Questions Q ON SA.QuestionID = Q.QuestionID
        INNER JOIN Quizzes Qu ON Q.QuizID = Qu.QuizID
        WHERE Qu.ChapterID = @ChapterID;

        DELETE FROM Questions
        WHERE QuizID IN (SELECT QuizID FROM Quizzes WHERE ChapterID = @ChapterID);

        DELETE FROM Quizzes
        WHERE ChapterID = @ChapterID;

        -- 2️⃣ Xóa Lessons và Materials
        DELETE MP
        FROM MaterialProgress MP
        INNER JOIN Materials M ON MP.MaterialID = M.MaterialID
        INNER JOIN Lessons L ON M.LessonID = L.LessonID
        WHERE L.ChapterID = @ChapterID;

        DELETE FROM LessonProgress
        WHERE LessonID IN (SELECT LessonID FROM Lessons WHERE ChapterID = @ChapterID);

        DELETE FROM Materials
        WHERE LessonID IN (SELECT LessonID FROM Lessons WHERE ChapterID = @ChapterID);

        DELETE FROM Lessons
        WHERE ChapterID = @ChapterID;

        -- 3️⃣ Cuối cùng xóa Chapter
        DELETE FROM Chapters
        WHERE ChapterID = @ChapterID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO



CREATE PROCEDURE deleteQuiz
    @QuizID INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1️⃣ Xóa StudentAnswers của Quiz này
        DELETE SA
        FROM StudentAnswers SA
        INNER JOIN Questions Q ON SA.QuestionID = Q.QuestionID
        WHERE Q.QuizID = @QuizID;

        -- 2️⃣ Xóa Questions
        DELETE FROM Questions
        WHERE QuizID = @QuizID;

        -- 3️⃣ Cuối cùng xóa Quiz
        DELETE FROM Quizzes
        WHERE QuizID = @QuizID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

CREATE PROCEDURE deleteQuestion  
    @QuestionID INT  
AS  
BEGIN  
    SET NOCOUNT ON;  
  
    BEGIN TRY  
        BEGIN TRANSACTION;  
  
        -- 1️⃣ Xóa StudentAnswers  
        DELETE FROM StudentAnswers  
        WHERE QuestionID = @QuestionID;  
  
        -- 2️⃣ Xóa Question  
        DELETE FROM Questions  
        WHERE QuestionID = @QuestionID;  
  
        COMMIT TRANSACTION;  
    END TRY  
    BEGIN CATCH  
        ROLLBACK TRANSACTION;  
        THROW;  
    END CATCH  
END;  