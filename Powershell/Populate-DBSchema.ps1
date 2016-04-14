<#
.Synopsis
	Azure Sql Databases - Dummy Data Population
.DESCRIPTIOn
	This script is used to populate dummy data for use with the WingtipTickets application.
.EXAMPLE
	Populate-DBSchema 'ServerName', 'UserName', 'Password', 'DatabaseName'
.INPUTS
	1. ServerName
		Azure sql database server name for connection.
	2. UserName
		Username for sql database connection.
	3. Password
		Password for sql database connection.
	4. DatabaseName
		Azure Sql Database Name

.OUTPUTS
	By executing this script, you will receive messages regarding success or failure of data Insertion.
.NOTES
	The server name, user name, and password parameters are mandatory.
#>
function Populate-DBSchema
{
	[CmdletBinding()]
	Param
	(
		# Azure SQL server name for connection.
		[Parameter(Mandatory=$true)]
		[String]
		$ServerName,

		# Azure SQL db user name for connection.
		[Parameter(Mandatory=$true)]
		[String]
		$UserName,

		# Azure SQL db password for connection.
		[Parameter(Mandatory=$true)]
		[String]
		$Password,

		# Azure SQL database name.
		[Parameter(Mandatory=$true)]
		[String]
		$DatabaseName
	)

	Process
	{
		Try
		{
			$testSQLConnection = Test-WTTAzureSQLConnection -ServerName $ServerName -UserName $UserName -Password $Password -DatabaseName $DatabaseName -WTTEnvironmentApplicationName $WTTEnvironmentApplicationName
            if ($testSQLConnection -notlike "success")
            {
                WriteError("Unable to connect to SQL Server")
            }
            Else
            {
			    # Build the required connection details
			    $ConnectionString = "Server=tcp:$ServerName.database.windows.net; Database=$DatabaseName; User ID=$UserName; Password=$Password; Trusted_Connection=False; Encrypt=True;"

			    $Connection = New-object system.data.SqlClient.SqlConnection($ConnectionString)
			    $Command = New-Object System.Data.SqlClient.SqlCommand('',$Connection)
                $Command.CommandTimeout = 0

			    # Open the connection to the Database
			    WriteLabel("Connecting to database")
			    $Connection.Open()
			    If(!$Connection)
			    {
				    throw "Failed to Connect $ConnectionString"
			    }
			    WriteValue("Successful")

			    # Clean Tables
			    LineBreak

				WriteLabel("Cleaning ApplicationDefaults table")
				$Command.CommandText = "DELETE FROM ApplicationDefault"
				$Result = $Command.ExecuteNonQuery()
				WriteValue("Successful")
 
			    WriteLabel("Cleaning Customers table")
			    $Command.CommandText = "Delete From Customers"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    WriteLabel("Cleaning Organizers table")
			    $Command.CommandText = "Delete From Organizers"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    WriteLabel("Cleaning SeatSection table")
			    $Command.CommandText = "Delete From SeatSection"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    WriteLabel("Cleaning Venues table")
			    $Command.CommandText = "Delete From Venues"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    WriteLabel("Cleaning City table")
			    $Command.CommandText = "Delete From City"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    WriteLabel("Cleaning States table")
			    $Command.CommandText = "Delete From States"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    WriteLabel("Cleaning Country table")
			    $Command.CommandText = "Delete From Country"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    WriteLabel("Cleaning WebSiteActionLog table")
			    $Command.CommandText = "Delete From WebSiteActionLog"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    WriteLabel("Cleaning Concerts table")
			    $Command.CommandText = "Delete From Concerts"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    WriteLabel("Cleaning Performers table")
			    $Command.CommandText = "Delete From Performers"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    WriteLabel("Cleaning TicketLevels table")
			    $Command.CommandText = "Delete From TicketLevels"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    WriteLabel("Cleaning Tickets table")
			    $Command.CommandText = "Delete From Tickets"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

				# Populate ApplicationDefaults Table
				WriteLabel("Populating ApplicationDefaults table")
				$Command.CommandText =
					"
						SET Identity_Insert [dbo].[ApplicationDefault] ON
						
						INSERT [dbo].[ApplicationDefault] ([ApplicationDefaultId], [Code], [Value]) VALUES (1, 'DefaultReportId', 'a1fb60c9-3cef-4bb4-af2a-5e1b39114214')
						
						SET Identity_Insert [dbo].[ApplicationDefault] OFF
					"

				$Result = $Command.ExecuteNonQuery()
				WriteValue("Successful")

			    # Populate Customers Table
			    $Command.CommandText =
				    "INSERT INTO [dbo].[Customers]([FirstName], [LastName], [Email], [Password]) VALUES 
					    (N'admin', N'admin', N'admin@admin.com', N'P@ssword1'),
					    (N'Mike', N'Flasko', N'mike.flasko@microsoft.com', N'P@ssword1'),
					    (N'Gaurav', N'Malhotra', N'gamal@microsoft.com', N'P@ssword1')
				    "

			    LineBreak
			    WriteLabel("Populating Customers table")
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    # Populate Countries Table
			    WriteLabel("Populating Countries table")
			    $Command.CommandText =
				    "
					    Set Identity_Insert [dbo].[Country] On 
					    Insert [dbo].[Country] ([CountryId], [CountryName], [Description]) Values (1, N'United States', NULL)
					    Set Identity_Insert [dbo].[Country] Off
				    "

			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    # Populate States Table
			    WriteLabel("Populating States table")
			    $Command.CommandText =
				    "
					    Set Identity_Insert [dbo].[States] On
					    Insert [dbo].[States] ([StateId], [StateName], [Description], [CountryId]) Values (1, N'CA', NULL, 1)
					    Insert [dbo].[States] ([StateId], [StateName], [Description], [CountryId]) Values (2, N'CO', NULL, 1)
					    Insert [dbo].[States] ([StateId], [StateName], [Description], [CountryId]) Values (3, N'FL', NULL, 1)
					    Insert [dbo].[States] ([StateId], [StateName], [Description], [CountryId]) Values (4, N'MA', NULL, 1)
					    Insert [dbo].[States] ([StateId], [StateName], [Description], [CountryId]) Values (5, N'MI', NULL, 1)
					    Insert [dbo].[States] ([StateId], [StateName], [Description], [CountryId]) Values (6, N'NY', NULL, 1)
					    Insert [dbo].[States] ([StateId], [StateName], [Description], [CountryId]) Values (7, N'OR', NULL, 1)
					    Insert [dbo].[States] ([StateId], [StateName], [Description], [CountryId]) Values (8, N'TX', NULL, 1)
					    Insert [dbo].[States] ([StateId], [StateName], [Description], [CountryId]) Values (9, N'UT', NULL, 1)
					    Insert [dbo].[States] ([StateId], [StateName], [Description], [CountryId]) Values (10, N'WA', NULL, 1)
					    Set Identity_Insert [dbo].[States] Off
				    "

			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    # Populate City Table
			    WriteLabel("Populating City table")
			    $Command.CommandText =
				    "
					    Set Identity_Insert [dbo].[City] On 
					    Insert [dbo].[City] ([CityId], [CityName], [Description], [StateId]) Values (1, N'Los Angeles', NULL, 1)
					    Insert [dbo].[City] ([CityId], [CityName], [Description], [StateId]) Values (2, N'Denver', NULL, 2)
					    Insert [dbo].[City] ([CityId], [CityName], [Description], [StateId]) Values (3, N'Jacksonville', NULL, 3)
					    Insert [dbo].[City] ([CityId], [CityName], [Description], [StateId]) Values (4, N'Boston', NULL, 4)
					    Insert [dbo].[City] ([CityId], [CityName], [Description], [StateId]) Values (5, N'Detroit', NULL, 5)
					    Insert [dbo].[City] ([CityId], [CityName], [Description], [StateId]) Values (6, N'Syracuse', NULL, 6)
					    Insert [dbo].[City] ([CityId], [CityName], [Description], [StateId]) Values (7, N'Portland', NULL, 7)
					    Insert [dbo].[City] ([CityId], [CityName], [Description], [StateId]) Values (8, N'Austin', NULL, 8)
					    Insert [dbo].[City] ([CityId], [CityName], [Description], [StateId]) Values (9, N'Salt Lake City', NULL, 9)
					    Insert [dbo].[City] ([CityId], [CityName], [Description], [StateId]) Values (10, N'Seattle', NULL, 10)
					    Insert [dbo].[City] ([CityId], [CityName], [Description], [StateId]) Values (11, N'Spokane', NULL, 10)
					    Set Identity_Insert [dbo].[City] Off
				    "

			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    # Populate Venues Table
			    WriteLabel("Populating Venues table")
			    $Command.CommandText =
    				"
	    				Set Identity_Insert [dbo].[Venues] On 
		    			Insert [dbo].[Venues] ([VenueId], [VenueName], [Capacity], [Description], [CityId]) Values (1, N'Conrad Fischer Stands', 1000, N'', 1)
			    		Insert [dbo].[Venues] ([VenueId], [VenueName], [Capacity], [Description], [CityId]) Values (2, N'Hayden Lawrence Gardens', 1000, N'', 2)
				    	Insert [dbo].[Venues] ([VenueId], [VenueName], [Capacity], [Description], [CityId]) Values (3, N'Rene Charron Highrise', 1000, N'', 3)
					    Insert [dbo].[Venues] ([VenueId], [VenueName], [Capacity], [Description], [CityId]) Values (4, N'Aldo Richter Hall', 1000, N'', 4)
					    Insert [dbo].[Venues] ([VenueId], [VenueName], [Capacity], [Description], [CityId]) Values (5, N'Harriet Collier Auditorium', 1000, N'', 5)
					    Insert [dbo].[Venues] ([VenueId], [VenueName], [Capacity], [Description], [CityId]) Values (6, N'Samuel Boyle Center', 1000, N'', 6)
					    Insert [dbo].[Venues] ([VenueId], [VenueName], [Capacity], [Description], [CityId]) Values (7, N'Millie Stevens Memorial Plaza', 1000, N'', 7)
					    Insert [dbo].[Venues] ([VenueId], [VenueName], [Capacity], [Description], [CityId]) Values (8, N'Louisa Zimmerman Stadium', 1000, N'', 8)
					    Insert [dbo].[Venues] ([VenueId], [VenueName], [Capacity], [Description], [CityId]) Values (9, N'Lara Ehrle Amphitheter', 1000, N'', 9)
					    Insert [dbo].[Venues] ([VenueId], [VenueName], [Capacity], [Description], [CityId]) Values (10, N'Antione Lacroix Dome', 1000, N'', 10)
					    Insert [dbo].[Venues] ([VenueId], [VenueName], [Capacity], [Description], [CityId]) Values (11, N'Claude LAngelier Field', 1000, N'', 11)
					    Insert [dbo].[Venues] ([VenueId], [VenueName], [Capacity], [Description], [CityId]) Values (12, N'Maya Haynes Arena', 1000, N'', 10)
					    Set Identity_Insert [dbo].[Venues] Off
				    "

			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    # Populate SeatSection Table
			    WriteLabel("Populating SeatSection table")
			    $Command.CommandText =
				    "
					    Declare @index numeric = 1

						While @index <= 12
						Begin
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (8, @index, N'A1')
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (60, @index, N'A2')
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (8, @index, N'A3')
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (8, @index, N'B1')
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (40, @index, N'B2')
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (40, @index, N'B3')
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (8, @index, N'B4')
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (8, @index, N'C1')
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (40, @index, N'C2')
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (40, @index, N'C3')
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (8, @index, N'C4')
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (50, @index, N'D1')
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (50, @index, N'D2')
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (47, @index, N'E1')
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (47, @index, N'E2')
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (32, @index, N'F1')
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (32, @index, N'F2')
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (202, @index, N'G1')

							Set @index = @index + 1
						End
				    "

			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")
				
				# Populate SeatSectionLayout Table
			    WriteLabel("Populating SeatSectionLayout table")
			    $Command.CommandText =
				    "
					    Declare @indexSection numeric = 1
						Declare @indexConcert numeric = 1

						While @indexConcert <= 12
						Begin

							-- A1
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 0, 1, 0, 1, 4)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 0, 2, 0, 5, 8)

							-- A2
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 1, 1, 0, 1, 20)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 1, 2, 0, 21, 40)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 1, 3, 0, 41, 60)

							-- A3
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 2, 1, 0, 1, 4)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 2, 2, 0, 5, 8)

							-- B1
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 3, 1, 0, 1, 4)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 3, 2, 0, 5, 8)

							-- B2
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 4, 1, 0, 1, 10)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 4, 2, 0, 11, 20)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 4, 3, 0, 21, 30)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 4, 4, 0, 31, 40)

							-- B3
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 5, 1, 0, 1, 10)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 5, 2, 0, 11, 20)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 5, 3, 0, 21, 30)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 5, 4, 0, 31, 40)

							-- B4
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 6, 1, 0, 1, 4)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 6, 2, 0, 5, 8)

							-- C1
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 7, 1, 0, 1, 4)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 7, 2, 0, 5, 8)

							-- C2
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 8, 1, 0, 1, 10)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 8, 2, 0, 11, 20)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 8, 3, 0, 21, 30)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 8, 4, 0, 31, 40)

							-- C3
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 9, 1, 0, 1, 10)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 9, 2, 0, 11, 20)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 9, 3, 0, 21, 30)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 9, 4, 0, 31, 40)

							-- C4
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 10, 1, 0, 1, 4)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 10, 2, 0, 5, 8)

							-- D1
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 11, 1, 0, 1, 10)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 11, 2, 0, 11, 20)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 11, 3, 0, 21, 30)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 11, 4, 0, 31, 40)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 11, 5, 0, 41, 50)

							-- D2
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 12, 1, 0, 1, 10)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 12, 2, 0, 11, 20)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 12, 3, 0, 21, 30)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 12, 4, 0, 31, 40)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 12, 5, 0, 41, 50)

							-- E1
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 13, 1, 0, 1, 10)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 13, 2, 0, 11, 20)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 13, 3, 0, 21, 30)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 13, 4, 1, 31, 39)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 13, 5, 2, 40, 47)

							-- E2
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 14, 1, 0, 1, 10)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 14, 2, 0, 11, 20)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 14, 3, 0, 21, 30)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 14, 4, 0, 31, 39)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 14, 5, 0, 40, 47)

							-- F1
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 15, 1, 0, 1, 7)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 15, 2, 0, 8, 14)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 15, 3, 0, 15, 21)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 15, 4, 1, 22, 27)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 15, 5, 2, 28, 32)

							-- F2
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 16, 1, 0, 1,  7)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 16, 2, 0, 8,  14)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 16, 3, 0, 15, 21)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 16, 4, 0, 22, 27)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 16, 5, 0, 28, 32)

							-- G1
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 17, 1,  4, 1,   15)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 17, 2,  4, 16,  30)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 17, 3,  4, 31,  45)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 17, 4,  2, 46,  64)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 17, 5,  0, 65,  87)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 17, 6,  0, 88,  110)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 17, 7,  0, 111, 133)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 17, 8,  0, 134, 156)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 17, 9,  0, 157, 179)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 17, 10, 0, 180, 202)

							Set @indexConcert = @indexConcert + 1
							Set @indexSection = @indexSection + 18
						End
				    "

			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    # Populate Concerts Table
			    WriteLabel("Populating Concerts table")
			    $Command.CommandText =
				    "
					    Set Identity_Insert [dbo].[Concerts] On 
					    Insert [dbo].[Concerts] ([ConcertId], [ConcertName], [Description], [ConcertDate], [Duration], [VenueId], [PerformerId], [SaveToDbServerType]) Values (1, N'Julie and the Plantes Illumination Tour', N'', Cast(N'2015-01-28 00:54:01.870' AS DateTime), 3, 1, 1, 0)
					    Insert [dbo].[Concerts] ([ConcertId], [ConcertName], [Description], [ConcertDate], [Duration], [VenueId], [PerformerId], [SaveToDbServerType]) Values (2, N'Julie and the Plantes Illumination Tour', N'', Cast(N'2015-01-29 00:54:01.877' AS DateTime), 3, 2, 1, 0)
					    Insert [dbo].[Concerts] ([ConcertId], [ConcertName], [Description], [ConcertDate], [Duration], [VenueId], [PerformerId], [SaveToDbServerType]) Values (3, N'Julie and the Plantes Illumination Tour', N'', Cast(N'2015-01-30 00:54:01.880' AS DateTime), 3, 3, 1, 0)
					    Insert [dbo].[Concerts] ([ConcertId], [ConcertName], [Description], [ConcertDate], [Duration], [VenueId], [PerformerId], [SaveToDbServerType]) Values (4, N'Julie and the Plantes Illumination Tour', N'', Cast(N'2015-01-31 00:54:01.887' AS DateTime), 3, 4, 1, 0)
					    Insert [dbo].[Concerts] ([ConcertId], [ConcertName], [Description], [ConcertDate], [Duration], [VenueId], [PerformerId], [SaveToDbServerType]) Values (5, N'Julie and the Plantes Illumination Tour', N'', Cast(N'2015-02-01 00:54:01.890' AS DateTime), 3, 5, 1, 0)
					    Insert [dbo].[Concerts] ([ConcertId], [ConcertName], [Description], [ConcertDate], [Duration], [VenueId], [PerformerId], [SaveToDbServerType]) Values (6, N'Julie and the Plantes Illumination Tour', N'', Cast(N'2015-02-02 00:54:01.893' AS DateTime), 3, 6, 1, 0)
					    Insert [dbo].[Concerts] ([ConcertId], [ConcertName], [Description], [ConcertDate], [Duration], [VenueId], [PerformerId], [SaveToDbServerType]) Values (7, N'Julie and the Plantes Illumination Tour', N'', Cast(N'2015-02-03 00:54:01.897' AS DateTime), 3, 7, 1, 0)
					    Insert [dbo].[Concerts] ([ConcertId], [ConcertName], [Description], [ConcertDate], [Duration], [VenueId], [PerformerId], [SaveToDbServerType]) Values (8, N'Julie and the Plantes Illumination Tour', N'', Cast(N'2015-02-04 00:54:01.900' AS DateTime), 3, 8, 1, 0)
					    Insert [dbo].[Concerts] ([ConcertId], [ConcertName], [Description], [ConcertDate], [Duration], [VenueId], [PerformerId], [SaveToDbServerType]) Values (9, N'Julie and the Plantes Illumination Tour', N'', Cast(N'2015-02-05 00:54:01.903' AS DateTime), 3, 9, 1, 0)
					    Insert [dbo].[Concerts] ([ConcertId], [ConcertName], [Description], [ConcertDate], [Duration], [VenueId], [PerformerId], [SaveToDbServerType]) Values (10, N'Julie and the Plantes Illumination Tour', N'', Cast(N'2015-02-06 00:54:01.907' AS DateTime), 3, 10, 1, 0)
					    Insert [dbo].[Concerts] ([ConcertId], [ConcertName], [Description], [ConcertDate], [Duration], [VenueId], [PerformerId], [SaveToDbServerType]) Values (11, N'Julie and the Plantes Illumination Tour', N'', Cast(N'2015-02-07 00:54:01.910' AS DateTime), 3, 11, 1, 0)
					    Insert [dbo].[Concerts] ([ConcertId], [ConcertName], [Description], [ConcertDate], [Duration], [VenueId], [PerformerId], [SaveToDbServerType]) Values (12, N'Julie and the Plantes Illumination Tour', N'', Cast(N'2015-02-08 00:54:01.910' AS DateTime), 3, 12, 1, 0)
					    Set Identity_Insert [dbo].[Concerts] Off
				    "

			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    # Populate Performers Table
			    WriteLabel("Populating Performers table")
			    $Command.CommandText =
				    "
					    SET IDENTITY_INSERT [dbo].[Performers] ON 
					    INSERT [dbo].[Performers] ([PerformerId], [FirstName], [LastName], [Skills], [ContactNbr], [ShortName]) VALUES (1, N'Julie', N'Plantes', N'PopMusic', CAST(1234567891 AS Numeric(15, 0)), N'Julie and the Plantes')                
					    SET IDENTITY_INSERT [dbo].[Performers] OFF
				    "

			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    # Populate TicketLevels Table
			    WriteLabel("Populating TicketLevels table")
			    $Command.CommandText =
				    "
						Declare @indexSection numeric = 1
						Declare @indexConcert numeric = 1

						While @indexConcert <= 12
						Begin

							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 1', 'Section A1 - $95.00', @indexSection + 0, @indexConcert, 95)
							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 1', 'Section A2 - $100.00', @indexSection + 1, @indexConcert, 100)
							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 1', 'Section A3 - $95.00', @indexSection + 2, @indexConcert, 95)
																																						 
							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 2', 'Section B1 - $75.00', @indexSection + 3, @indexConcert, 75)
							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 2', 'Section B2 - $80.00', @indexSection + 4, @indexConcert, 80)
							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 2', 'Section B3 - $80.00', @indexSection + 5, @indexConcert, 80)
							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 2', 'Section B4 - $75.00', @indexSection + 6, @indexConcert, 75)
																																						 
							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 3', 'Section C1 - $65.00', @indexSection + 7, @indexConcert, 65)
							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 3', 'Section C2 - $70.00', @indexSection + 8, @indexConcert, 70)
							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 3', 'Section C3 - $70.00', @indexSection + 9, @indexConcert, 70)
							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 3', 'Section C4 - $65.00', @indexSection + 10, @indexConcert, 65)
																																						 
							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 4', 'Section D1 - $55.00', @indexSection + 11, @indexConcert, 55)
							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 4', 'Section D2 - $55.00', @indexSection + 12, @indexConcert, 55)
																																						 
							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 5', 'Section E1 - $50.00', @indexSection + 13, @indexConcert, 50)
							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 5', 'Section E2 - $50.00', @indexSection + 14, @indexConcert, 50)
																																						 
							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 6', 'Section F1 - $45.00', @indexSection + 15, @indexConcert, 45)
							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 6', 'Section F2 - $45.00', @indexSection + 16, @indexConcert, 45)
																																						 
							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 7', 'Section G1 - $30.00', @indexSection + 17, @indexConcert, 30)	

							Set @indexConcert = @indexConcert + 1
							Set @indexSection = @indexSection + 18
						End
				    "

			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")
        }
    }
	    Catch 
	    { 
	        WriteError("$Error")
	    }
	    Finally
	    {
	        $Command = $null
		    $ConnectionString = $null

		    if ($Connection -ne $null -and $Connection.State -eq "Open") 
		    { 
		        $Connection.close(); 
			    $Connection = $null; 
		    }
	    }
    }
}