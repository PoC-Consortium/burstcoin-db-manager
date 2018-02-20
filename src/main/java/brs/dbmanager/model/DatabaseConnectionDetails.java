package brs.dbmanager.model;

public class DatabaseConnectionDetails {
  private DatabaseType databaseType;
  private String connectionUrl;
  private String username;
  private String password;

  public DatabaseConnectionDetails(DatabaseType databaseType, String connectionUrl, String username, String password) {
    this.databaseType = databaseType;
    this.connectionUrl = connectionUrl;
    this.username = username;
    this.password = password;
  }

  public DatabaseType getDatabaseType() {
    return databaseType;
  }

  public String getConnectionUrl() {
    return connectionUrl;
  }

  public String getUsername() {
    return username;
  }

  public String getPassword() {
    return password;
  }

  @Override
  public String toString() {
    return "DatabaseConnectionDetails{" +
        "databaseType=" + databaseType +
        ", connectionUrl='" + connectionUrl + '\'' +
        ", username='" + username + '\'' +
        ", password='" + password + '\'' +
        '}';
  }
}
