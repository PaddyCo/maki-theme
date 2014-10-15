class File {
    function exists(path) {
        try {
            file(path, "r");
        } catch(exception) {
            if (exception != "cannot open file") {
                print("Could not check " + path + ", threw exception: " + exception + "\n");
            }

            return false;
        }

        return true;
    }
}
