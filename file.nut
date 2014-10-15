/**
 * File class is a collection of utility functions dealing with files
 */
class File {

    /**
     * Check if file exists.
     * Params:
     *          path - (string) The path to the file
     * Returns:
     *          (bool) - `true` if file exists, otherwise `false`
     */
    function exists(path) {
        path = fe.path_expand(path);

        print("Checking if " + path + " exists...");

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
