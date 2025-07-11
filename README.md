🛠️ Architecture & Tools Used
📦 Repository Pattern
All data access logic is separated into repositories located under lib/data/repos.
Repositories abstract the SQLite database operations and provide a clean interface for the rest of the app.

🔄 BLoC (Business Logic Component)
State management is handled using the BLoC pattern to ensure a reactive, maintainable flow of data.
Cubits/Blocs reside in the presentation layer, separate from UI and data layers.

💉 Injectable + GetIt
Dependency Injection is managed via injectable and get_it.
Services, repositories, and Blocs are automatically injected via configureDependencies() for clean separation and testability.

🗄️ SQLite with Sqflite
Local data is persisted using the sqflite package.
The DataBaseService in lib/core/service handles initialization, table creation, and CRUD operations.

📸 Screenshots
<table> <tr> <td align="center"><img src="https://github.com/user-attachments/assets/4e92d230-8bb7-4f14-93ca-f67ca490b0a1" width="250"/></td> <td align="center"><img src="https://github.com/user-attachments/assets/89a2dbf6-3cfa-42b2-8ad8-5b91ec552a1c" width="250"/></td> <td align="center"><img src="https://github.com/user-attachments/assets/62101aab-fdec-491e-bfa5-38f049899d07" width="250"/></td> </tr> </table>
