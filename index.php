<?php
require "db.php";
$error = "";

if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $result = run("SELECT * FROM users WHERE username = ?", "s", [$_POST['username']]);
    $user = mysqli_fetch_assoc($result);

    if ($user && $user['role'] == "admin") {
        $error = "Admins must log in on the admin login page.";
    } elseif ($user && password_verify($_POST['password'], $user['password'])) {
        $_SESSION['user_id'] = $user['id'];
        $_SESSION['name'] = $user['name'];
        $_SESSION['role'] = $user['role'];

        if ($user['role'] == "staff") {
            header("Location: checkin.php");
        } else {
            header("Location: dashboard.php");
        }
        exit;
    } else {
        $error = "Wrong username or password.";
    }
}
?>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Staff Login - eventSched&Attendance</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="login">
  <h2>eventSched&amp;Attendance</h2>
  <p><b>Staff / Organizer Login</b></p>
  <form method="post">
    <label>Username <input type="text" name="username" required></label>
    <label>Password <input type="password" name="password" required></label>
    <p class="bad"><?php echo e($error); ?></p>
    <button type="submit">Log in</button>
  </form>
  <p><a href="admin_login.php">Admin login</a></p>
</div>
</body>
</html>