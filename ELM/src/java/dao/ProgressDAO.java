package dao;

import context.DBContext;
import java.sql.*;

public class ProgressDAO extends DBContext {

    public void initializeProgress(int enrollmentID, int courseID) {
        try {
            connection.setAutoCommit(false);

            // 🟢 CourseProgress
            PreparedStatement psCourse = connection.prepareStatement(
                "INSERT INTO CourseProgress (EnrollmentID, CourseID, IsCompleted) VALUES (?, ?, 0)"
            );
            psCourse.setInt(1, enrollmentID);
            psCourse.setInt(2, courseID);
            psCourse.executeUpdate();

            // 🟢 ChapterProgress
            String sqlChapters = "SELECT ChapterID FROM Chapters WHERE CourseID = ?";
            PreparedStatement psGetChapters = connection.prepareStatement(sqlChapters);
            psGetChapters.setInt(1, courseID);
            ResultSet rsChapters = psGetChapters.executeQuery();

            PreparedStatement psChapter = connection.prepareStatement(
                "INSERT INTO ChapterProgress (EnrollmentID, ChapterID, IsCompleted) VALUES (?, ?, 0)"
            );
            PreparedStatement psLesson = connection.prepareStatement(
                "INSERT INTO LessonProgress (EnrollmentID, LessonID, IsCompleted) VALUES (?, ?, 0)"
            );

            while (rsChapters.next()) {
                int chapterID = rsChapters.getInt("ChapterID");

                // Insert chapter progress
                psChapter.setInt(1, enrollmentID);
                psChapter.setInt(2, chapterID);
                psChapter.executeUpdate();

                // 🟢 LessonProgress cho mỗi bài
                String sqlLessons = "SELECT LessonID FROM Lessons WHERE ChapterID = ?";
                PreparedStatement psGetLessons = connection.prepareStatement(sqlLessons);
                psGetLessons.setInt(1, chapterID);
                ResultSet rsLessons = psGetLessons.executeQuery();

                while (rsLessons.next()) {
                    int lessonID = rsLessons.getInt("LessonID");
                    psLesson.setInt(1, enrollmentID);
                    psLesson.setInt(2, lessonID);
                    psLesson.executeUpdate();
                }
            }

            connection.commit();
        } catch (SQLException e) {
            e.printStackTrace();
            try { connection.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
        } finally {
            try { connection.setAutoCommit(true); } catch (SQLException ex) { ex.printStackTrace(); }
        }
    }
}
