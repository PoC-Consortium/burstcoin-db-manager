package brs.dbmanager.model;

public enum DatabaseType {

  MARIADB("mariadb"), MYSQL("mysql", "mariadb");

  private final String name;
  private final String directory;

  DatabaseType(String nameAndDirectory) {
    this.name = nameAndDirectory;
    this.directory = nameAndDirectory;
  }

  DatabaseType(String name, String directory) {
    this.name = name;
    this.directory = directory;
  }

  public String getDirectory() {
    return directory;
  }

  public static DatabaseType fromName(String name) {
    for(DatabaseType dt: DatabaseType.values()) {
      if(dt.name.equals(name)) {
        return dt;
      }
    }

    return null;
  }
}
