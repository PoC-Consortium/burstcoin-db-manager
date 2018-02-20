package brs.dbmanager.manager.impl;

import brs.dbmanager.manager.BurstcoinDBManager;
import brs.dbmanager.model.DatabaseConnectionDetails;

import org.flywaydb.core.Flyway;

public class BurstcoinDBManagerImpl implements BurstcoinDBManager {

  @Override
  public void migrate(DatabaseConnectionDetails databaseConnectionDetails) {
    System.out.println("Migrating for " + databaseConnectionDetails.toString());

    Flyway flyway = new Flyway();
    flyway.setDataSource(databaseConnectionDetails.getConnectionUrl(), databaseConnectionDetails.getUsername(), databaseConnectionDetails.getPassword());
    flyway.setLocations("/dbscripts/" + databaseConnectionDetails.getDatabaseType().getDirectory());

    flyway.migrate();
  }
}
