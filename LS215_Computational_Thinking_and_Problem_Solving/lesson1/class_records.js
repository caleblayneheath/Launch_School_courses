let studentScores = {
  student1: {
    id: 123456789,
    scores: {
      exams: [90, 95, 100, 80],
      exercises: [20, 15, 10, 19, 15],
    },
  },
  student2: {
    id: 123456799,
    scores: {
      exams: [50, 70, 90, 100],
      exercises: [0, 15, 20, 15, 15],
    },
  },
  student3: {
    id: 123457789,
    scores: {
      exams: [88, 87, 88, 89],
      exercises: [10, 20, 10, 19, 18],
    },
  },
  student4: {
    id: 112233445,
    scores: {
      exams: [100, 100, 100, 100],
      exercises: [10, 15, 10, 10, 15],
    },
  },
  student5: {
    id: 112233446,
    scores: {
      exams: [50, 80, 60, 90],
      exercises: [10, 0, 10, 10, 0],
    },
  },
};

function generateClassRecordSummary(scores) {
  // output: object with following
    // studentGrades property with value of
      // array of strings with number and letter of each students grade
    // exams property with value of
      // array of objs which are summaries of each exams
        // summary contains average to 1 decimal, minimum, maximum (low and high scores)

  // input: object with property for each student
    // each student property has value of scores object
    // scores object contains exams and exercises property (arrays of numbers)

  // transform studentScores object's key array to hold student scores only
  // transform above to another holder for exam scores only
  // return object with studentGrades array transformed to total grade
  //   and with result of exam investigation function
  let studentGrades = Object.keys(scores).map(student => scores[student]['scores']);
  let exams = studentGrades.map(grades => grades.exams);

  return {
    'studentGrades': studentGrades.map(student => getStudentScore(student)), 
    'exams': getExamSummary(exams),
  };
}

function getStudentScore(scores) {
  // determine average exam score (sum and divide by 4)
  // determine total exercise score (sum)
  // apply weights to above (set as constants? no magic numbers)
  // round grade to nearest integer
  // lookup letter grade corresponding
  // return string of grade plus letter

  const NUMBER_OF_EXAMS = 4;
  const EXAM_WEIGHT = 0.65;
  const EXERCISE_WEIGHT = 0.35;
  
  let sumPoints = (array) => array.reduce((sum, points) => sum += points);
  
  let examScore = sumPoints(scores['exams']) / NUMBER_OF_EXAMS;
  let exerciseScore = sumPoints(scores['exercises']);

  let finalScore = Math.round((examScore * EXAM_WEIGHT) + (exerciseScore * EXERCISE_WEIGHT));

  return `${finalScore} (${getLetterGrade(finalScore)})`;
}

function getLetterGrade(score) {
  let gradeCutOffs = {
    A: 93,
    B: 85,
    C: 77,
    D: 69,
    E: 60,
  };

  if (score >= gradeCutOffs['A']) {
    return 'A';
  } else if (score >= gradeCutOffs['B']) {
    return 'B';
  } else if (score >= gradeCutOffs['C']) {
    return 'C';
  } else if (score >= gradeCutOffs['D']) {
    return 'D';
  } else if (score >= gradeCutOffs['E']) {
    return 'E';
  } else {
    return 'F';
  }
}

function getExamSummary(exams) {
  // input: array of arrays, each subarray is one student's exam results
  //  each subarray is the result of exam1, examd2, etc.
  // ouput: object containing for each exam the average(to one decimal), the min, the max
  
  // assumption: every student array has the same number of elements
  // need to transpose exams
  exams = transposeArray(exams);

  return exams.map(exam => {
    return {
      average: Number(getAverage(exam).toFixed(1)),
      minimum: getMinimum(exam),
      maximum: getMaximum(exam),
    }
  });
}

function transposeArray(arr) {
  return arr[0].map((row, columnIndex) => {
    let newRow = [];
    for (let rowIndex = 0; rowIndex < arr.length; rowIndex += 1) {
      newRow.push(arr[rowIndex][columnIndex])
    }

    return newRow;
  });
}

function getAverage(arr) {
  return arr.reduce((sum, element) => sum += element) / arr.length;
}

function getMinimum(arr) {
  return arr.sort( (a, b) => a > b ? 1 : -1)[0];
}

function getMaximum(arr) {
  return arr.sort( (a, b) => a > b ? -1 : 1)[0]
}

console.log(generateClassRecordSummary(studentScores));

// returns:
// {
//   studentGrades: [ '87 (B)', '73 (D)', '84 (C)', '86 (B)', '56 (F)' ],
//   exams: [
//     { average: 75.6, minimum: 50, maximum: 100 },
//     { average: 86.4, minimum: 70, maximum: 100 },
//     { average: 87.6, minimum: 60, maximum: 100 },
//     { average: 91.8, minimum: 80, maximum: 100 },
//   ],
// }
