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
      /*
      use code to get correct course
        get index of course using code
        get course using index
      see if note property exists for course
      if yes, append note to current note
      if no, course[note] = note;
      */
//       let index = this.getCourseIndex(code);

//       if (index === -1) return;

//       let course = this.getCourse(index);
      let course = this.getCourse(code);
      
      course['note'] ? course['note'] += ('; ' + note) : course['note'] = note;
    },
    updateNote(code, note) {
//       let index = this.getCourseIndex(code);

//       if (index === -1) return;

//       let course = this.getCourse(index);
      let course = this.getCourse(code);
      if (course['note']) course['note'] = note;
    },
    viewNotes() {
      // if course has notes, print course name: note
      this.courses.forEach(course => {
        if (course.note) {
          console.log(course.name + ': ' + course.note);
        }
      });
    },
    getCourseIndex(code) {
      let index = -1;
      this.courses.forEach((course, idx) => {
        if (course['code'] === code) index = idx;
      });
      return index;
    },
//     getCourse(index) {
//       return this.courses[index];
//     },
    getCourse(courseCode) {
        return this.courses.filter(({code}) => code === courseCode)[0];
    },
  };
}

foo = createStudent('Foo', '1st');
foo.info();
foo.addCourse({name: 'Math', code: 101 });
foo.addCourse({name: 'Advanced Math', code: 102 });
foo.listCourses();
foo.addNote(101, 'Fun course');
foo.addNote(101, 'Remember to study for algebra');
foo.addNote(102, 'Difficult subject');
foo.viewNotes();
foo.updateNote(101, 'Fun course');
foo.viewNotes();
