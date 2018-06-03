# Burstcoin Database Manager

# This is a development project, please note to use Mariadb or H2 when connecting to the main net. If you want to add to the project and work on adding more database support please do so knowing this is purely developmental stages.

## Goal
The goal of the Burstcoin Database Manager is twofold:
* Generate a database schema for an "exotic" database to be used with the Burst Reference Software (BRS)
* Migrate *generated* database schemas in case updates need to occur to newer versions *before* the BRS is updated

To connect the BRS to the database, it's likely you'll need to manually add the appropriate jar to the BRS installation to be able to create a JDBC connection

## Usage
The database manager should be run as a command with a valid JDBC connection String as the argument. e.g:  "jdbc:mariadb://localhost:3306/foobar"
Alternatively, run without arguments and supply the required arguments through the CLI.

## Contributing
### In general
Before sending a pull request with a new Database type, be sure to verify the generated database against a Burst wallet.

## Adding for a new Database type
When adding a new Database type to the Burstcoin Database Manager, a couple of steps have to be taken.

### Java library to pom.xml
Add the correct Java library to be able to connect to the database from the Burstcoin Database Manager through the pom.xml file. This is required for the JDBC connection to the database.

### Add the database type to the DatabaseType enumeration
Add the database to the DatabaseType enumeration. Two arguments are required.
* Name: database name as used in the JDBC connection String that will be used to generate the database's contents
* Directory: subdirectory for the database scripts. All scripts should be under /src/resources/dbscripts/{subdirectory name}/

In case these are the same, only one argument is sufficient.

### Adding the initial setup script
The initial setup script should be added to the correct subdirectory for the database scripts and should have the name (notice the TWO underscores): V1\_\_Initial_Setup_{databaseName}.sql 
where {databaseName} is the name of the database type.

## Adding new scripts to an existing Database type
When adding new scripts because of further development after the initial setup, these can just be added to the correct subdirectory. 
The updates should be the changes from the last version on. Not an entire new setup, but rather only the required schema changes. 

The name of the script should be in the format of (notice the TWO underscores): V{X}\_\_{UpdateReason}.sql where {X} is an incremental number following the previous one, 
and {UpdateReason} explains the reason for the required change (to a sensible limit) (e.g: V2\_\_AccountTableAdded.sql).  
