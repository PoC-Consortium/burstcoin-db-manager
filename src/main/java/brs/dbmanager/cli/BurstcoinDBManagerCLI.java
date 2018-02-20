package brs.dbmanager.cli;

import brs.dbmanager.manager.BurstcoinDBManager;
import brs.dbmanager.manager.impl.BurstcoinDBManagerImpl;
import brs.dbmanager.model.DatabaseConnectionDetails;
import brs.dbmanager.model.DatabaseManagerErrors;
import brs.dbmanager.model.DatabaseType;
import java.util.Scanner;

public class BurstcoinDBManagerCLI {

  private static BurstcoinDBManager burstcoinDBManager = new BurstcoinDBManagerImpl();

  public static void main(String... args) {
    burstcoinDBManager.migrate(collectDetails(args));
  }

  private static DatabaseConnectionDetails collectDetails(String[] args) {
    if (args.length == 0) {
      return queryInformation();
    } else if (args.length == 1) {
      return parseJDBCConnectionString(args[0]);
    } else {
      throw new IllegalArgumentException(DatabaseManagerErrors.TOO_MANY_ARGUMENTS);
    }
  }

  private static DatabaseConnectionDetails queryInformation() {
    final Scanner scanner = new Scanner(System.in);

    System.out.println("Give your JDBC connection URL");
    final String connectionURL = scanner.nextLine();
    validateJDBCConnectionString(connectionURL);
    final DatabaseType databaseType = parseDatabaseType(connectionURL);
    if (databaseType == null) {
      throw new IllegalArgumentException(DatabaseManagerErrors.UNSUPPORTED_DB_TYPE);
    }

    System.out.println("If not specified in the connection URL, give your database username");
    final String username = scanner.nextLine();

    System.out.println("If not specified in the connection URL, give your database password");
    final String password = scanner.nextLine();

    return new DatabaseConnectionDetails(databaseType, connectionURL, username, password);
  }

  private static DatabaseConnectionDetails parseJDBCConnectionString(String jdbcConnectionString) {
    validateJDBCConnectionString(jdbcConnectionString);
    final DatabaseType databaseType = parseDatabaseType(jdbcConnectionString);
    if (databaseType == null) {
      throw new IllegalArgumentException(DatabaseManagerErrors.UNSUPPORTED_DB_TYPE);
    }

    return new DatabaseConnectionDetails(databaseType, jdbcConnectionString, null, null);
  }

  private static void validateJDBCConnectionString(String jdbcConnectionString) {
    if (! jdbcConnectionString.startsWith("jdbc:")) {
      throw new IllegalArgumentException(DatabaseManagerErrors.NOT_A_VALID_JDBC_URL);
    }
  }

  private static DatabaseType parseDatabaseType(String jdbcConnectionString) {
    final String strippedConnectionString = jdbcConnectionString.substring(5);
    if (strippedConnectionString.contains(":")) {
      return DatabaseType.fromName(strippedConnectionString.substring(0, strippedConnectionString.indexOf(":")));
    }

    return null;
  }

}
