# 🍽️ FoodApp

A dynamic food delivery web application built using **Java**, **JSP**, **Servlets**, **MySQL**, and **Maven**. Deployed on **Apache Tomcat**.

---

## 🚀 Features

- 🔐 User authentication (Login / Register)
- 📦 View delicious food items
- 🛒 Order placement functionality
- 🧑‍💻 Admin controls (optional)
- 📸 File upload support (profile images or menu items)

---

## 🧰 Tech Stack

| Layer       | Tech Used                    |
|-------------|------------------------------|
| Frontend    | HTML, CSS, JSP               |
| Backend     | Java, Servlets               |
| Database    | MySQL                        |
| Build Tool  | Maven                        |
| Server      | Apache Tomcat (v10.x)        |

---

## 📂 Project Structure
FoodApp/
│
├── src/
│ └── main/
│ ├── java/ # Java source files
│ ├── webapp/ # JSP files & frontend assets
│
├── target/ # Build output (ignored)
├── pom.xml # Maven config file
└── .gitignore


---

## 🏁 How to Run

1. **Clone this repo**:
   ```bash
   git clone https://github.com/your-username/FoodApp.git

2. Open in IDE (e.g., IntelliJ or Eclipse)

3. Configure Database:

    - Update DBConnection.java with your MySQL credentials

    - Import foodapp.sql if available (ask project owner)

4. Build with Maven:

    ```bash
    mvn clean install
    ```
5. Deploy on Tomcat:

    - Copy the generated .war from target/ to tomcat/webapps/

    - Start Tomcat and open:
      http://localhost:8080/FoodApp/

## 🙋‍♂️ Author

- **Siva Ganesh** 👨‍💻
  Passionate about Java, full-stack development, and web apps.

Feel free to fork this project or contribute!
