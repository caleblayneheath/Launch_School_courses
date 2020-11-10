function createStudent(name, year) {
  return {
    name,
    year,
    courses: [],
    info() {
      console.log(name + ' is a ' + year + ' year student.');
    },
    listCourses() {
      return this.courses;
    },
    addCourse(course) {
      this.courses.push(course);
    },
    addNote(code, note) {
      let course = this.getCourse(code);
      course['note'] ? course['note'] += ('; ' + note) : course['note'] = note;
    },
    updateNote(code, note) {
      let course = this.getCourse(code);
      if (course['note']) course['note'] = note;
    },
    viewNotes() {
      this.courses.forEach(course => {
        if (course.note) {
          console.log(course.name + ': ' + course.note);
        }
      });
    },
    getCourse(courseCode) {
      return this.courses.filter(({code}) => code === courseCode)[0];
    },
    getCourseByName(courseName) {
      return this.courses.filter(({name}) => name === courseName)[0];
    },
  };
}

let school = (() => {
  let students = [];
  let validYears = ['1st', '2nd', '3rd', '4th', '5th'];
  return {
    addStudent(name, year) {
      if (validYears.includes(year)) {
        let newStudent = createStudent(name, year);
        students.push(newStudent);
        return newStudent;
      } else {
        console.log('Invalid Year.')
      }
    },
    enrollStudent(name, course) {
      let student = this.getStudent(name);
      student.addCourse(course);
    },
    addGrade(name, courseCode, grade) {
      let student = this.getStudent(name);
      let course = student.getCourse(courseCode);
      course['grade'] = grade;
    },
    getReportCard(name) {
      let student = this.getStudent(name);
      if (student.courses.length > 0) {
        student.courses.forEach(({name, grade}) => {
          let displayGrade = grade;
          if (!(grade || grade === 0)) {
            displayGrade = 'In Progress';
          }

          console.log(`${name}: ${displayGrade}`);
        });
      } else {
        console.log(`${name} is not enrolled in any courses.`)
      }
    },
    courseReport(courseName) {
      let studentGrades = [];
      students.forEach(student => {
        let course = student.getCourseByName(courseName);

        if (course && (course.grade || course.grade === 0)) {
          studentGrades.push({ name: student.name, grade: course.grade, });
        }
      });

      if (studentGrades.length === 0) return;

      let average = studentGrades.map(({grade}) => grade)
        .reduce((sum, grade) => sum += grade) / studentGrades.length;

      console.log('=' + courseName + ' Grades=')
      studentGrades.forEach(({name, grade,}) => console.log(name + ': ' + grade));
      console.log('---');
      console.log('Course Average: ' + average);
    },
    getStudent(studentName) {
      return students.filter(({name}) => name === studentName)[0];
    },
  };
})();

school.addStudent('foo', '3rd');
school.enrollStudent('foo', { name: 'Math', code: 101, });
school.addGrade('foo', 101, 95);
school.enrollStudent('foo', { name: 'Advanced Math', code: 102, });
school.addGrade('foo', 102, 90);
school.enrollStudent('foo', { name: 'Physics', code: 202, });

school.addStudent('bar', '1st');
school.enrollStudent('bar', { name: 'Math', code: 101, });
school.addGrade('bar', 101, 91);

school.addStudent('qux', '2nd');
school.enrollStudent('qux', { name: 'Math', code: 101, });
school.addGrade('qux', 101, 93);
school.enrollStudent('qux', { name: 'Advanced Math', code: 102, });
school.addGrade('qux', 102, 90);

// school.addStudent('baz', '4th');
// school.enrollStudent('baz', { name: 'Math', code: 101, });
// school.addGrade('baz', 101, 0);

// school.getReportCard('foo');
// school.getReportCard('bar');
// school.getReportCard('qux');
// school.getReportCard('baz');

school.courseReport('Math');
// school.courseReport('Advanced Math');
// school.courseReport('Physics');

school.students;



