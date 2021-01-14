const { logIt, setPrefix } = require("./logit");
logIt("You rock!"); // >> You rock!
setPrefix("++ ");
logIt("You rock!"); // ++ You rock!
