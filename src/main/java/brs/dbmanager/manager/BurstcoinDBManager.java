package brs.dbmanager.manager;

import brs.dbmanager.model.DatabaseConnectionDetails;

public interface BurstcoinDBManager {

  void migrate(DatabaseConnectionDetails databaseConnectionDetails);

}
