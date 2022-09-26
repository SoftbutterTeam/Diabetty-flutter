const jsonfile = require("jsonfile");
const moment = require("moment");
const simpleGit = require("simple-git");

// git commit --date=""
//console.log(data);
main();

async function main() {
  initalDaysAgo = 613; // must be more than no of days
  noDaysRange = 160;
  for (
    let index = initalDaysAgo;
    index > initalDaysAgo - noDaysRange;
    index--
  ) {
    // for each day from inital day to end of range
    console.log(index);
    var nocommits;
    var chance = Math.random();
    console.log("chance " + chance);
    if (chance < 0.4) {
      // skip
      console.log("skip");
      continue;
    } else if (chance < 0.45) {
      nocommits = getRndmFromSet([11, 12, 13, 15, 16]);
    } else if (chance < 0.6) {
      nocommits = getRndmFromSet([5, 6, 7, 8, 9, 10]);
    } else {
      nocommits = getRndmFromSet([1, 2, 3, 4]);
    }

    let date = moment().subtract(index, "d").format();
    for (let index = 0; index < nocommits; index++) {
      console.log("write " + index);

      await writeFile(date);
    }
  }
}

function getRndmFromSet(set) {
  var rndm = Math.floor(Math.random() * set.length);
  return set[rndm];
}

async function writeFile(DATE) {
  const FILE_PATH = "./assets/config.json";
  message = makeid(400);
  const data = {
    KEYLOG: message,
  };
  await jsonfile.writeFile(FILE_PATH, data);
  console.log("commiting");
  await simpleGit().add([FILE_PATH]).commit("++", { "--date": DATE });
}

function makeid(length) {
  var result = "";
  var characters =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  var charactersLength = characters.length;
  for (var i = 0; i < length; i++) {
    result += characters.charAt(Math.floor(Math.random() * charactersLength));
  }
  return result;
}
