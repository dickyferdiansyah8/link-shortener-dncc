<!DOCTYPE html>
<html>
<head>
    <title>DNCC Link Shortener</title>
    <style>
        body { font-family: sans-serif; text-align: center; margin-top: 100px; }
        input { padding: 10px; width: 300px; }
        button { padding: 10px; cursor: pointer; }
    </style>
</head>
<body>
    <h1>DNCC Link Shortener 🚀</h1>
    <p>Tugas Cloud & DevOps - dikidian</p>
    
    <form action="/shorten" method="POST">
        @csrf
        <input type="url" name="url" placeholder="Paste link panjang di sini..." required>
        <button type="submit">Pendekkan!</button>
    </form>
</body>
</html>